//
//  FristViewController.m
//  ehc
//
//  Created by kinki on 09/12/13.
//  Copyright (c) 2013 EHC. All rights reserved.
//

#import "FristViewController.h"
#import "SetRoomsViewController.h"

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
    UIButton *eventButton = [[UIButton alloc] initWithFrame:CGRectMake(170, 150, 130, 130)];
    UIButton *gestionButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 320, 130, 130)];
    UIButton *configButton = [[UIButton alloc] initWithFrame:CGRectMake(170, 320, 130, 130)];
    
    [profileButton setBackgroundColor:[UIColor darkGrayColor]];
    [eventButton setBackgroundColor:[UIColor darkGrayColor]];
    [gestionButton setBackgroundColor:[UIColor darkGrayColor]];
    [configButton setBackgroundColor:[UIColor darkGrayColor]];
    
    [profileButton setTitle:@"Perfil" forState:UIControlStateNormal];
    [eventButton setTitle:@"Eventos" forState:UIControlStateNormal];
    [gestionButton setTitle:@"Gestión" forState:UIControlStateNormal];
    [configButton setTitle:@"Configuración" forState:UIControlStateNormal];
    
    [profileButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [eventButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [gestionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [configButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [profileButton addTarget:self action:@selector(openProfile:) forControlEvents:UIControlEventTouchUpInside];
    [eventButton addTarget:self action:@selector(openEvent:) forControlEvents:UIControlEventTouchUpInside];
    [gestionButton addTarget:self action:@selector(openGestion:) forControlEvents:UIControlEventTouchUpInside];
    [configButton addTarget:self action:@selector(openConfig:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:profileButton];
    [self.view addSubview:eventButton];
    [self.view addSubview:gestionButton];
    [self.view addSubview:configButton];
    
    self.navigationItem.title = @"Panel de Control";
    self.navigationItem.hidesBackButton = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) openProfile:(UIButton*)button{
    
}

- (void) openEvent:(UIButton*)button{
    
}

- (void) openGestion:(UIButton*)button{
    SetRoomsViewController *roomsController = (SetRoomsViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"roomsView"];
    [self.navigationController pushViewController:roomsController animated:YES];
}

- (void) openConfig:(UIButton*)button{
    
}

@end
