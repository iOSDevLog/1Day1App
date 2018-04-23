//
//  SliderControl.m
//  SliderControl
//
//  Created by iOS Dev Log on 2018/3/27.
//  Copyright © 2018年 iOSDevLog. All rights reserved.
//

#import "SliderControl.h"
#import "KnobRenderer.h"
#import "RotationGestureRecognizer.h"

@interface SliderControl() {
    KnobRenderer *_knobRenderer;
    RotationGestureRecognizer *_gestureRecognizer;
}
@end

@implementation SliderControl

@dynamic lineWidth;
@dynamic startAngle;
@dynamic endAngle;
@dynamic pointerLength;

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    // Initialization code
    _minimumValue = 0.0;
    _maximumValue = 1.0;
    _value = 0.0;
    _continuous = YES;
    _gestureRecognizer = [[RotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [self addGestureRecognizer:_gestureRecognizer];
    
    [self createKnobUI];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

#pragma mark - Property overrides
- (void)setValue:(CGFloat)value
{
    // Chain with the animation method version
    [self setValue:value animated:NO];
}

- (void)tintColorDidChange
{
    _knobRenderer.color = self.tintColor;
}

#pragma mark - API Methods
- (void)setValue:(CGFloat)value animated:(BOOL)animated
{
    if(value != _value) {
        // Save the value to the backing ivar
        // Make sure we limit it to the requested bounds
        _value = MIN(self.maximumValue, MAX(self.minimumValue, value));
        
        // Now let's update the knob with the correct angle
        CGFloat angleRange = self.endAngle - self.startAngle;
        CGFloat valueRange = self.maximumValue - self.minimumValue;
        CGFloat angleForValue = (_value - self.minimumValue) / valueRange * angleRange + self.startAngle;
        _knobRenderer.pointerAngle = angleForValue;
        [self didChangeValueForKey:@"value"];
    }
}

#pragma mark - Property overrides
- (void)createKnobUI
{
    _knobRenderer = [[KnobRenderer alloc] init];
    [_knobRenderer updateWithBounds:self.bounds];
    _knobRenderer.color = self.tintColor;
    // Set some defaults
    _knobRenderer.startAngle = -M_PI * 11 / 8.0;
    _knobRenderer.endAngle = M_PI * 3 / 8.0;
    _knobRenderer.pointerAngle = _knobRenderer.startAngle;
    _knobRenderer.lineWidth = 2.0;
    _knobRenderer.pointerLength = 6.0;
    // Add the layers
    [self.layer addSublayer:_knobRenderer.trackLayer];
    [self.layer addSublayer:_knobRenderer.pointerLayer];
}

#pragma mark - Getter & Setter
- (CGFloat)lineWidth
{
    return _knobRenderer.lineWidth;
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    _knobRenderer.lineWidth = lineWidth;
}

- (CGFloat)startAngle
{
    return _knobRenderer.startAngle;
}

- (void)setStartAngle:(CGFloat)startAngle
{
    _knobRenderer.startAngle = startAngle;
}

- (CGFloat)endAngle
{
    return _knobRenderer.endAngle;
}

- (void)setEndAngle:(CGFloat)endAngle
{
    _knobRenderer.endAngle = endAngle;
}

- (CGFloat)pointerLength
{
    return _knobRenderer.pointerLength;
}

- (void)setPointerLength:(CGFloat)pointerLength
{
    _knobRenderer.pointerLength = pointerLength;
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key
{
    if ([key isEqualToString:@"value"]) {
        return NO;
    } else {
        return [super automaticallyNotifiesObserversForKey:key];
    }
}

- (void)handleGesture:(RotationGestureRecognizer *)gesture
{
    // Mid-point angle
    CGFloat midPointAngle = (2 * M_PI + self.startAngle - self.endAngle) / 2 + self.endAngle;
    
    // Ensure the angle is within a suitable range
    CGFloat boundedAngle = gesture.touchAngle;
    if(boundedAngle > midPointAngle) {
        boundedAngle -= 2 * M_PI;
    } else if (boundedAngle < (midPointAngle - 2 * M_PI)) {
        boundedAngle += 2 * M_PI;
    }
    // Bound the angle to within the suitable range
    boundedAngle = MIN(self.endAngle, MAX(self.startAngle, boundedAngle));
    
    // Convert the angle to a value
    CGFloat angleRange = self.endAngle - self.startAngle;
    CGFloat valueRange = self.maximumValue - self.minimumValue;
    CGFloat valueForAngle = (boundedAngle - self.startAngle) / angleRange * valueRange + self.minimumValue;
    
    // Set the control to this value
    self.value = valueForAngle;
    
    // Notify of value change
    if (self.continuous) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    } else {
        // Only send an update if the gesture has completed
        if(_gestureRecognizer.state == UIGestureRecognizerStateEnded
           || _gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
}

@end
