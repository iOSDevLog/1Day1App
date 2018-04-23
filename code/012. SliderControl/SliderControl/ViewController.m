//
//  ViewController.m
//  SliderControl
//
//  Created by iOS Dev Log on 2018/3/27.
//  Copyright © 2018年 iOSDevLog. All rights reserved.
//

#import "ViewController.h"
#import "SliderControl.h"

@interface ViewController () {
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _knobControl.lineWidth = 4.0;
    _knobControl.pointerLength = 8.0;
    self.view.tintColor = [UIColor redColor];
    
    [_knobControl addObserver:self forKeyPath:@"value" options:0 context:NULL];
    // Hooks up the knob control
    [_knobControl addTarget:self
                     action:@selector(handleValueChanged:)
           forControlEvents:UIControlEventValueChanged];
}

- (IBAction)handleValueChanged:(id)sender {
    if(sender == self.valueSlider) {
        _knobControl.value = self.valueSlider.value;
    } else if(sender == _knobControl) {
        self.valueSlider.value = _knobControl.value;
    }
}

- (IBAction)handleRandomButtonPressed:(id)sender {
    // Generate random value
    CGFloat randomValue = (arc4random() % 101) / 100.f;
    // Then set it on the two controls
    [_knobControl setValue:randomValue animated:self.animateSwitch.on];
    [self.valueSlider setValue:randomValue animated:self.animateSwitch.on];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(object == _knobControl && [keyPath isEqualToString:@"value"]) {
        self.valueLabel.text = [NSString stringWithFormat:@"%0.2f", _knobControl.value];
    }
}
@end
