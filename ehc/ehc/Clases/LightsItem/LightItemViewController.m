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
    
    [self setTitle:@"Lights"];
    
    if ([appDelegate.state isEqualToString:@"ON"]) {
        [onOff setOn:YES];
        [labelOnOff setText:@"ON"];
        [lightImage setAlpha:1.0];
    }
    else{
        [onOff setOn:NO];
        [labelOnOff setText:@"OFF"];
        [lightImage setAlpha:0.0];
    }
    
    DLog(@"JSON %@",appDelegate.jsonArray);
    appDelegate.nameHouse;
    appDelegate.nameRoom;
    
    NSArray *array = [appDelegate.jsonArray objectForKey:@"houses"];
    for (int i = 0; i < [array count]; i++) {
        
    }
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
        [lightImage setAlpha:0.0];
        [self sendData:0];//es apagado
    }
    else{
        [onOff setOn:YES];
        [labelOnOff setText:@"ON"];
        [lightImage setAlpha:1.0];
        [self sendData:1];//es encendido
    }
}

-(void)sendData:(int)button
{
    NSString *data;
    if (button == 1) {
        data = @"ON";
    }
    else{
        data = @"OFF";
    }
    
    NSString *nameUser = appDelegate.nameUser;
    NSString *nameHouse = appDelegate.nameHouse;
    NSString *nameRoom = appDelegate.nameRoom;
    NSString *nameService = @"LIGHTS";//nil;//appDelegate.nameService;
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
                                   } else {
                                       //error
                                       //[UIAlertView error:[json objectForKey:@"error"]];
                                   }
                               }];
    
    
}

@end
