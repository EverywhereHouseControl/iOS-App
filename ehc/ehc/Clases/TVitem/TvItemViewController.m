
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

@interface TvItemViewController (){
    BOOL isTVon;
    BOOL isSoundOn;
    
    BOOL isTVForEvents;
}

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
    [self updateLabelState:appDelegate.state];
    
    isTVon = NO;
    isSoundOn = NO;
    //isTVForEvents = NO;
    [self.navigationItem setTitle:@"TV"];
	
	[self.navigationController.navigationBar setHidden:YES];
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	[[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setModeTVItem:(BOOL)isForEvents{
    isTVForEvents = isForEvents;
}

- (IBAction)pulsadoBoton:(id)sender{
    [self sendTouchButton:[sender tag]];
}

- (void)sendTouchButton:(NSInteger)buttonTouch{
    DLog(@"Button touch on command TV: %d",buttonTouch);
    [self sendData:buttonTouch];
}

- (NSString*)dameStringPorNumero:(int)button{
    NSString *st;
    switch (button) {
        case 0:
            //return @"16730295";
            return @"ZERO";
            break;
        case 1:
            //return @"16748655";
            return @"ONE";
            break;
        case 2:
            //return @"16758855";
            return @"TWO";
            break;
        case 3:
//            return @"16775175";
            return @"THREE";
            break;
        case 4:
            //return @"16756815";
            
            return @"FOUR";
            break;
        case 5:
  //return @"16750695";
            return @"FIVE";
            break;
        case 6:
  //return @"16767015";
            return @"SIX";
            break;
        case 7:
  //return @"716746615";
                      return @"SEVEN";
            break;
        case 8:
            //return @"16754775";
            return @"EIGHT";
            break;
        case 9:
//  return @"16771095";
            return @"NINE";
            break;
        case 10:
            
            return @"FAV";
            break;
        case 11:
            return @"SETUP";
            break;
        case 12:
            //return @"16722135";
            return @"POWER";
            break;
        case 14:
            return @"UP";
            break;
        case 15:
            return @"RIGHT";
            break;
        case 16:
            return @"DOWN";
            break;
        case 17:
            return @"LEFT";
            break;
        case 18:
            return @"PLAY";
            break;
        case 19:
            return @"16745085";
            //return @"MUTE";
            break;
        case 20:
            return @"VOLUMEUP";
            break;
        case 21:
            return @"VOLUMEDOWN";
            //return @"MUTE";
            break;
            
        default:
            break;
    }
    return @"00";
}

-(void)sendData:(int)button
{
    NSString *data = [self dameStringPorNumero:button];
    
    if (isTVForEvents) {
        appDelegate.dataForEvents = data;
        [self dismissViewControllerAnimated:YES completion:nil];
//        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        NSString *nameUser = appDelegate.nameUser;
        NSString *nameHouse = appDelegate.nameHouse;
        NSString *nameRoom = appDelegate.nameRoom;
        NSString *nameService = @"TV";//appDelegate.nameService;
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
                                           DLog(@"TV ok");
                                           [self updateLabelState:[NSString stringWithFormat:@"%d",button]];
                                       } else {
                                           DLog(@"error tv");
                                           //error
                                           //[UIAlertView error:[json objectForKey:@"error"]];
                                       }
                                   }];
    }
}

-(void)updateLabelState:(NSString*)textoLabel{
    int valor = [textoLabel intValue];
    NSString *text;
    switch (valor) {
        case 19:
            if (isSoundOn)
                text = @"Sound ON";
            else
                text = @"Sound OFF";
            isSoundOn = !isSoundOn;
            break;
        case 12:
            if (!isTVon)
                text = @"ON";
            else
                text = @"OFF";
            isTVon = !isTVon;
            break;
        case 18:
            text = @"Play";
            break;
        default:
            text = textoLabel;
            break;
    }
    [self.labelState setText:text];
}

- (IBAction)pulsadoBotonBack:(id)sender{
	[self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)pulsadoBotonTeletexto:(id)sender{
    browser = [[MDBrowser alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height-100)];
    browser.delegate = self;
    [browser ShowInView:self.view AddOverLayToSuperView:YES withAnimationType:MDBrowserPresetationAnimationTypePopUp];
    [browser LoadUrl:[NSURL URLWithString:@"http://www.ehcontrol.net/Utils/teletext.html"]];
    [browser setButtonsHidden:NO];
}

#pragma mark - Browser view delegate

-(BOOL)browserShouldStartLoadWithRequest:(NSURLRequest *)request withNavigationType:(UIWebViewNavigationType)navType
{
    // called when a request is about to be loaded And return whether the request should be loaded or not
    return YES;
}
-(void)browserViewUserTapedCloseButton:(MDBrowser *)browser
{
    // called when user tap the close button
}
-(void)browserDidStartLoading:(MDBrowser *)browser
{
    // called when browser start loading a page
}
-(void)browserDidFinishLoading:(MDBrowser *)browser
{
    // called when browser finish loading a page
}
-(void)browser:(MDBrowser *)browser DidFailToLoadWithError:(NSError *)err
{
    // called when browser fail to load a page
}
-(void)browserUserDidTapForwardBtn:(MDBrowser *)browser canGoForward:(BOOL)canGoForward
{
    // called when user tap forward button with bool parameter whether the browser can go forward or not
}
-(void)browserUserDidTapBackBtn:(MDBrowser *)browser canGoBackward:(BOOL)canGoBackward
{
    // called when user tap back button with bool parameter whether the browser can go backward or not
}

@end
