//
//  TvItemViewController.m
//  ehc
//
//  Created by kinki on 11/12/13.
//  Copyright (c) 2013 EHC. All rights reserved.
//

#import "TvItemViewController.h"

@interface TvItemViewController ()

@end

@implementation TvItemViewController

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
    [self.navigationItem setTitle:@"TV"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pulsadoBoton:(id)sender{
    [self sendTouchButton:[sender tag]];
}

- (void)sendTouchButton:(NSInteger)buttonTouch{
    DLog(@"Button touch on command TV: %d",buttonTouch);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pulsado" message:[NSString stringWithFormat:@"Ha pulsado el boton %d",buttonTouch] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end
