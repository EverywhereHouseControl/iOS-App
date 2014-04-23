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
    
    [self runSpinAnimationOnView:self.mundo duration:0.1 rotations:0.1 repeat:10000];
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

- (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}

-(IBAction)btnLoginRegisterTapped:(UIButton*)sender
{
    //form fields validation
    if (fldUsername.text.length < 4 || fldPassword.text.length < 4) {
        [UIAlertView error:@"Introduce un Usuario y una Contraseña de más de 4 caracteres."];
        return;
    }
    
    //salt the password
//    NSString* saltedPassword = [NSString stringWithFormat:@"%@%@", fldPassword.text, kSalt];
//    
//    //prepare the hashed storage
//    NSString* hashedPassword = nil;
//    unsigned char hashedPasswordData[CC_SHA1_DIGEST_LENGTH];
//    
//    //hash the pass
//    NSData *data = [saltedPassword dataUsingEncoding: NSUTF8StringEncoding];
//    if (CC_SHA1([data bytes], [data length], hashedPasswordData)) {
//        hashedPassword = [[NSString alloc] initWithBytes:hashedPasswordData length:sizeof(hashedPasswordData) encoding:NSASCIIStringEncoding];
//    } else {
//        [UIAlertView error:@"La contraseña no se ha enviado"];
//        return;
//    }
    //pwd = fldPassword.text;
    //pwdHashed = hashedPassword;
    //check whether it's a login or register
    
    //cargando....
    [self.cargando setHidden:NO];
    self.labelCargando.text = @"Connecting...";
    [self.activity startAnimating];
    //fin cargando
    pwdHashed = [self md5:fldPassword.text];
    nameUser = fldUsername.text;
    
    appDelegate.nameUser = nameUser;
    NSString* command = @"login2";//(sender.tag==1)?@"register":@"login";
    NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  command, @"command",
                                  nameUser, @"username",
                                  pwdHashed, @"password",
                                  nil];
    //make the call to the web API
    [[API sharedInstance] commandWithParams:params
                               onCompletion:^(NSDictionary *json) {
                                   //handle the response
                                   //result returned
                                   DLog(@"%@",json);
                                   NSDictionary* res = [json objectForKey:@"result"];
                                   
                                   //Finaliza cargando
                                   [self.activity stopAnimating];
                                   [self.cargando setHidden:YES];
                                   //------------------
                                   if ([[[json objectForKey:@"error"] objectForKey:@"ERROR"]intValue] == 0 && [[res objectForKey:@"IDUSER"] intValue]>0){
                                       
                                       idUs = [res objectForKey:@"IDUSER"];
                                       nameUser = [res objectForKey:@"USERNAME"];
                                       NSDictionary *jsonString = [res objectForKey:@"JSON"];
                                       
                                       //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"json"];
                                       //NSData *data = [NSData dataWithContentsOfFile:filePath];
                                       //NSData *dataBien;// = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
                                       //jsonParse= [NSJSONSerialization JSONObjectWithData:dataBien options:0 error:nil];
                                       //DLog(@"%@",jsonParse);
                                       //DLog(@"%@",jsonString);
                                       //NSString *b = pwdHashed;
                                       //NSString *c = nameUser;
                                       appDelegate.user = nameUser;
                                       appDelegate.pwd = pwdHashed;
                                       appDelegate.jsonArray = jsonString;//[NSJSONSerialization JSONObjectWithData:dataBien options:0 error:nil];
                                       
                                       //NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:b,KEY_PWD,c,KEY_USER,nil];
                                       //[dic writeToFile:[self rutaFicheroVar] atomically:YES];
                                       
                                       //show message to the user
//                                       [[[UIAlertView alloc] initWithTitle:@"Logged in"
//                                                                   message:[NSString stringWithFormat:@"Bienvenido %@",[res objectForKey:@"username"] ]
//                                                                  delegate:nil
//                                                         cancelButtonTitle:@"Cerrar"
//                                                         otherButtonTitles: nil] show];
                                       appDelegate.recienLogeado = YES;
                                       [self dismissViewControllerAnimated:YES completion:nil];
                                       
                                   } else {
                                       //error
                                       NSString *s = [NSString stringWithFormat:@"%@",[[json objectForKey:@"error"] objectForKey:@"ENGLISH"]];
                                       [UIAlertView error:s];
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
    else{ //if (appDelegate.window.frame.size.height == 568){
        movementDistance = 20;
    }
//    else{
//        movementDistance = 120;
//    }

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

- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations * duration ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

@end
