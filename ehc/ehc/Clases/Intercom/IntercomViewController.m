//
//  IntercomViewController.m
//  ehc
//
//  Created by Víctor Vicente on 23/05/14.
//  Copyright (c) 2014 EHC. All rights reserved.
//

#import "IntercomViewController.h"
#import "API.h"
#import "UIAlertView+error.h"

@interface IntercomViewController ()

@end

@implementation IntercomViewController

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
    
    [self setTitle:@"Intercom"];
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
    [self sendData:1];
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
    
    NSString* command = @"doaction";//(sender.tag==1)?@"register":@"login";
    NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  command, @"command",
                                  //@"1",@"idUser",
                                  //@"2",@"idMando",
                                  //@"0132167221351",@"estado",
                                  nameUser, @"username",
                                  nameHouse, @"housename",
                                  nameRoom, @"roomname",
                                  nameService, @"servicename",
                                  nameAction, @"actionname",
                                  data,@"data",
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
                                       DLog(@"Open door");
                                   } else {
                                       DLog(@"Dont Open door");
                                       //error
                                       //[UIAlertView error:[json objectForKey:@"error"]];
                                   }
                               }];
    
    
}

@end