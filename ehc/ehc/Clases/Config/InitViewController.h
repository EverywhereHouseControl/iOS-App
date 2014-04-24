//
//  InitViewController.h
//  TriviSeries
//
//  Created by KINKI on 5/14/13.
//  Copyright (c) 2013 AKA7. All rights reserved.
//

#import "ECSlidingViewController.h"
#import "AppDelegate.h"

@interface InitViewController : ECSlidingViewController{
    //AppDelegate *appDelegate;
}

@property(nonatomic,strong)IBOutlet UIActivityIndicatorView *activity;
@property(nonatomic,strong)IBOutlet UILabel *labelCargando;

@property (weak, nonatomic) IBOutlet UIImageView *mundo;

@end
