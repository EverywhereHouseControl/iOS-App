//
//  MenuViewController.h
//  TriviSeries
//
//  Created by KINKI on 5/14/13.
//  Copyright (c) 2013 AKA7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#define KEY_PWD @"pwd"
#define KEY_PWD_MD5 @"pwdMd5"
#define KEY_USER @"usr"
#define ficheroVar @"kinkiMola.plist"
#import "AppDelegate.h"

@protocol ContentUserScreenDelegate <NSObject>

-(void)cambiarDeVista:(NSString*)newView;

@end

@interface MenuViewController : UITableViewController<UIActionSheetDelegate>

@property (nonatomic,strong)id<ContentUserScreenDelegate> delegateActions;

@end
