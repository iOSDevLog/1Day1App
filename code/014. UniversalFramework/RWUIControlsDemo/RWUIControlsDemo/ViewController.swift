//
//  ViewController.swift
//  RWUIControlsDemo
//
//  Created by iOS Dev Log on 2018/3/28.
//  Copyright © 2018年 iOSDevLog. All rights reserved.
//

import UIKit
import RWUIControlsFramework

class ViewController: UIViewController {
    @IBOutlet weak var ribbonView: RWRibbonView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var knobControl: RWKnobControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up config on RWKnobControl
        knobControl.lineWidth = 5
        knobControl.minimumValue = CGFloat(-Double.pi/4)
        knobControl.maximumValue = CGFloat(Double.pi/4)
        knobControl.addTarget(self, action: #selector(rotationAngleChanged(_:)), for: .valueChanged)
    
        let iv = UIImageView(frame: imageView?.bounds ?? CGRect.zero)
        iv.image = #imageLiteral(resourceName: "sampleImage")
        iv.contentMode = .scaleAspectFit
        ribbonView?.addSubview(iv)

    }

    @objc
    func rotationAngleChanged(_ sender: Any?) {
        imageView?.transform = CGAffineTransform(rotationAngle: knobControl.value)
    }
}

