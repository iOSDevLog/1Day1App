//
//  ViewController.h
//  SliderControl
//
//  Created by iOS Dev Log on 2018/3/27.
//  Copyright © 2018年 iOSDevLog. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SliderControl;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet SliderControl *knobControl;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UISlider *valueSlider;
@property (weak, nonatomic) IBOutlet UISwitch *animateSwitch;

@end

