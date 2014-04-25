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

@property (nonatomic,strong)NSString *nameUser;
@property (nonatomic,strong)NSString *nameHouse;
@property (nonatomic,strong)NSString *nameRoom;
@property (nonatomic,strong)NSString *nameService;
@property (nonatomic,strong)NSString *nameAction;
@property (nonatomic,strong)NSString *data;

@property (nonatomic, strong) NSDictionary *jsonArray;
@property (nonatomic, strong) NSDictionary *currentHouseDic;

@property (nonatomic, strong) NSMutableArray *tasks;

@end
