//
//  TvItemViewController.m
//  ehc
//
//  Created by kinki on 11/12/13.
//  Copyright (c) 2013 EHC. All rights reserved.
//

#import "TvItemViewController.h"
#import "API.h"
#import "UIAlertView+error.h"

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
    [self sendData:buttonTouch];
}

-(void)sendData:(int)button
{
    NSString *idUser = @"1";
    NSString *idRoom = @"1";
    NSString *idItem = @"1";
    NSString *job = [NSString stringWithFormat:@"%d",button];
    NSString *status = @"1";
    
    NSString* command = @"sendJob";//(sender.tag==1)?@"register":@"login";
    NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  command, @"command",
                                  idUser, @"idUser",
                                  idRoom, @"idRoom",
                                  idItem, @"idItem",
                                  job, @"job",
                                  status, @"status",
                                  nil];
    //make the call to the web API
    [[API sharedInstance] commandWithParams:params
                               onCompletion:^(NSDictionary *json) {
                                   //handle the response
                                   //result returned
                                   //NSDictionary* res = [[json objectForKey:@"result"] objectAtIndex:0];
                                   
                                   //Finaliza cargando
                                   //------------------
                                   if ([json objectForKey:@"error"]==nil) {
                                       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pulsado" message:[NSString stringWithFormat:@"Enviado pulsación de boton %d",button] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                       [alert show];
                                       
                                   } else {
                                       //error
                                       [UIAlertView error:[json objectForKey:@"error"]];
                                   }
                               }];
    
    
}

@end
