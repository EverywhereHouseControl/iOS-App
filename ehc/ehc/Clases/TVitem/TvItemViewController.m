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
    
    isTVon = NO;
    isSoundOn = NO;
    [self.navigationItem setTitle:@"TV"];
	
	[self.navigationController.navigationBar setHidden:YES];
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
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
                                       [self updateLabelState:[NSString stringWithFormat:@"%d",button]];
                                   } else {
                                       //error
                                       [UIAlertView error:[json objectForKey:@"error"]];
                                   }
                               }];
    
    
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
