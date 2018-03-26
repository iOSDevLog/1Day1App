//
//  RangeSliderKnobLayer.h
//  CustomSlider
//
//  Created by iOS Dev Log on 2018/3/26.
//  Copyright © 2018年 iOSDevLog. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@class RangeSlider;

@interface RangeSliderKnobLayer : CALayer

@property BOOL highlighted;
@property (weak) RangeSlider* slider;

@end
