//
//  RangeSlider.h
//  CustomSlider
//
//  Created by iOS Dev Log on 2018/3/26.
//  Copyright © 2018年 iOSDevLog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RangeSlider : UIControl

@property (nonatomic) float maximumValue;
@property (nonatomic) float minimumValue;
@property (nonatomic) float upperValue;
@property (nonatomic) float lowerValue;

@property (nonatomic) float curvatiousness;
@property (nonatomic) UIColor* trackColour;
@property (nonatomic) UIColor* trackHighlightColour;
@property (nonatomic) UIColor* knobColour;
@property (nonatomic) float curvaceousness;

- (float) positionForValue:(float)value;

@end
