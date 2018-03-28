//
//  ViewController.swift
//  SwiftImageView
//
//  Created by iOS Dev Log on 2018/3/28.
//  Copyright © 2018年 iOSDevLog. All rights reserved.
//

import UIKit
import OCFramework

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var knobControl: RWKnobControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up config on RWKnobControl
        knobControl.lineWidth = 5
        knobControl.minimumValue = CGFloat(-Double.pi/4)
        knobControl.maximumValue = CGFloat(Double.pi/4)
        knobControl.addTarget(self, action: #selector(rotationAngleChanged(_:)), for: .valueChanged)

    }

    @objc
    func rotationAngleChanged(_ sender: Any?) {
        imageView?.transform = CGAffineTransform(rotationAngle: knobControl.value)
    }

}

