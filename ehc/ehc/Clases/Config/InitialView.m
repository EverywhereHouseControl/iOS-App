//
//  InitialView.m
//  EHC
//
//  Created by KINKI on 6/4/13.
//  Copyright (c) 2013 AKA7. All rights reserved.
//

#import "InitialView.h"
#import "InitViewController.h"
#import "LoginScreen.h"
#import "AFHTTPClient.h"
#import "API.h"
#import "defs.h"
#import "PrincipalView.h"
#import "PPPinPadViewController.h"
#import "HousesViewController.h"

@interface InitialView (){
    AFHTTPClient *_client;
    NSString *user;
    NSString *pwd;
    NSString *nameUser;
    NSString *idUs;
    NSString *pinCode;
}

@end

@implementation InitialView
@synthesize labelCargando,activity;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       // _client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:ServerApiURL]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.000 green:0.681 blue:0.681 alpha:1.000]];
    self.navigationController.navigationBar.tintColor =  [UIColor whiteColor];
    [self.navigationController.navigationBar setTranslucent:YES];
    
    //appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	// Do any additional setup after loading the view.
    appDelegate.recienLogeado = NO;
    appDelegate.exit = NO;
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    
    if (appDelegate.pinCorrecto) {
        [self entrar];
    }
    else if (appDelegate.recienLogeado) {
        [self configurarPin];
    }
    else if ([self isUserExit]){
        [self sacarModalLogin];
    }
    [[self activity] startAnimating];
    [[self labelCargando] setText:@"Cargando..."];
    
    if (appDelegate.window.frame.size.height == 568) {
        //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Default-568h@2x"]]];
    }
    else{
        // [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Default"]]];
    }
    
    if ([self comprobarAutoLogin] || [self isUserExit]) {//&& pwd) {
        [self loginGame];
    }
    else{
        //        [self entrar];
        [self sacarModalLogin];
    }
}

#pragma mark - Metodos Login

- (void)sacarModalLogin{
    [[self activity] stopAnimating];
    if (appDelegate.window.frame.size.height == 1024){
        [self performSegueWithIdentifier:@"ipad" sender:self];
    }
    else {
        LoginScreen *loginController = (LoginScreen *) [self.storyboard instantiateViewControllerWithIdentifier:@"loginViewN"];
        [self presentViewController:loginController animated:NO completion:nil];
    }
}

-(BOOL)comprobarAutoLogin{
    
    NSString *ruta2 = [self rutaFicheroVar];
    if (![[NSFileManager defaultManager] fileExistsAtPath:ruta2]) {
        ruta2 = [[NSBundle mainBundle] pathForResource:@"kinkiMola" ofType:@"plist"];
    }
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:ruta2]) {
        NSLog(@"%@",ruta2);
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:ruta2];
        
        pwd = [dic objectForKey:KEY_PWD];
        
        user = [dic objectForKey:KEY_USER];
        
        pinCode = [dic objectForKey:KEY_PINCODE];
        
        if (![pwd isEqualToString:@""] && ![user isEqualToString:@""] && (pwd) && (user) && (pinCode)) {
            //[self loginGame];
            return YES;
        }
        else {
            return NO;
        }
    }
    else {
        return NO;
    }
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

- (void)loginGame{
    //cargando....
    //[self.cargando setHidden:NO];
    //self.labelCargando.text = @"Connecting...";
    //[self.activity startAnimating];
    //fin cargando
    appDelegate.nameUser = user;
    
    NSString* command = @"login2";//(sender.tag==1)?@"register":@"login";
    NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  command, @"command",
                                  user, @"username",
                                  pwd, @"password",
                                  nil];
    //make the call to the web API
    [[API sharedInstance] commandWithParams:params
                               onCompletion:^(NSDictionary *json) {
                                   //handle the response
                                   //result returned
                                   NSDictionary* res = [json objectForKey:@"result"];
                                   
                                   //Finaliza cargando
                                   // [self.activity stopAnimating];
                                   //[self.cargando setHidden:YES];
                                   //------------------
//                                   NSString *filePath = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"json"];
//                                   NSData *data = [NSData dataWithContentsOfFile:filePath];
//                                   appDelegate.jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                   
                                   if ([[[json objectForKey:@"error"] objectForKey:@"ERROR"]intValue] == 0 && [[res objectForKey:@"IDUSER"] intValue]>0){
                                       
                                       idUs = [res objectForKey:@"IDUSER"];
                                       nameUser = [res objectForKey:@"USERNAME"];
                                       
                                       NSDictionary *jsonString = [res objectForKey:@"JSON"];
                                      // NSData *dataBien = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
                                       appDelegate.jsonArray = jsonString;//[NSJSONSerialization JSONObjectWithData:dataBien options:0 error:nil];
                                       DLog(@"%@ kkkk %@",appDelegate.jsonArray,[appDelegate.jsonArray objectForKey:@"House"]);
                                       //appDelegate.nameHouse = [appDelegate.gui objectForKey:@"House"];
                                       //NSDictionary *jsonDinamico =[[res objectForKey:@"JSON"] objectForKey:@"Rooms"];
                                       //appDelegate.jsonArray = jsonDinamico;
                                                                              //success
                                       [[API sharedInstance] setUser: res];
                                       
                                       [self sacarSeguridadConPin];
                                       
                                   } else {
                                       //error
                                        [self sacarModalLogin];
                                   }
                               }];
}

#pragma mark - Metodos ficheros

-(NSString *)rutaFicheroVar{
    NSArray *rutas =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSLog(@"Directorios: %@",rutas);
    
    NSString *directorio = [rutas objectAtIndex:0];
    
    rutas = nil;
    
    return [directorio stringByAppendingPathComponent:ficheroVar];
}

#pragma mark - Metodos entrar en el menu

- (void)entrar{
    [[self activity] stopAnimating];
    if (appDelegate.window.frame.size.height == 1024){
        //PrincipalView *userController = (PrincipalView *) [self.storyboard instantiateViewControllerWithIdentifier:@"principalView"];
        //[self presentViewController:userController animated:YES completion:nil];
        HousesViewController *houseController = (HousesViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"HousesView"];
        [self presentViewController:houseController animated:YES completion:nil];
    }
    else {//if (appDelegate.window.frame.size.height == 568){
//        PrincipalView *userController = (PrincipalView *) [self.storyboard instantiateViewControllerWithIdentifier:@"principalView"];
//        [self.navigationController pushViewController:userController animated:YES];
        HousesViewController *houseController = (HousesViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"HousesView"];
        [self presentViewController:houseController animated:YES completion:nil];
        
        //[self presentViewController:houseController animated:YES completion:nil];
        //[self presentViewController:userController animated:YES completion:nil];
    }
//    else{
//        PrincipalView *userController = (PrincipalView *) [self.storyboard instantiateViewControllerWithIdentifier:@"principalView"];
//        [self presentViewController:userController animated:YES completion:nil];
//    }
}

#pragma mark - Metodos de delegado

- (void)recienLogeadoEnVistaLogin{
    [self entrar];
}

- (BOOL)isUserExit{
    return appDelegate.exit;
}

#pragma mark - Metodos Pin
- (void)configurarPin{
    PPPinPadViewController * pinViewController = [[PPPinPadViewController alloc] initWithConfigure:YES];
    [pinViewController.view setBackgroundColor:colorApp];
    
    [self presentViewController:pinViewController animated:YES completion:NULL];
    pinViewController.delegate = self;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}
    
- (BOOL)checkPin:(NSString *)pin {
    return [pin isEqualToString:pinCode];
}

- (NSInteger)pinLenght {
    return 4;
}

- (NSString*)getInputStringForConfigure:(NSString*)input{
    pinCode = input;
    [self entrar];
    [self guardarPinCode:input];
    return pinCode;
}

- (void)sacarSeguridadConPin{
    
    PPPinPadViewController * pinViewController = [[PPPinPadViewController alloc] init];
    [pinViewController.view setBackgroundColor:colorApp];
    
    [self presentViewController:pinViewController animated:YES completion:NULL];
    pinViewController.delegate = self;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)guardarPinCode:(NSString*)pinCodes{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:appDelegate.pwd,KEY_PWD,appDelegate.user,KEY_USER,pinCodes,KEY_PINCODE,nil];
    
    [dic writeToFile:[self rutaFicheroVar] atomically:YES];
}

@end
