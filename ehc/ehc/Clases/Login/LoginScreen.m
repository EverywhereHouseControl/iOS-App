//
//  LoginScreen.m
//  TriviSeries
//
//  Created by Kinki on 4/28/13.
//  Copyright (c) 2013 AKA7. All rights reserved.
//

#import "LoginScreen.h"
#import "UIAlertView+error.h"

@interface LoginScreen (){
    AFHTTPClient *_client;
    NSString *nameUser;
    NSString *pwd;
    NSString *pwdHashed;
    NSString *idUs;
    NSArray *jsonParse;
}
@end

@implementation LoginScreen
@synthesize cargando,labelCargando,activity;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //_client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:ServerApiURL]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //_client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:ServerApiURL]];
    
    //appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    nameUser = @"";
    pwd = @"";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)btnLoginRegisterTapped:(UIButton*)sender
{
    //form fields validation
    if (fldUsername.text.length < 4 || fldPassword.text.length < 4) {
        [UIAlertView error:@"Introduce un Usuario y una Contraseña de más de 4 caracteres."];
        return;
    }
    
    //salt the password
    NSString* saltedPassword = [NSString stringWithFormat:@"%@%@", fldPassword.text, kSalt];
    
    //prepare the hashed storage
    NSString* hashedPassword = nil;
    unsigned char hashedPasswordData[CC_SHA1_DIGEST_LENGTH];
    
    //hash the pass
    NSData *data = [saltedPassword dataUsingEncoding: NSUTF8StringEncoding];
    if (CC_SHA1([data bytes], [data length], hashedPasswordData)) {
        hashedPassword = [[NSString alloc] initWithBytes:hashedPasswordData length:sizeof(hashedPasswordData) encoding:NSASCIIStringEncoding];
    } else {
        [UIAlertView error:@"La contraseña no se ha enviado"];
        return;
    }
    pwd = fldPassword.text;
    pwdHashed = hashedPassword;
    //check whether it's a login or register
    
    //cargando....
    [self.cargando setHidden:NO];
    self.labelCargando.text = @"Connecting...";
    [self.activity startAnimating];
    //fin cargando
    
    
    NSString* command = @"login";//(sender.tag==1)?@"register":@"login";
    NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  command, @"command",
                                  fldUsername.text, @"username",
                                  fldUsername.text, @"password",
                                  nil];
    //make the call to the web API
    [[API sharedInstance] commandWithParams:params
                               onCompletion:^(NSDictionary *json) {
                                   //handle the response
                                   //result returned
                                   NSDictionary* res = [[json objectForKey:@"result"] objectAtIndex:0];
                                   
                                   //Finaliza cargando
                                   [self.activity stopAnimating];
                                   [self.cargando setHidden:YES];
                                   //------------------
                                   if ([json objectForKey:@"error"]==nil && [[res objectForKey:@"IdUser"] intValue]>0) {
                                       
                                       idUs = [res objectForKey:@"IdUser"];
                                       nameUser = [res objectForKey:@"username"];
                                       
                                       NSString *filePath = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"json"];
                                       NSData *data = [NSData dataWithContentsOfFile:filePath];
                                       jsonParse= [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                   
                                       NSString *b = pwdHashed;
                                       NSString *c = nameUser;
                                       appDelegate.jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                       
                                       NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:b,KEY_PWD,c,KEY_USER,nil];
                                       [dic writeToFile:[self rutaFicheroVar] atomically:YES];
                                       
                                       //show message to the user
                                       [[[UIAlertView alloc] initWithTitle:@"Logged in"
                                                                   message:[NSString stringWithFormat:@"Bienvenido %@",[res objectForKey:@"username"] ]
                                                                  delegate:nil
                                                         cancelButtonTitle:@"Cerrar"
                                                         otherButtonTitles: nil] show];
                                       appDelegate.recienLogeado = YES;
                                       [self dismissViewControllerAnimated:YES completion:nil];
                                       
                                   } else {
                                       //error
                                       [UIAlertView error:[json objectForKey:@"error"]];
                                   }
                               }];
    
    
}

- (IBAction)quitarTeclado:(id)sender{
    
}

- (IBAction)loginSinLogin:(id)sender{
    appDelegate.recienLogeado = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction) slideFrameUp{
    
    [self slideFrame:YES];
    
}

- (IBAction) slideFrameDown{
    
    [self slideFrame:NO];
    
}

- (void) slideFrame:(BOOL) up{
    
    int movementDistance = 0; // lo que sea necesario, en mi caso yo use 120
    
    if (appDelegate.window.frame.size.height == 1024){
        movementDistance = 0;
    }
    else if (appDelegate.window.frame.size.height == 568){
        movementDistance = 20;
    }
    else{
        movementDistance = 120;
    }
    
    const float movementDuration = 0.3f; // lo que sea necesario
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    
    [UIView setAnimationBeginsFromCurrentState: YES];
    
    [UIView setAnimationDuration: movementDuration];
    
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    
    [UIView commitAnimations];
    
}


#pragma mark Metodos de Lectura y Escritura Plist

-(NSString *)rutaFicheroVar{
    NSArray *rutas =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSLog(@"Directorios: %@",rutas);
    
    NSString *directorio = [rutas objectAtIndex:0];
    
    rutas = nil;
    
    return [directorio stringByAppendingPathComponent:ficheroVar];
}

@end
