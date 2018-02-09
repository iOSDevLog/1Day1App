//
//  SettingsViewController.swift
//  AIDraw
//
//  Created by iOS Dev Log on 2018/2/9.
//  Copyright © 2018年 iOSDevLog. All rights reserved.
//

import UIKit
protocol SettingsViewControllerDelegate: class {
    func settingsViewControllerFinished(_ settingsViewController: SettingsViewController)
}
class SettingsViewController: UIViewController {

    @IBOutlet weak var sliderBrush: UISlider!
    @IBOutlet weak var sliderOpacity: UISlider!
    
    @IBOutlet weak var imageViewBrush: UIImageView!
    @IBOutlet weak var imageViewOpacity: UIImageView!
    
    @IBOutlet weak var labelBrush: UILabel!
    @IBOutlet weak var labelOpacity: UILabel!
    
    @IBOutlet weak var sliderRed: UISlider!
    @IBOutlet weak var sliderGreen: UISlider!
    @IBOutlet weak var sliderBlue: UISlider!
    
    @IBOutlet weak var labelRed: UILabel!
    @IBOutlet weak var labelGreen: UILabel!
    @IBOutlet weak var labelBlue: UILabel!
    
    var brush: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    
    weak var delegate: SettingsViewControllerDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sliderBrush.value = Float(brush)
        labelBrush.text = String(format: "%.1f", brush.native)
        sliderOpacity.value = Float(opacity)
        labelOpacity.text = String(format: "%.1f", opacity.native)
        sliderRed.value = Float(red)
        labelRed.text = String(format: "%d", Int(sliderRed.value))
        sliderGreen.value = Float(green)
        labelGreen.text = String(format: "%d", Int(sliderGreen.value))
        sliderBlue.value = Float(blue)
        labelBlue.text = String(format: "%d", Int(sliderBlue.value))
        
        drawPreview()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.delegate?.settingsViewControllerFinished(self)
    }
    
    @IBAction func colorChanged(_ sender: UISlider) {
        red = CGFloat(sliderRed.value / 255.0)
        labelRed.text = String(format: "%d", Int(sliderRed.value))
        green = CGFloat(sliderGreen.value / 255.0)
        labelGreen.text = String(format: "%d", Int(sliderGreen.value))
        blue = CGFloat(sliderBlue.value / 255.0)
        labelBlue.text = String(format: "%d", Int(sliderBlue.value))
        
        drawPreview()
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        if sender == sliderBrush {
            brush = CGFloat(sender.value)
            labelBrush.text = String(format: "%.2f", brush.native)
        } else {
            opacity = CGFloat(sender.value)
            labelOpacity.text = String(format: "%.2f", opacity.native)        }
        
        drawPreview()
    }
    
    func drawPreview() {
        UIGraphicsBeginImageContext(imageViewBrush.frame.size)
        var context = UIGraphicsGetCurrentContext()
        
        context?.setLineCap(.round)
        context?.setLineWidth(brush)
        
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
        context?.move(to: CGPoint(x: 45.0, y: 45.0))
        context?.addLine(to: CGPoint(x: 45.0, y: 45.0))
        context?.strokePath()
        imageViewBrush.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIGraphicsBeginImageContext(imageViewOpacity.frame.size)
        context = UIGraphicsGetCurrentContext()
        
        context?.setLineCap(.round)
        context?.setLineWidth(20)
        
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: opacity)
        context?.move(to: CGPoint(x: 45.0, y: 45.0))
        context?.addLine(to: CGPoint(x: 45.0, y: 45.0))
        context?.strokePath()
        imageViewOpacity.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
    }
}
