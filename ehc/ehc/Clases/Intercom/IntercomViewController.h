//
//  IntercomViewController.h
//  ehc
//
//  Created by Víctor Vicente on 23/05/14.
//  Copyright (c) 2014 EHC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntercomViewController : UIViewController

@property(nonatomic,strong) IBOutlet UISlider *sliderOpacity;
@property(nonatomic,strong) IBOutlet UIButton *onOff;
@property(nonatomic,strong) IBOutlet UIImageView *lightImage;
@property(nonatomic,strong) IBOutlet UILabel *labelOnOff;

- (IBAction) sliderValueChanged:(id)sender;
- (IBAction) changeButtonPressed:(id)sender;

@end
