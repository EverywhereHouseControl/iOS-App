//
//  InitViewController.m
//  TriviSeries
//
//  Created by KINKI on 5/14/13.
//  Copyright (c) 2013 AKA7. All rights reserved.
//

#import "InitViewController.h"

@interface InitViewController ()

@end

@implementation InitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self activity] startAnimating];
	// Do any additional setup after loading the view.
    //appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.navigationItem.title = [appDelegate.currentHouseDic objectForKey:@"name"];
    [self userDidJoin];
    [self runSpinAnimationOnView:self.mundo duration:0.1 rotations:0.1 repeat:10000];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)userDidJoin{
    if (appDelegate.window.frame.size.height == 1024){
        
        self.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"roomsView"];
    }
    else {//if (appDelegate.window.frame.size.height == 568){
        
        self.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavController"];
    }
//    else {
//        self.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"User"];
//    }
    //self.slidingViewController.shouldAllowUserInteractionsWhenAnchored =YES;
    [[self activity] stopAnimating];
    [[self activity] setHidden:YES];
    [[self labelCargando] setHidden:YES];
}

- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations * duration ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}


@end
