//
//  AppDelegate.h
//  ehc
//
//  Created by kinki on 20/11/13.
//  Copyright (c) 2013 EHC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic)BOOL recienLogeado;

@property (nonatomic)BOOL exit;
@property (nonatomic)BOOL pinCorrecto;

@property (nonatomic,strong)NSString *pwd;
@property (nonatomic,strong)NSString *user;

@property (nonatomic, strong) NSDictionary *jsonArray;

@end
