//
//  DrawView.swift
//  MNIST
//
//  Created by ios dev on 2018/5/11.
//  Copyright © 2018年 iOSDevLog. All rights reserved.
//

import UIKit

class DrawView: UIView {
    // some parameters of how thick a line to draw 15 seems to work
    // and we have white drawings on black background just like MNIST needs its input
    var linewidth = CGFloat(15) { didSet { setNeedsDisplay() } }
    var color = UIColor.white { didSet { setNeedsDisplay() } }
    
    // we will keep touches made by user in view in these as a record so we can draw them.
    var lines: [Line] = []
    var lastPoint: CGPoint!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastPoint = touches.first!.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let newPoint = touches.first!.location(in: self)
        // keep all lines drawn by user as touch in record so we can draw them in view
        lines.append(Line(start: lastPoint, end: newPoint))
        lastPoint = newPoint
        // make a draw call
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let drawPath = UIBezierPath()
        drawPath.lineCapStyle = .round
        
        for line in lines{
            drawPath.move(to: line.start)
            drawPath.addLine(to: line.end)
        }
        
        drawPath.lineWidth = linewidth
        color.set()
        drawPath.stroke()
    }

    func getViewContext() -> CGContext? {
        // our network takes in only grayscale images as input
        let colorSpace:CGColorSpace = CGColorSpaceCreateDeviceGray()
        
        // we have 3 channels no alpha value put in the network
        let bitmapInfo = CGImageAlphaInfo.none.rawValue
        
        // this is where our view pixel data will go in once we make the render call
        let context = CGContext(data: nil, width: 28, height: 28, bitsPerComponent: 8, bytesPerRow: 28, space: colorSpace, bitmapInfo: bitmapInfo)
        
        // scale and translate so we have the full digit and in MNIST standard size 28x28
        context!.translateBy(x: 0 , y: 28)
        context!.scaleBy(x: 28/self.frame.size.width, y: -28/self.frame.size.height)
        
        // put view pixel data in context
        self.layer.render(in: context!)
        
        return context
    }
}

class Line{
    var start: CGPoint
    var end: CGPoint
    
    init(start: CGPoint, end: CGPoint) {
        self.start = start
        self.end   = end
    }
}
