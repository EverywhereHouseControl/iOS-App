//
//  InitialView.h
//  EHC
//
//  Created by KINKI on 6/4/13.
//  Copyright (c) 2013 AKA7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AFHTTPClient.h"

@interface InitialView : UIViewController

@property(nonatomic,strong)IBOutlet UIActivityIndicatorView *activity;
@property(nonatomic,strong)IBOutlet UILabel *labelCargando;

- (void)recienLogeadoEnVistaLogin;

@end
