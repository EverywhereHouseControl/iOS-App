//
//  MyDropdownMenuController.m
//  DropdownMenuDemo
//
//  Created by Nils Mattisson on 1/13/14.
//  Copyright (c) 2014 Nils Mattisson. All rights reserved.
//

#import "PrincipalView.h"
#import "IonIcons.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

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
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        
        //        if (isIpad){
        //            self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuIpad"];
        //        }
        //        else {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu5"];
        ((MenuViewController*)self.slidingViewController.underLeftViewController).delegateActions = self;
    }
    //        else{
    //            self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    //        }
    //    }
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
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

#pragma mark - Methods exit

- (IBAction)buttonExitTouch:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    appDelegate.exit = YES;
    appDelegate.pinCorrecto = NO;
    appDelegate.recienLogeado = NO;
}

#pragma mark - Metodos de protocolo

-(void)cambiarDeVista:(NSString*)newView{
    if ([newView isEqualToString:@"Perfil5"]) {
        [self llamarAperfil:newView];
    }
    else if ([newView isEqualToString:@"Ajustes5"]){
        [self llamarAajustes:newView];
    }
    else if ([newView isEqualToString:@"Market5"]){
        [self llamarAmarket:newView];
    }
    else if ([newView isEqualToString:@"Ranking5"]){
        [self llamarAranking:newView];
    }
    else if ([newView isEqualToString:@"Ayuda5"]){
        [self llamarAayuda:newView];
    }
}

-(void)llamarAperfil:(NSString*)identifier{
//    PerfilViewController* perfilView = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
//    [self.navigationController pushViewController:perfilView animated:NO];
//    voyAjugar = NO;
}

-(void)llamarAajustes:(NSString*)identifier{
//    AjustesViewController *ajustesView = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
//    [self.navigationController pushViewController:ajustesView animated:NO];
//    voyAjugar = NO;
}

-(void)llamarAmarket:(NSString*)identifier{
//    MarketViewController *marketView = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
//    [self.navigationController pushViewController:marketView animated:NO];
//    voyAjugar = NO;
}

-(void)llamarAranking:(NSString*)identifier{
//    RankingViewController *rankingView = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
//    [self.navigationController pushViewController:rankingView animated:NO];
//    voyAjugar = NO;
}

-(void)llamarAayuda:(NSString*)identifier{
//    AyudaViewController *ayudaView = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
//    [self.navigationController pushViewController:ayudaView animated:NO];
//    voyAjugar = NO;
}

@end
