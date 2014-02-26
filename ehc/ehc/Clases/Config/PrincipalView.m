//
//  MyDropdownMenuController.m
//  DropdownMenuDemo
//
//  Created by Nils Mattisson on 1/13/14.
//  Copyright (c) 2014 Nils Mattisson. All rights reserved.
//

#import "PrincipalView.h"
#import "IonIcons.h"

@interface PrincipalView ()

@end

@implementation PrincipalView

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
    
    
//    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonAction:)];
//    
//    NSArray *actionButtonItems = @[menuItem];
//    self.navigationItem.rightBarButtonItems = actionButtonItems;
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Customize your menu programmatically here.
    [self customizeMenu];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.000 green:0.681 blue:0.681 alpha:1.000]];
    self.navigationController.navigationBar.tintColor =  [UIColor whiteColor];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setHidden:YES];
}

-(void) customizeMenu {
    // EXAMPLE: To set the menubar background colour programmatically.
    // FYI: There is a bug where the color comes out differently when set programmatically
    // than when set in XCode Interface builder, and I don't know why.
    //[self setMenubarBackground:[UIColor greenColor]];
    
    // Replace menu button with an IonIcon.
    [self.menuButton setTitle:nil forState:UIControlStateNormal];
    [self.menuButton setImage:[IonIcons imageWithIcon:icon_navicon size:30.0f color:[UIColor whiteColor]] forState:UIControlStateNormal];
    
    // Style menu buttons with IonIcons.
    for (UIButton *button in self.buttons) {
        if ([button.titleLabel.text isEqual: @"Profile"]) {
            [IonIcons label:button.titleLabel setIcon:icon_navicon_round size:15.0f color:[UIColor whiteColor] sizeToFit:YES];
            [button setImage:[IonIcons imageWithIcon:icon_person size:20.0f color:[UIColor whiteColor]] forState:UIControlStateNormal];
        } else if ([button.titleLabel.text isEqual: @"Home"]) {
            [IonIcons label:button.titleLabel setIcon:icon_home size:15.0f color:[UIColor whiteColor] sizeToFit:YES];
            [button setImage:[IonIcons imageWithIcon:icon_home size:20.0f color:[UIColor whiteColor]] forState:UIControlStateNormal];
        } else if ([button.titleLabel.text isEqual: @"Exit"]) {
            [IonIcons label:button.titleLabel setIcon:icon_log_out size:15.0f color:[UIColor whiteColor] sizeToFit:YES];
            [button setImage:[IonIcons imageWithIcon:icon_log_out size:20.0f color:[UIColor whiteColor]] forState:UIControlStateNormal];
        }
        
        // Set the title and icon position
        [button sizeToFit];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -button.imageView.frame.size.width-10, 0, button.imageView.frame.size.width);
        button.imageEdgeInsets = UIEdgeInsetsMake(0, button.titleLabel.frame.size.width, 0, -button.titleLabel.frame.size.width);
        
        // Set color to white
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
