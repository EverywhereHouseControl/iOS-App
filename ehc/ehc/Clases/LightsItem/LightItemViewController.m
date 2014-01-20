//
//  LightItemViewController.m
//  ehc
//
//  Created by Víctor Vicente on 19/01/14.
//  Copyright (c) 2014 EHC. All rights reserved.
//

#import "LightItemViewController.h"
#import "API.h"
#import "UIAlertView+error.h"

@interface LightItemViewController ()

@end

@implementation LightItemViewController
@synthesize lightImage,sliderOpacity,onOff,labelOnOff;

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) sliderValueChanged:(UISlider *)sender {
    //myTextField.text = [NSString stringWithFormat:@"%.1f", [sender value]];
    [lightImage setAlpha:[sender value]];
}

-(void)changeButtonPressed:(id)sender{
    if (!onOff.on) {
        [onOff setOn:NO];
        [labelOnOff setText:@"OFF"];
        [self sendData:0];//es apagado
    }
    else{
        [onOff setOn:YES];
        [labelOnOff setText:@"ON"];
        [self sendData:1];//es encendido
    }
}

-(void)sendData:(int)button
{
    NSString *idUser = @"1";
    NSString *idRoom = @"1";
    NSString *idItem = @"2";
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
