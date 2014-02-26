//
//  ProfileViewController.m
//  ehc
//
//  Created by Víctor Vicente on 20/01/14.
//  Copyright (c) 2014 EHC. All rights reserved.
//

#import "ProfileViewController.h"
#import "PrincipalView.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

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
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    PrincipalView* menu = (PrincipalView *) [self parentViewController];
    [menu setMenubarTitle:@"Perfil"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
