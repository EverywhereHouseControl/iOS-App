//
//  EventosViewController.m
//  ehc
//
//  Created by Víctor Vicente on 28/02/14.
//  Copyright (c) 2014 EHC. All rights reserved.
//

#import "EventosViewController.h"
#import "CKCalendarView.h"
#import "IonIcons.h"
#import "TareaViewController.h"

#define kTransitionSpeed 0.02f
#define kLargeLayoutScale 2.5F

#define MAX_COUNT 20
#define CELL_ID @"CELL_ID"

@interface EventosViewController ()<CKCalendarDelegate>

@property(nonatomic, weak) CKCalendarView *calendar;
@property(nonatomic, strong) UILabel *dateLabel;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;

@end

@implementation EventosViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)configureViewCalendar{
    CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
    self.calendar = calendar;
    calendar.delegate = self;
    self.calendar.backgroundColor = colorApp;
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
    self.minimumDate = [self.dateFormatter dateFromString:@"20/09/2012"];
    
    self.disabledDates = @[
                           [self.dateFormatter dateFromString:@"05/01/2013"],
                           [self.dateFormatter dateFromString:@"06/01/2013"],
                           [self.dateFormatter dateFromString:@"07/01/2013"]
                           ];
    
    calendar.onlyShowCurrentMonth = NO;
    calendar.adaptHeightToNumberOfWeeksInMonth = YES;
    
    calendar.frame = CGRectMake(10, 90, 300, 320);
    [self.view addSubview:calendar];
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(calendar.frame) + 4, self.view.bounds.size.width, 24)];
    [self.view addSubview:self.dateLabel];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
}

- (void)configureNavBar{
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithImage:[IonIcons imageWithIcon:icon_ios7_plus_outline size:30.0f color:[UIColor whiteColor]] style:UIBarButtonItemStylePlain target:self action:@selector(addButtonAction)];
    
    NSArray *actionButtonItems = @[addItem];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    
}

- (void)configurePaperView{
    UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [aFlowLayout setItemSize:CGSizeMake(142, 150)];
    
    //aFlowLayout.sectionInset = UIEdgeInsetsMake(314, 2, 0, 2);
    aFlowLayout.minimumInteritemSpacing = 10.0f;
    aFlowLayout.minimumLineSpacing = 2.0f;
    [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
     self.collectionViewTareas = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 142, self.view.frame.size.width, 150) collectionViewLayout:aFlowLayout];
    [self.collectionViewTareas setDataSource:self];
    [self.collectionViewTareas setDelegate:self];
    [self.collectionViewTareas setBackgroundColor:[UIColor clearColor]];
    [self.collectionViewTareas registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CELL_ID];
    
    [self.view addSubview:self.collectionViewTareas];
    [self.collectionViewTareas reloadData];
}

- (void)configureView{
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.calendar.frame.origin.y + self.calendar.frame.size.height, 100, 25)];
    [view setCenter:CGPointMake(self.view.frame.size.width/2, self.calendar.frame.origin.y + self.calendar.frame.size.height + 12)];
    [view.layer setCornerRadius:0.5];
    [view setBackgroundColor:colorApp];
    
    UILabel *tareasLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 25)];
    [tareasLabel setCenter:CGPointMake(self.view.frame.size.width/2, self.calendar.frame.origin.y + self.calendar.frame.size.height+12)];
    [tareasLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:17]];
    [tareasLabel setTextColor:[UIColor whiteColor]];
    [tareasLabel setText:@"Tareas"];
//    [view addSubview:tareasLabel];
    
    [self.view addSubview:view];
    [self.view addSubview:tareasLabel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:NO];
    
    [self configureViewCalendar];
    
    [self configureNavBar];
    
    [self configurePaperView];
    
    [self configureView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)localeDidChange {
    [self.calendar setLocale:[NSLocale currentLocale]];
}

- (BOOL)dateIsDisabled:(NSDate *)date {
    for (NSDate *disabledDate in self.disabledDates) {
        if ([disabledDate isEqualToDate:date]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark -
#pragma mark - CKCalendarDelegate

- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date {
    // TODO: play with the coloring if we want to...
    if ([self dateIsDisabled:date]) {
        dateItem.backgroundColor = [UIColor redColor];
        dateItem.textColor = [UIColor whiteColor];
    }
}

- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date {
    return ![self dateIsDisabled:date];
}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    self.dateLabel.text = [self.dateFormatter stringFromDate:date];
}

- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date {
    /*if ([date laterDate:self.minimumDate] == date) {
        //self.calendar.backgroundColor = [UIColor blueColor];
        return YES;
    } else {
        //self.calendar.backgroundColor = [UIColor redColor];
        return NO;
    }*/
    return YES;
}

- (void)calendar:(CKCalendarView *)calendar didLayoutInRect:(CGRect)frame {
    NSLog(@"calendar layout: %@", NSStringFromCGRect(frame));
}


#pragma mark - Methods AddTarea

- (void) addButtonAction{
    
}

#pragma mark - Methos Paper View

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.cornerRadius = 4;
    cell.clipsToBounds = YES;
    
    UIImageView *backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fake-cell"]];
    cell.backgroundView = backgroundView;
    
    return cell;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   // UIViewController *vc = [self nextViewControllerAtPoint:CGPointZero];
   // [self.navigationController pushViewController:vc animated:YES];
    TareaViewController *vc = [[TareaViewController alloc] initWithConfig];
    //[self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
