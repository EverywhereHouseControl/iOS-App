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
#import "UIView+FrameUtils.h"

#define kTransitionSpeed 0.02f
#define kLargeLayoutScale 2.5F

#define MAX_COUNT 20
#define CELL_ID @"CELL_ID"

#define NAME_TAREA @"nameTarea"
#define DATE_TAREA @"dateTarea"
#define ACTIONS_TAREA @"actionsTarea"
#define ADMIN_TAREA @"adminTarea"

@interface EventosViewController ()<CKCalendarDelegate>

@property(nonatomic, weak) CKCalendarView *calendar;
@property(nonatomic, strong) UILabel *dateLabel;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;

@property(nonatomic, strong) NSMutableDictionary *allTareas;
@property(nonatomic, strong) NSMutableArray *tareasFechaPulsada;

@property (nonatomic, strong) UIView *addTareaView;
@property (nonatomic, strong) UIView *addActionsToEventView;

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

- (void)configureTareasWithServer{
    self.allTareas = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *tarea = [[NSMutableDictionary alloc] init];
    [tarea setObject:@"Encender TV" forKey:NAME_TAREA];
    [tarea setObject:@"Encender TV" forKey:ADMIN_TAREA];
    [tarea setObject:@"Encender TV" forKey:DATE_TAREA];
    [tarea setObject:@"Encender TV" forKey:ACTIONS_TAREA];
    NSMutableDictionary *tarea1 = [[NSMutableDictionary alloc] init];
    [tarea1 setObject:@"Encender TV" forKey:NAME_TAREA];
    [tarea1 setObject:@"Encender TV" forKey:ADMIN_TAREA];
    [tarea1 setObject:@"Encender TV" forKey:DATE_TAREA];
    [tarea1 setObject:@"Encender TV" forKey:ACTIONS_TAREA];
    NSMutableDictionary *tarea2 = [[NSMutableDictionary alloc] init];
    [tarea2 setObject:@"Encender TV" forKey:NAME_TAREA];
    [tarea2 setObject:@"Encender TV" forKey:ADMIN_TAREA];
    [tarea2 setObject:@"Encender TV" forKey:DATE_TAREA];
    [tarea2 setObject:@"Encender TV" forKey:ACTIONS_TAREA];
    NSMutableDictionary *tarea3 = [[NSMutableDictionary alloc] init];
    [tarea3 setObject:@"Encender TV" forKey:NAME_TAREA];
    [tarea3 setObject:@"Encender TV" forKey:ADMIN_TAREA];
    [tarea3 setObject:@"Encender TV" forKey:DATE_TAREA];
    [tarea3 setObject:@"Encender TV" forKey:ACTIONS_TAREA];
    NSMutableDictionary *tarea4 = [[NSMutableDictionary alloc] init];
    [tarea4 setObject:@"Encender TV" forKey:NAME_TAREA];
    [tarea4 setObject:@"Encender TV" forKey:ADMIN_TAREA];
    [tarea4 setObject:@"Encender TV" forKey:DATE_TAREA];
    [tarea4 setObject:@"Encender TV" forKey:ACTIONS_TAREA];
    NSArray *array = [[NSArray alloc] initWithObjects:tarea,tarea1,tarea2,tarea3,tarea4, nil];
    [self.allTareas setObject:array forKey:@"06/03/2014"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:NO];
    
    [self configureTareasWithServer];
    
    [self configureViewCalendar];
    
    [self configureNavBar];
    
    [self configurePaperView];
    
    [self configureView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self cancelTareaButton];
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
    //self.dateLabel.text = [self.dateFormatter stringFromDate:date];
    DLog(@"fecha: %@",[self.dateFormatter stringFromDate:date]);
    self.tareasFechaPulsada = [self.allTareas objectForKey:[self.dateFormatter stringFromDate:date]];
    [self.collectionViewTareas reloadData];
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

-(void)createAddTareaMenu
{
 	if (!self.addTareaView) {
		self.addTareaView = [[UIView alloc] initWithFrame:CGRectMake(20, -400, 280, 400)];
		[self.addTareaView setBackgroundColor:[UIColor whiteColor]];
		
		UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(self.addTareaView.frame.size.width/2 - 20, self.addTareaView.frame.size.height - 50, 40, 40)];
		//[exit setImage:[UIImage imageNamed:@"Exit"] forState:UIControlStateNormal];
        [addButton setTitle:@"Add" forState:UIControlStateNormal];
        [addButton.titleLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:22]];
        [addButton setTitleColor:colorApp forState:UIControlStateNormal];
		[addButton addTarget:self action:@selector(addTarea) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
       // [IonIcons label:cancelButton.titleLabel setIcon:icon_close_circled size:15.0f color:[UIColor whiteColor] sizeToFit:YES];
        [cancelButton setImage:[IonIcons imageWithIcon:icon_close_circled size:20.0f color:[UIColor blackColor]] forState:UIControlStateNormal];
		//[exit setImage:[UIImage imageNamed:icon_close_circled] forState:UIControlStateNormal];
        //[cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        //[cancelButton setTitleColor:colorApp forState:UIControlStateNormal];
		[cancelButton addTarget:self action:@selector(cancelTareaButton) forControlEvents:UIControlEventTouchUpInside];
		
		UILabel *titleEventLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.addTareaView.frame.size.width/2 - 70, 30, 140, 40)];
        //[titleEventLabel setCenter:CGPointMake(self.addTareaView.frame.size.width/2, 30)];
        [titleEventLabel setTextAlignment:NSTextAlignmentCenter];
        [titleEventLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:22]];
        [titleEventLabel setTextColor:colorApp];
        [titleEventLabel setText:NSLocalizedString(@"New Event",@"")];
        
        UILabel *nameEventLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 140, 40)];
        //[nameEventLabel setCenter:CGPointMake(40, 80)];
        [nameEventLabel setTextAlignment:NSTextAlignmentLeft];
        [nameEventLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:22]];
        [nameEventLabel setTextColor:colorApp];
        [nameEventLabel setText:NSLocalizedString(@"Name:",@"")];
        
        UILabel *descriptionEventLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, 140, 40)];
        //[descriptionEventLabel setCenter:CGPointMake(40, 120)];
        [descriptionEventLabel setTextAlignment:NSTextAlignmentLeft];
        [descriptionEventLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:22]];
        [descriptionEventLabel setTextColor:colorApp];
        [descriptionEventLabel setText:NSLocalizedString(@"Description:",@"")];
        
        UILabel *dateEventLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 140, 40)];
        //[dateEventLabel setCenter:CGPointMake(40, 200)];
        [dateEventLabel setTextAlignment:NSTextAlignmentLeft];
        [dateEventLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:22]];
        [dateEventLabel setTextColor:colorApp];
        [dateEventLabel setText:NSLocalizedString(@"Date:",@"")];
        
        UILabel *timeEventLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 240, 140, 40)];
        //[timeEventLabel setCenter:CGPointMake(40, 240)];
        [timeEventLabel setTextAlignment:NSTextAlignmentLeft];
        [timeEventLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:22]];
        [timeEventLabel setTextColor:colorApp];
        [timeEventLabel setText:NSLocalizedString(@"Time::",@"")];
        
//        UILabel *actionsEventLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, 140, 40)];
//        //[actionsEventLabel setCenter:CGPointMake(40, 300)];
//        [actionsEventLabel setTextAlignment:NSTextAlignmentLeft];
//        [actionsEventLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:22]];
//        [actionsEventLabel setTextColor:colorApp];
//        [actionsEventLabel setText:NSLocalizedString(@"Actions:",@"")];
        
        UIButton *actionsEventButton = [[UIButton alloc] initWithFrame:CGRectMake(self.addTareaView.frame.size.width/2 - 50, self.addTareaView.frame.size.height - 100, 100, 40)];
		//[exit setImage:[UIImage imageNamed:@"Exit"] forState:UIControlStateNormal];
        [actionsEventButton setTitle:@"Actions" forState:UIControlStateNormal];
        [actionsEventButton.titleLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:22]];
        [actionsEventButton setTitleColor:colorApp forState:UIControlStateNormal];
		[actionsEventButton addTarget:self action:@selector(showActions) forControlEvents:UIControlEventTouchUpInside];
        
        
		
        [self.addTareaView addSubview:addButton];
        [self.addTareaView addSubview:cancelButton];
        [self.addTareaView addSubview:actionsEventButton];
        
        [self.addTareaView addSubview:titleEventLabel];
        [self.addTareaView addSubview:nameEventLabel];
        [self.addTareaView addSubview:descriptionEventLabel];
        [self.addTareaView addSubview:dateEventLabel];
        [self.addTareaView addSubview:timeEventLabel];
        //[self.addTareaView addSubview:actionsEventLabel];
		
		[appDelegate.window.rootViewController.view addSubview:self.addTareaView];
        
       
	}
}

-(void)createAddActionsToEventView
{
 	if (!self.addActionsToEventView) {
		self.addActionsToEventView = [[UIView alloc] initWithFrame:CGRectMake(0, -self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
		[self.addActionsToEventView setBackgroundColor:colorApp];
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2, self.view.frame.size.width, 2)];
        [viewLine setBackgroundColor:[UIColor whiteColor]];
        [self.addActionsToEventView addSubview:viewLine];
        
        UIView *viewAction = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 75, 60)];
        [viewAction setTag:0];
        [viewAction setBackgroundColor:[UIColor whiteColor]];
        
        UILabel *titleActionLabel = [[UILabel alloc] initWithFrame:CGRectMake(viewAction.frame.size.width/2 - 20, viewAction.frame.size.height/2 - 20, 40, 40)];
        //[titleEventLabel setCenter:CGPointMake(self.addTareaView.frame.size.width/2, 30)];
        [titleActionLabel setTextAlignment:NSTextAlignmentCenter];
        [titleActionLabel setNumberOfLines:3];
        [titleActionLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:14]];
        [titleActionLabel setTextColor:colorApp];
        [titleActionLabel setText:NSLocalizedString(@"Encender TV",@"")];
		
        [viewAction addSubview:titleActionLabel];
        [self.addActionsToEventView addSubview:viewAction];

		[appDelegate.window.rootViewController.view addSubview:self.addActionsToEventView];
        
	}
}

- (void)showActions{
    [self cancelTareaButton];
    
    [self createAddActionsToEventView];
    
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		[self.addActionsToEventView frameMoveToY:0];
	} completion:nil];
}

- (void)addTarea{
    
}

- (void)cancelTareaButton
{
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
		[self.addTareaView frameMoveToY:-400];
	} completion:nil];
}

- (void) addButtonAction{
    [self createAddTareaMenu];
	
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		[self.addTareaView frameMoveToY:80];
	} completion:nil];
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
    return [self.tareasFechaPulsada count];
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
