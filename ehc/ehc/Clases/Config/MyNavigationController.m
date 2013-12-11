//
//  MyNavigationController.m
//  TriviSeries
//
//  Created by KINKI on 5/16/13.
//  Copyright (c) 2013 AKA7. All rights reserved.
//

#import "MyNavigationController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"


@interface MyNavigationController ()

@end

@implementation MyNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"InitViewController"]];// initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self customizeAppearance];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    /*if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        
        if (appDelegate.window.frame.size.height == 1024){
            self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuIpad"];
        }
        else if (appDelegate.window.frame.size.height == 568){
            self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu5"];
        }
        else{
            self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
        }
        
    }
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customizeAppearance
{
    // Customize the title text for *all* UINavigationBars
    
    
}

@end
