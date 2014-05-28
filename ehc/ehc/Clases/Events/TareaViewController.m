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

- (id)initWithConfig:(NSDictionary*)dic{
    self = [super init];
    if (self) {
        // Custom initialization
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        UIButton *buttonLabel = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 100, 50)];
        [buttonLabel setCenter:CGPointMake(self.view.frame.size.width/2, buttonLabel.center.y)];
        [buttonLabel setTitle:@"Close" forState:UIControlStateNormal];
        [[buttonLabel titleLabel] setFont:MY_FONT_WORDS_34];
        [buttonLabel.layer setBorderColor:MY_COLOR_APP_DARK.CGColor];
        [buttonLabel.layer setBorderWidth:1];
        [buttonLabel setTitleColor:MY_COLOR_APP_DARK forState:UIControlStateNormal];
        [buttonLabel addTarget:self action:@selector(closeTarea) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonLabel];
        
        UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(30, 80, 100, 30)];
        [labelName setFont:MY_FONT_WORDS_24];
        [labelName setTextColor:MY_COLOR_APP_DARK];
        [labelName setText:@"Name event:"];
        [labelName setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:labelName];
        UILabel *labelNameInfo = [[UILabel alloc] initWithFrame:CGRectMake(150, 80, 100, 30)];
        [labelNameInfo setFont:MY_FONT_WORDS];
        [labelNameInfo setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Name"]]];
        [labelNameInfo setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:labelNameInfo];
        
        UILabel *labelHouse = [[UILabel alloc] initWithFrame:CGRectMake(30, 130, 100, 30)];
        [labelHouse setFont:MY_FONT_WORDS_24];
        [labelHouse setTextColor:MY_COLOR_APP_DARK];
        [labelHouse setText:@"House:"];
        [labelHouse setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:labelHouse];
        UILabel *labelHouseInfo = [[UILabel alloc] initWithFrame:CGRectMake(150, 130, 100, 30)];
        [labelHouseInfo setFont:MY_FONT_WORDS];
        [labelHouseInfo setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"house"]]];
        [labelHouseInfo setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:labelHouseInfo];
        
        UILabel *labelRoom = [[UILabel alloc] initWithFrame:CGRectMake(30, 180, 100, 30)];
        [labelRoom setFont:MY_FONT_WORDS_24];
        [labelRoom setTextColor:MY_COLOR_APP_DARK];
        [labelRoom setText:@"Room:"];
        [labelRoom setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:labelRoom];
        UILabel *labelRoomInfo = [[UILabel alloc] initWithFrame:CGRectMake(150, 180, 100, 30)];
        [labelRoomInfo setFont:MY_FONT_WORDS];
        [labelRoomInfo setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"room"]]];
        [labelRoomInfo setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:labelRoomInfo];
        
        UILabel *labelItem = [[UILabel alloc] initWithFrame:CGRectMake(30, 230, 100, 30)];
        [labelItem setFont:MY_FONT_WORDS_24];
        [labelItem setTextColor:MY_COLOR_APP_DARK];
        [labelItem setText:@"Item:"];
        [labelItem setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:labelItem];
        UILabel *labelItemInfo = [[UILabel alloc] initWithFrame:CGRectMake(150, 230, 100, 30)];
        [labelItemInfo setFont:MY_FONT_WORDS];
        [labelItemInfo setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"service"]]];
        [labelItemInfo setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:labelItemInfo];
        
        UILabel *labelAction = [[UILabel alloc] initWithFrame:CGRectMake(30, 280, 150, 30)];
        [labelAction setFont:MY_FONT_WORDS_24];
        [labelAction setTextColor:MY_COLOR_APP_DARK];
        [labelAction setText:@"Action to send:"];
        [labelAction setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:labelAction];
        UILabel *labelActionInfo = [[UILabel alloc] initWithFrame:CGRectMake(150, 280, 100, 30)];
        [labelActionInfo setFont:MY_FONT_WORDS];
        [labelActionInfo setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"data"]]];
        [labelActionInfo setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:labelActionInfo];
        
        
        UILabel *labelDateYear = [[UILabel alloc] initWithFrame:CGRectMake(30, 330, 100, 30)];
        [labelDateYear setFont:MY_FONT_WORDS_24];
        [labelDateYear setTextColor:MY_COLOR_APP_DARK];
        [labelDateYear setText:@"Date:"];
        [labelDateYear setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:labelDateYear];
        UILabel *labelDateYearInfo = [[UILabel alloc] initWithFrame:CGRectMake(150, 330, 100, 30)];
        [labelDateYearInfo setFont:MY_FONT_WORDS];
        [labelDateYearInfo setText:[NSString stringWithFormat:@"%@/%@/%@",[dic objectForKey:@"Day"],[dic objectForKey:@"Month"],[dic objectForKey:@"Year"]]];
        [labelDateYearInfo setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:labelDateYearInfo];
        
        UILabel *labelDateHour = [[UILabel alloc] initWithFrame:CGRectMake(30, 380, 100, 30)];
        [labelDateHour setFont:MY_FONT_WORDS_24];
        [labelDateHour setTextColor:MY_COLOR_APP_DARK];
        [labelDateHour setText:@"Hour"];
        [labelDateHour setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:labelDateHour];
        UILabel *labelDateHourInfo = [[UILabel alloc] initWithFrame:CGRectMake(150, 380, 100, 30)];
        [labelDateHourInfo setFont:MY_FONT_WORDS];
        [labelDateHourInfo setText:[NSString stringWithFormat:@"%@:%@:%@",[dic objectForKey:@"Hour"],[dic objectForKey:@"Minute"],[dic objectForKey:@"Second"]]];
        [labelDateHourInfo setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:labelDateHourInfo];
        
        
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
