//
//  ViewController.m
//  CustomSlider
//
//  Created by iOS Dev Log on 2018/3/26.
//  Copyright © 2018年 iOSDevLog. All rights reserved.
//

#import "ViewController.h"
#import "RangeSlider.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet RangeSlider *rangeSlider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_rangeSlider addTarget:self
                     action:@selector(slideValueChanged:)
           forControlEvents:UIControlEventValueChanged];

    [self performSelector:@selector(updateState) withObject:nil afterDelay:1.0f];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)slideValueChanged:(id)control
{
    NSLog(@"Slider value changed: (%.2f,%.2f)",
          _rangeSlider.lowerValue, _rangeSlider.upperValue);
}

- (void)updateState
{
    _rangeSlider.trackHighlightColour = [UIColor redColor];
    _rangeSlider.curvatiousness = 0.0;
}

@end
