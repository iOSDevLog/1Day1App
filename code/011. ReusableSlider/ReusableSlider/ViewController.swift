//
//  ViewController.swift
//  ReusableSlider
//
//  Created by iOS Dev Log on 2018/3/26.
//  Copyright © 2018年 iOSDevLog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let rangeSlider = RangeSlider(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(rangeSlider)
        
        rangeSlider.addTarget(self, action: #selector(rangeSliderValueChanged(rangeSlider:)), for: .valueChanged)
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.rangeSlider.trackHighlightTintColor = UIColor.red
            self.rangeSlider.curvaceousness = 0.0
        }
    }
    
    override func viewDidLayoutSubviews() {
        let margin: CGFloat = 20.0
        let width = view.bounds.width - 2.0 * margin
        rangeSlider.frame = CGRect(x: margin, y: margin +  self.view.safeAreaLayoutGuide.layoutFrame.origin.y,
                                   width: width, height: 31.0)
    }
    
    @objc
    func rangeSliderValueChanged(rangeSlider: RangeSlider) {
        print("Range slider value changed: (\(rangeSlider.lowerValue) \(rangeSlider.upperValue))")
    }
}

