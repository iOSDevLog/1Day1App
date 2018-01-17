//
//  IDGMoveable.swift
//  IDGMoveable
//
//  Created by iOS Dev Log on 2018/1/17.
//  Copyright © 2018年 iOSDevLog. All rights reserved.
//

import UIKit

@objc protocol IDLMoveableCellTableViewDataSource  {
    // original datasource
    func dataSourceArray(in tableView: UITableView) -> [Any]
    
    // exchanged datasource
    func tableView(_ tableView: UITableView, newDataSourceArrayAfterMove newDataSourceArray: [Any])
}

@objc protocol IDLMoveableCellTableViewDelegate {
    func tableView(_ tableView: UITableView, willMoveCellAt indexPath: IndexPath)
    func tableView(_ tableView: UITableView, didMoveCellFrom fromIndexPath: IndexPath, to toIndexPath: IndexPath)
    func tableView(_ tableView: UITableView, endMoveCellAt indexPath: IndexPath)
    func tableView(_ tableView: UITableView, drawMovealbeCell: UIView)
}

@IBDesignable extension UITableView {
    
    private struct IDLConstraint {
        static let kIDLMoveableCellAnimationTime: TimeInterval = 0.25
        static let kIDLMinimumPressDuration: CGFloat = 0.2
        static let kIDLEdgeScrollRange: CGFloat = 150
    }
    
    private struct IDLAssociatedKeys {
        static var iDLDataSourceName: String?
        static var iDLMoveableDelegateName: String?
        static var iDLGestureMinimumPressDurationName: String?
        static var iDLGestureName: String?
        static var iDLTempViewName: String?
        static var iDLEdgeScrollTimerName: String?
        static var iDLSelectedIndexPathName: String?
        static var iDLEdgeScrollRangeName: String?
        static var iDLIsCanEdgeScrollName: String?
        static var iDLMoveableDataSourceName: String?
        static var iDLDrawMovalbeCellBlockName: String?
    }
    
    // MARK: - outlet
    @IBOutlet var moveableDataSource: IDLMoveableCellTableViewDataSource? {
        get {
            return objc_getAssociatedObject(self, &IDLAssociatedKeys.iDLDataSourceName) as? IDLMoveableCellTableViewDataSource
        }
        set {
            iDLInitData()
            iDLAddGesture()
            objc_setAssociatedObject(self, &IDLAssociatedKeys.iDLDataSourceName, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    @IBOutlet var  moveableDelegate: IDLMoveableCellTableViewDelegate? {
        get {
            return objc_getAssociatedObject(self, &IDLAssociatedKeys.iDLMoveableDelegateName) as? IDLMoveableCellTableViewDelegate
        }
        set {
            objc_setAssociatedObject(self, &IDLAssociatedKeys.iDLMoveableDelegateName, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    
    // MARK: - inspectable
    // trigger moveable long press duration
    @IBInspectable var gestureMinimumPressDuration: CGFloat {
        get {
            let gestureMinimumPressDuration = (objc_getAssociatedObject(self, &IDLAssociatedKeys.iDLGestureMinimumPressDurationName))
            if let gestureMinimumPressDuration = gestureMinimumPressDuration as? NSNumber {
                return CGFloat(gestureMinimumPressDuration.floatValue)
            } else {
                return IDLConstraint.kIDLMinimumPressDuration
            }
        }
        set {
            let minimumPressDuration: CGFloat = newValue > IDLConstraint.kIDLMinimumPressDuration ? newValue : IDLConstraint.kIDLMinimumPressDuration
            let minimumPressDurationNumber =  NSNumber.init(value: CFTimeInterval(minimumPressDuration))
            objc_setAssociatedObject(self, &IDLAssociatedKeys.iDLGestureMinimumPressDurationName, minimumPressDurationNumber, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    // edge scroll enable
    @IBInspectable var isCanEdgeScroll: Bool {
        get {
            let canEdgeScroll = (objc_getAssociatedObject(self, &IDLAssociatedKeys.iDLIsCanEdgeScrollName)) as? NSNumber
            if let canEdgeScroll = canEdgeScroll {
                return canEdgeScroll.boolValue
            } else {
                return true
            }
        }
        set {
            objc_setAssociatedObject(self, &IDLAssociatedKeys.iDLIsCanEdgeScrollName, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    // edge scroll distance
    @IBInspectable var edgeScrollRange: CGFloat {
        get {
            let scrollRange = (objc_getAssociatedObject(self, &IDLAssociatedKeys.iDLEdgeScrollRangeName)) as? NSNumber
            if let scrollRange = scrollRange {
                return CGFloat(scrollRange.floatValue)
            } else {
                return IDLConstraint.kIDLEdgeScrollRange
            }
        }
        set {
            let scrollRange: CGFloat = newValue > IDLConstraint.kIDLEdgeScrollRange ? newValue : IDLConstraint.kIDLEdgeScrollRange
            objc_setAssociatedObject(self, &IDLAssociatedKeys.iDLEdgeScrollRangeName,  scrollRange, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    // MARK: - private
    private var _iDLSelectedIndexPath: IndexPath? {
        get {
            return objc_getAssociatedObject(self, &IDLAssociatedKeys.iDLSelectedIndexPathName) as? IndexPath
        }
        set {
            objc_setAssociatedObject(self, &IDLAssociatedKeys.iDLSelectedIndexPathName, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    private var _iDLEdgeScrollTimer: CADisplayLink? {
        get {
            return objc_getAssociatedObject(self, &IDLAssociatedKeys.iDLEdgeScrollTimerName) as? CADisplayLink
        }
        set {
            objc_setAssociatedObject(self, &IDLAssociatedKeys.iDLEdgeScrollTimerName, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    private var _iDLTempView: UIView? {
        get {
            return objc_getAssociatedObject(self, &IDLAssociatedKeys.iDLTempViewName) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &IDLAssociatedKeys.iDLTempViewName, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    private var _iDLMoveableDataSource: [Any]! {
        get {
            return (objc_getAssociatedObject(self, &IDLAssociatedKeys.iDLMoveableDataSourceName) as?  [Any])
        }
        set {
            objc_setAssociatedObject(self, &IDLAssociatedKeys.iDLMoveableDataSourceName, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    private var _iDLGesture: UILongPressGestureRecognizer? {
        get {
            return objc_getAssociatedObject(self, &IDLAssociatedKeys.iDLGestureName) as? UILongPressGestureRecognizer
        }
        set {
            objc_setAssociatedObject(self, &IDLAssociatedKeys.iDLGestureName, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    // MARK: - helper function
    private func iDLInitData() {
        if (gestureMinimumPressDuration < IDLConstraint.kIDLMinimumPressDuration) {
            gestureMinimumPressDuration = 0.2
        }
        edgeScrollRange = 150.0
    }
    
    private func iDLAddGesture() {
        _iDLGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.iDLProcessGesture))
        _iDLGesture?.minimumPressDuration = CFTimeInterval(gestureMinimumPressDuration)
        addGestureRecognizer(_iDLGesture!)
    }
    
    @objc
    private func iDLProcessGesture(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            iDLGestureBegan(gesture)
        case .changed:
            if !isCanEdgeScroll {
                iDLGestureChanged(gesture)
            }
        case .ended, .cancelled:
            iDLGestureEndedOrCancelled(gesture)
        default:
            break
        }
    }
    
    // remember selectedIndex and snapshot selected cell
    private func iDLGestureBegan(_ gesture: UILongPressGestureRecognizer) {
        let point: CGPoint = gesture.location(in: gesture.view)
        let selectedIndexPath: IndexPath? = indexPathForRow(at: point)
        if selectedIndexPath == nil {
            return
        }
        
        moveableDelegate?.tableView(self, willMoveCellAt: selectedIndexPath!)
        
        if isCanEdgeScroll {
            iDLStartEdgeScroll()
        }
        
        self._iDLMoveableDataSource = (moveableDataSource?.dataSourceArray(in: self))!
        
        self._iDLSelectedIndexPath = selectedIndexPath
        let cell: UITableViewCell? = cellForRow(at: selectedIndexPath ?? IndexPath(row: 0, section: 0))
        _iDLTempView = iDLSnapshotView(withInputView: cell!)
        
        self.moveableDelegate?.tableView(self, drawMovealbeCell: _iDLTempView!)
        
        _iDLTempView?.frame = cell!.frame
        addSubview(_iDLTempView!)

        cell?.isHidden = true
        UIView.animate(withDuration: IDLConstraint.kIDLMoveableCellAnimationTime, animations: {() -> Void in
            self._iDLTempView?.center = CGPoint(x: (self._iDLTempView?.center.x)!, y: point.y)
        })
    }
    
    private func iDLGestureChanged(_ gesture: UILongPressGestureRecognizer) {
        let point: CGPoint = gesture.location(in: gesture.view)
        let currentIndexPath: IndexPath? = indexPathForRow(at: point)
        if (currentIndexPath != nil) && (self._iDLSelectedIndexPath != currentIndexPath) {
            // exchange datasource and cell
            iDLUpdateDataSourceAndCell(from: self._iDLSelectedIndexPath!, to: currentIndexPath!)
            
            moveableDelegate?.tableView(self, didMoveCellFrom: self._iDLSelectedIndexPath!, to: currentIndexPath!)
            self._iDLSelectedIndexPath = currentIndexPath
        }
        // view's screenshot move with gesture
        _iDLTempView?.center = CGPoint(x: (_iDLTempView?.center.x)!, y: point.y)
    }
    
    // update datasource and remove snapshot
    private func iDLGestureEndedOrCancelled(_ gesture: UILongPressGestureRecognizer) {
        if isCanEdgeScroll {
            iDLStopEdgeScroll()
        }
        // exchanged datasource
        moveableDataSource?.tableView(self, newDataSourceArrayAfterMove: self._iDLMoveableDataSource)
        moveableDelegate?.tableView(self, endMoveCellAt: self._iDLSelectedIndexPath!)
        if let cell = cellForRow(at: self._iDLSelectedIndexPath ?? IndexPath(row: 0, section: 0)) {
            UIView.animate(withDuration: IDLConstraint.kIDLMoveableCellAnimationTime, animations: {() -> Void in
                self._iDLTempView?.frame = (cell.frame)
            }, completion: {(_ finished: Bool) -> Void in
                cell.isHidden = false
                self._iDLTempView?.removeFromSuperview()
                self._iDLTempView = nil
            })
        }
    }
    
    private func iDLSnapshotView(withInputView inputView: UIView) -> UIView {
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0)
        inputView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let snapshot: UIView? = UIImageView(image: image)
        return snapshot ?? UIView()
    }
    
    private func iDLUpdateDataSourceAndCell(from fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        if numberOfSections == 1 {
            // only 1 section
            let fromData = self._iDLMoveableDataSource[fromIndexPath.row]
            let toData = self._iDLMoveableDataSource[toIndexPath.row]
            self._iDLMoveableDataSource[fromIndexPath.row]  = toData
            self._iDLMoveableDataSource[toIndexPath.row] = fromData
            beginUpdates()
            moveRow(at: fromIndexPath, to: toIndexPath)
            moveRow(at: toIndexPath, to: fromIndexPath)
            endUpdates()
        } else if (fromIndexPath.section == toIndexPath.section) {
            // same section
            var changeArray = _iDLMoveableDataSource[fromIndexPath.section] as! [Any]
            let fromData = changeArray[fromIndexPath.row]
            let toData = changeArray[toIndexPath.row]
            changeArray[toIndexPath.row] = fromData
            changeArray[fromIndexPath.row] = toData
            _iDLMoveableDataSource[fromIndexPath.section] = changeArray
            
            beginUpdates()
            moveRow(at: fromIndexPath, to: toIndexPath)
            moveRow(at: toIndexPath, to: fromIndexPath)
            endUpdates()
        } else {
            // different section
            var fromArray = _iDLMoveableDataSource[fromIndexPath.section] as! [Any]
            var toArray = _iDLMoveableDataSource[toIndexPath.section] as! [Any]
            let fromData = fromArray[fromIndexPath.row]
            let toData = toArray[toIndexPath.row]
            fromArray[fromIndexPath.row] = toData
            toArray[toIndexPath.row] = fromData
            _iDLMoveableDataSource[fromIndexPath.section] = fromArray
            _iDLMoveableDataSource[toIndexPath.section] = toArray
            
            beginUpdates()
            moveRow(at: fromIndexPath, to: toIndexPath)
            moveRow(at: toIndexPath, to: fromIndexPath)
            endUpdates()
        }
    }
    
    // MARK: - EdgeScroll
    private func iDLStartEdgeScroll() {
        _iDLEdgeScrollTimer = CADisplayLink(target: self, selector: #selector(self.iDLProcessEdgeScroll))
        _iDLEdgeScrollTimer?.add(to: RunLoop.main, forMode: .commonModes)
    }
    
    @objc private func iDLProcessEdgeScroll() {
        iDLGestureChanged(_iDLGesture!)
        let minOffsetY: CGFloat = contentOffset.y + edgeScrollRange
        let maxOffsetY: CGFloat = contentOffset.y + bounds.size.height - edgeScrollRange
        let touchPoint: CGPoint = _iDLTempView!.center
        
        if touchPoint.y < edgeScrollRange {
            if contentOffset.y <= 0 {
                return
            } else {
                if contentOffset.y - 1 < 0 {
                    return
                }
                setContentOffset(CGPoint(x: contentOffset.x, y: contentOffset.y - 1), animated: false)
                _iDLTempView?.center = CGPoint(x: (_iDLTempView?.center.x)!, y: (_iDLTempView?.center.y)! - 1)
            }
        }
        
        if touchPoint.y > contentSize.height - edgeScrollRange {
            if contentOffset.y >= contentSize.height - bounds.size.height {
                return
            } else {
                if contentOffset.y + 1 > contentSize.height - bounds.size.height {
                    return
                }
                setContentOffset(CGPoint(x: contentOffset.x, y: contentOffset.y + 1), animated: false)
                _iDLTempView?.center = CGPoint(x: (_iDLTempView?.center.x)!, y: (_iDLTempView?.center.y)! + 1)
            }
        }
        
        // move
        let maxMoveDistance: CGFloat = 20
        if touchPoint.y < minOffsetY {
            // move up
            let moveDistance: CGFloat = (minOffsetY - touchPoint.y) / edgeScrollRange * maxMoveDistance
            setContentOffset(CGPoint(x: contentOffset.x, y: contentOffset.y - moveDistance), animated: false)
            _iDLTempView?.center = CGPoint(x: (_iDLTempView?.center.x)!, y: (_iDLTempView?.center.y)! - moveDistance)
        } else if touchPoint.y > maxOffsetY {
            // move down
            let moveDistance: CGFloat = (touchPoint.y - maxOffsetY) / edgeScrollRange * maxMoveDistance
            setContentOffset(CGPoint(x: contentOffset.x, y: contentOffset.y + moveDistance), animated: false)
            _iDLTempView?.center = CGPoint(x: (_iDLTempView?.center.x)!, y: (_iDLTempView?.center.y)! + moveDistance)
        }
    }
    
    private func iDLStopEdgeScroll() {
        if (_iDLEdgeScrollTimer != nil) {
            _iDLEdgeScrollTimer?.invalidate()
            _iDLEdgeScrollTimer = nil
        }
    }
}
