//
//  HelpViewController.h
//  ehc
//
//  Created by Víctor Vicente on 21/05/14.
//  Copyright (c) 2014 EHC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageUI/MessageUI.h"

@interface HelpViewController : UIViewController<MFMailComposeViewControllerDelegate>

- (IBAction)showEmail:(id)sender;

@end
