//
//  RotationGestureRecognizer.m
//  SliderControl
//
//  Created by iOS Dev Log on 2018/3/27.
//  Copyright © 2018年 iOSDevLog. All rights reserved.
//

#import "RotationGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation RotationGestureRecognizer

- (id)initWithTarget:(id)target action:(SEL)action
{
    self = [super initWithTarget:target action:action];
    if(self) {
        self.maximumNumberOfTouches = 1;
        self.minimumNumberOfTouches = 1;
    }
    return self;
}

#pragma mark - Gesture recognizer method overrides
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self updateTouchAngleWithTouches:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    [self updateTouchAngleWithTouches:touches];
}

#pragma mark - Utility methods
- (void)updateTouchAngleWithTouches:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    
    self.touchAngle = [self calculateAngleToPoint:touchPoint];
}

- (CGFloat)calculateAngleToPoint:(CGPoint)point
{
    // Offset by the center
    CGPoint centerOffset = CGPointMake(point.x - CGRectGetMidX(self.view.bounds),
                                       point.y - CGRectGetMidY(self.view.bounds));
    return atan2(centerOffset.y, centerOffset.x);
}

@end
