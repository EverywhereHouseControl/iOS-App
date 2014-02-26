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

@interface InitialView (){
    AFHTTPClient *_client;
    NSString *user;
    NSString *pwd;
    NSString *nameUser;
    NSString *idUs;
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
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.000 green:0.777 blue:0.777 alpha:1.000]];
    self.navigationController.navigationBar.tintColor =  [UIColor whiteColor];
    [self.navigationController.navigationBar setTranslucent:YES];
    
    //appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	// Do any additional setup after loading the view.
    appDelegate.recienLogeado = NO;
    appDelegate.exit = NO;
    if (appDelegate.window.frame.size.height == 568) {
       //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Default-568h@2x"]]];
    }
    else{
      // [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Default"]]];
    }
    
    if ([self comprobarAutoLogin] || [self isUserExit]) {
        [self loginGame];
    }
    else{
//        [self entrar];
        [self sacarModalLogin];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    
    if (appDelegate.recienLogeado) {
        [self entrar];
    }
    else if ([self isUserExit]){
        [self sacarModalLogin];
    }
    [[self activity] startAnimating];
    [[self labelCargando] setText:@"Cargando..."];
}

#pragma mark - Metodos Login

- (void)sacarModalLogin{
    [[self activity] stopAnimating];
    if (appDelegate.window.frame.size.height == 1024){
        [self performSegueWithIdentifier:@"ipad" sender:self];
    }
    else if (appDelegate.window.frame.size.height == 568){
        LoginScreen *loginController = (LoginScreen *) [self.storyboard instantiateViewControllerWithIdentifier:@"loginViewN"];
        [self presentViewController:loginController animated:NO completion:nil];
    }
    else{
        [self performSegueWithIdentifier:@"loginFour" sender:self];
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
        
        
        if (![pwd isEqualToString:@""] && ![user isEqualToString:@""]) {
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
- (void)loginGame{
    //cargando....
    //[self.cargando setHidden:NO];
    //self.labelCargando.text = @"Connecting...";
    //[self.activity startAnimating];
    //fin cargando
    
    NSString* command = @"login";//(sender.tag==1)?@"register":@"login";
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
                                   NSDictionary* res = [[json objectForKey:@"result"] objectAtIndex:0];
                                   
                                   //Finaliza cargando
                                   // [self.activity stopAnimating];
                                   //[self.cargando setHidden:YES];
                                   //------------------
                                   
                                   if ([json objectForKey:@"error"]==nil && [[res objectForKey:@"IdUser"] intValue]>0) {
                                       
                                       idUs = [res objectForKey:@"IdUser"];
                                       nameUser = [res objectForKey:@"username"];
                                                                              //success
                                       [[API sharedInstance] setUser: res];
                                       
                                       [self entrar];
                                       
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
        PrincipalView *userController = (PrincipalView *) [self.storyboard instantiateViewControllerWithIdentifier:@"principalView"];
        [self presentViewController:userController animated:YES completion:nil];
    }
    else if (appDelegate.window.frame.size.height == 568){
        PrincipalView *userController = (PrincipalView *) [self.storyboard instantiateViewControllerWithIdentifier:@"principalView"];
        [self.navigationController pushViewController:userController animated:YES];
        //[self presentViewController:userController animated:YES completion:nil];
    }
    else{
        PrincipalView *userController = (PrincipalView *) [self.storyboard instantiateViewControllerWithIdentifier:@"principalView"];
        [self presentViewController:userController animated:YES completion:nil];
    }
}

#pragma mark - Metodos de delegado

- (void)recienLogeadoEnVistaLogin{
    [self entrar];
}

- (BOOL)isUserExit{
    return appDelegate.exit;
}


@end
