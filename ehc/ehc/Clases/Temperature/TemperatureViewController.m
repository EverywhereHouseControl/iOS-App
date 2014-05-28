//
//  TemperatureViewController.m
//  ehc
//
//  Created by Víctor Vicente on 23/05/14.
//  Copyright (c) 2014 EHC. All rights reserved.
//

#import "TemperatureViewController.h"
#import "API.h"
#import "UIAlertView+error.h"

@interface TemperatureViewController ()

@end

@implementation TemperatureViewController

@synthesize lightImage,sliderOpacity,onOff,labelWeather,labelCity,labelCountry;

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
    [self setTitle:@"Temperature"];
    [labelCountry setText:appDelegate.nameCountry];
    [labelCity setText:appDelegate.nameCity];
    [self sendData:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sendData:(int)button
{
    NSString *data;
    if (button == 1) {
        data = @"OPEN";
    }
    else{
        data = @"OPEN";
    }
    
    NSString *nameUser = appDelegate.nameUser;
    NSString *nameHouse = appDelegate.nameHouse;
    NSString *nameRoom = appDelegate.nameRoom;
    NSString *nameService = @"INTERCOM";//nil;//appDelegate.nameService;
    NSString *nameAction = @"SEND";//appDelegate.nameAction;
    //[NSString stringWithFormat:@"%d",button];
    //NSString *status = @"1";
    
    NSString* command = @"getweather";//(sender.tag==1)?@"register":@"login";
    NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  command, @"command",
                                  //@"1",@"idUser",
                                  //@"2",@"idMando",
                                  //@"0132167221351",@"estado",
                                  @"MADRID", @"city",
                                  @"SPAIN", @"country",
                                  nil];
    //make the call to the web API
    [[API sharedInstance] commandWithParams:params
                               onCompletion:^(NSDictionary *json) {
                                   //handle the response
                                   //result returned
                                   //NSDictionary* res = [[json objectForKey:@"result"] objectAtIndex:0];
                                   
                                   //Finaliza cargando
                                   //------------------
                                   if ([json objectForKey:@"ERROR"]==0) {
                                       // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pulsado" message:[NSString stringWithFormat:@"Enviado pulsación de boton %d",button] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                       //[alert show];
                                       // [self updateLabelState:[NSString stringWithFormat:@"%d",button]];
                                       NSString *t = [json objectForKey:@"temperature"];
                                       [labelWeather setText:[NSString stringWithFormat:@"%fº",[t floatValue] - 273.15f]];
                                       DLog(@"Show temp");
                                   } else {
                                       DLog(@"Dont show temp");
                                       //error
                                       //[UIAlertView error:[json objectForKey:@"error"]];
                                   }
                               }];
    
    
}


@end
