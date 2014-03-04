//
//  TareaViewController.m
//  ehc
//
//  Created by Víctor Vicente on 04/03/14.
//  Copyright (c) 2014 EHC. All rights reserved.
//

#import "TareaViewController.h"

@interface TareaViewController ()

@end

@implementation TareaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithConfig{
    self = [super init];
    if (self) {
        // Custom initialization
        UIButton *buttonLabel = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
        [buttonLabel setTitle:@"Close" forState:UIControlStateNormal];
        [buttonLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buttonLabel addTarget:self action:@selector(closeTarea) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonLabel];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)closeTarea{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
