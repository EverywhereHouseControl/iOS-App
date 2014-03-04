//
//  FristViewController.m
//  ehc
//
//  Created by kinki on 09/12/13.
//  Copyright (c) 2013 EHC. All rights reserved.
//

#import "FristViewController.h"
#import "SetRoomsViewController.h"
#import "ProfileViewController.h"
#import "PrincipalView.h"
#import "EventosViewController.h"
@interface FristViewController ()

@end

@implementation FristViewController

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
    
    UIButton *profileButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 150, 130, 130)];
    UIView *profileView = [[UIView alloc] initWithFrame:CGRectMake(18, 148, 134, 134)];
    
    UIButton *eventButton = [[UIButton alloc] initWithFrame:CGRectMake(170, 150, 130, 130)];
    UIView *eventView = [[UIView alloc] initWithFrame:CGRectMake(168, 148, 134, 134)];
    
    UIButton *gestionButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 320, 130, 130)];
    UIView *gestionView = [[UIView alloc] initWithFrame:CGRectMake(18, 318, 134, 134)];
    
    UIButton *configButton = [[UIButton alloc] initWithFrame:CGRectMake(170, 320, 130, 130)];
    UIView *configView = [[UIView alloc] initWithFrame:CGRectMake(168, 318, 134, 134)];
    
    [profileButton setBackgroundColor:[UIColor whiteColor]];
    [eventButton setBackgroundColor:[UIColor whiteColor]];
    [gestionButton setBackgroundColor:[UIColor whiteColor]];
    [configButton setBackgroundColor:[UIColor whiteColor]];
    
    [profileView setBackgroundColor:[UIColor colorWithRed:0.000 green:0.681 blue:0.681 alpha:1.000]];
    [eventView setBackgroundColor:[UIColor colorWithRed:0.000 green:0.681 blue:0.681 alpha:1.000]];
    [gestionView setBackgroundColor:[UIColor colorWithRed:0.000 green:0.681 blue:0.681 alpha:1.000]];
    [configView setBackgroundColor:[UIColor colorWithRed:0.000 green:0.681 blue:0.681 alpha:1.000]];
    
    [profileButton setTitle:@"Tareas" forState:UIControlStateNormal];
    [eventButton setTitle:@"Eventos" forState:UIControlStateNormal];
    [gestionButton setTitle:@"Gestión" forState:UIControlStateNormal];
    [configButton setTitle:@"Configuración" forState:UIControlStateNormal];
    
    [profileButton setTitleColor:[UIColor colorWithRed:0.000 green:0.681 blue:0.681 alpha:1.000] forState:UIControlStateNormal];
    [eventButton setTitleColor:[UIColor colorWithRed:0.000 green:0.681 blue:0.681 alpha:1.000] forState:UIControlStateNormal];
    [gestionButton setTitleColor:[UIColor colorWithRed:0.000 green:0.681 blue:0.681 alpha:1.000] forState:UIControlStateNormal];
    [configButton setTitleColor:[UIColor colorWithRed:0.000 green:0.681 blue:0.681 alpha:1.000] forState:UIControlStateNormal];
    
    [profileButton addTarget:self action:@selector(openTareas:) forControlEvents:UIControlEventTouchUpInside];
    [eventButton addTarget:self action:@selector(openEvent:) forControlEvents:UIControlEventTouchUpInside];
    [gestionButton addTarget:self action:@selector(openGestion:) forControlEvents:UIControlEventTouchUpInside];
    [configButton addTarget:self action:@selector(openConfig:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:profileView];
    [self.view addSubview:eventView];
    [self.view addSubview:gestionView];
    [self.view addSubview:configView];
    
    [self.view addSubview:profileButton];
    [self.view addSubview:eventButton];
    [self.view addSubview:gestionButton];
    [self.view addSubview:configButton];
    
    self.navigationItem.title = @"Panel de Control";
    self.navigationItem.hidesBackButton = YES;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    appDelegate.recienLogeado = NO;
    
    PrincipalView* menu = (PrincipalView *) [self parentViewController];
    [menu setMenubarTitle:@"Home"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) openTareas:(UIButton*)button{
    //HACollectionViewSmallLayout *smallLayout = [[HACollectionViewSmallLayout alloc] init];
    
    EventosViewController *eventsController = [[EventosViewController alloc] init];//initWithCollectionViewLayout:smallLayout];//(EventosViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"eventsView"];
    [self.navigationController pushViewController:eventsController animated:YES];
    
}

- (void) openEvent:(UIButton*)button{
    
}

- (void) openGestion:(UIButton*)button{
    SetRoomsViewController *roomsController = (SetRoomsViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"roomsView"];
    [self.navigationController pushViewController:roomsController animated:YES];
}

- (void) openConfig:(UIButton*)button{
    
}

#pragma mark -



@end
