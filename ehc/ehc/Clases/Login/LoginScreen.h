//
//  LoginScreen.h
//  TriviSeries
//
//  Created by Kinki on 4/28/13.
//  Copyright (c) 2013 AKA7. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <CommonCrypto/CommonDigest.h>

#import "API.h"
#import "AppDelegate.h"
#import "InitViewController.h"
#import "defs.h"



@interface LoginScreen : UIViewController{
    //the login form fields
    IBOutlet UITextField* fldUsername;
    IBOutlet UITextField* fldPassword;
    //AppDelegate *appDelegate;
}
@property(nonatomic,strong)IBOutlet UIView *cargando;
@property(nonatomic,strong)IBOutlet UIActivityIndicatorView *activity;
@property(nonatomic,strong)IBOutlet UILabel *labelCargando;

//action for when either button is pressed
-(IBAction)btnLoginRegisterTapped:(id)sender;
-(IBAction)quitarTeclado:(id)sender;
-(IBAction) slideFrameDown;
-(IBAction) slideFrameUp;

- (IBAction)loginSinLogin:(id)sender;

@end
