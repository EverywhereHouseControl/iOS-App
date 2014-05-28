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
#import "TvItemViewController.h"
#import "API.h"

#define kTransitionSpeed 0.02f
#define kLargeLayoutScale 2.5F

#define MAX_COUNT 20
#define CELL_ID @"CELL_ID"

#define MINUTE_TASK @"Minute"
#define NAME_TASK @"Name"
#define DAY_TASK @"Day"
#define ITEM_TASK @"item"
#define ACTION_TASK @"action"
#define HOUSE_TASK @"house"
#define ROOM_TASK @"romm"
#define YEAR_TASK @"Year"
#define SERVICE_TAKS @"service"
#define HOUR_TASK @"hour"
#define MONTH_TASK @"month"
#define SECOND_TASK @"Second"
#define DATA_TASK @"data"
#define ADMIN_TAREA @"adminTarea"

#define kSizeForDatePicker 200

@interface EventosViewController ()<CKCalendarDelegate>
{
    UIView *viewBackground;
    
    UITextField *textFieldTime;
    UITextField *textFieldDate;
    UITextField *textFieldDescription;
    UITextField *textFieldName;
    UITextField *textFieldActions;
    UITextField *textFieldServices;
    UITextField *textFieldRooms;
    UITextField *textFieldData;
    
    BOOL isDateDatePickerShow;
    BOOL isTimeDatePickerShow;
    
    BOOL isRoomSelected;
    BOOL isServiceSelected;
    BOOL isActionSelected;
    BOOL isDataSelected;
    
    NSString *roomName;
    NSString *serviceName;
    int serviceNumber;
    NSString *actionName;
    NSString *data;
    
    UITableView *tableActions;
    
    NSArray *arrayData;
}
@property(nonatomic, weak) CKCalendarView *calendar;
@property(nonatomic, strong) UILabel *dateLabel;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;

@property(nonatomic, strong) NSMutableDictionary *allTareas;
@property(nonatomic, strong) NSMutableArray *tareasFechaPulsada;

@property (nonatomic, strong) UIView *addTareaView;
@property (nonatomic, strong) UIView *actionsView;
@property (nonatomic, strong) UIView *addActionsToEventView;


@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *startDateTime;
@property (nonatomic, strong) UIDatePicker *myDatePicker;

@property (nonatomic, strong) NSMutableDictionary *dictionaryRooms;

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

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (appDelegate.dataForEvents != nil) {
        [textFieldData setText:appDelegate.dataForEvents];
    }
    
    if (isDataSelected) {
        [self addButtonAction];
        isDataSelected = NO;
    }
    
    [self.navigationController.navigationBar setHidden:NO];
	[[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)configureViewCalendar{
    CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
    self.calendar = calendar;
    calendar.delegate = self;
    self.calendar.backgroundColor = colorApp;
    self.dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *now = [NSDate date];
    [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
    self.minimumDate = now;//[self.dateFormatter dateFromString:@"20/09/2012"];
    
    self.disabledDates = nil;//@[
//                           [self.dateFormatter dateFromString:@"9/04/2013"],
//                           [self.dateFormatter dateFromString:@"10/04/2013"],
//                           [self.dateFormatter dateFromString:@"12/04/2013"]
//                           ];
    
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
    [self.navigationItem setTitle:@"Tasks"];
    
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
    int tasksNumber = [appDelegate.tasks count];
    
    NSDictionary *tasks = appDelegate.tasks;
    
    NSArray *namesEvents = [tasks allKeys];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < tasksNumber; i++) {
        
        NSDictionary *dicTask = [tasks objectForKey:[namesEvents objectAtIndex:i]];
        NSMutableDictionary *tarea = [[NSMutableDictionary alloc] init];
        DLog(@"%@",dicTask);
        tarea = [[NSMutableDictionary alloc] initWithDictionary:dicTask];
        [array addObject:tarea];
        
        NSString *st = [NSString stringWithFormat:@"%@/%@/%@",[tarea objectForKey:@"Day"],[tarea objectForKey:@"Month"],[tarea objectForKey:@"Year"]];
        if ([self.allTareas objectForKey:st] == nil) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            [array addObject:tarea];
            [self.allTareas setObject:array forKey:st];
        }
        else{
            NSMutableArray *array = [self.allTareas objectForKey:st];
            [array addObject:tarea];
            [self.allTareas setObject:array forKey:st];
        }
    }
    //NSArray *array = [[NSArray alloc] initWithObjects:tarea,tarea1,tarea2,tarea3,tarea4, nil];
    //[self.allTareas setObject:array forKey:@"06/05/2014"];
    DLog(@"self.allTareas %@",self.allTareas);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    viewBackground = [[UIView alloc] initWithFrame:self.view.frame];
    [viewBackground setBackgroundColor:[UIColor blackColor]];
    [viewBackground setAlpha:0.4];
    [viewBackground setHidden:YES];
    
    [self.navigationController.navigationBar setHidden:NO];
    
    [self configureTareasWithServer];
    
    [self configureViewCalendar];
    
    [self configureNavBar];
    
    [self configurePaperView];
    
    [self configureView];
    
    [self parseJSONforActions];
    
    [self.view addSubview:viewBackground];
}

- (void)parseJSONforActions{
    DLog(@"Parse JSON:%@",appDelegate.jsonArray);
    
    NSArray *arrayServices = [[[appDelegate.jsonArray objectForKey:@"houses"] objectAtIndex:0] objectForKey:@"rooms"];
    
    NSMutableDictionary *dictionaryServices = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < [arrayServices count]; i++) {
        NSMutableDictionary *dic = [arrayServices objectAtIndex:i];
        [dictionaryServices setObject:dic forKey:[dic objectForKey:@"name"]];
    }
    self.dictionaryRooms = dictionaryServices;
    DLog(@"Dictionary Rooms: %@",self.dictionaryRooms);
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
    DLog(@"tareasFechaPulsada %@",self.tareasFechaPulsada);
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

- (void)touchUpView{
    [textFieldTime resignFirstResponder];
    [textFieldName resignFirstResponder];
    [textFieldDescription resignFirstResponder];
    [textFieldDate resignFirstResponder];
    [self hideDatePicker];
}

-(void)createAddTareaMenu
{
 	if (!self.addTareaView) {
        
		self.addTareaView = [[UIView alloc] initWithFrame:CGRectMake(20, -400, 280, 400)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchUpView)];
        [self.addTareaView addGestureRecognizer:tap];
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
		
		UILabel *titleEventLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.addTareaView.frame.size.width/2 - 70, 0, 140, 40)];
        //[titleEventLabel setCenter:CGPointMake(self.addTareaView.frame.size.width/2, 30)];
        [titleEventLabel setTextAlignment:NSTextAlignmentCenter];
        [titleEventLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:22]];
        [titleEventLabel setTextColor:colorApp];
        [titleEventLabel setText:NSLocalizedString(@"New Event",@"")];
        
        UILabel *nameEventLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 140, 40)];
        //[nameEventLabel setCenter:CGPointMake(40, 80)];
        [nameEventLabel setTextAlignment:NSTextAlignmentLeft];
        [nameEventLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:22]];
        [nameEventLabel setTextColor:colorApp];
        [nameEventLabel setText:NSLocalizedString(@"Name:",@"")];
        
        textFieldName = [[UITextField alloc] initWithFrame:CGRectMake(120, 40, 140, 30)];
        [textFieldName setPlaceholder:@"name for event"];
        [textFieldName setBorderStyle:UITextBorderStyleBezel];
        
        UILabel *dateEventLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 140, 40)];
        //[dateEventLabel setCenter:CGPointMake(40, 200)];
        [dateEventLabel setTextAlignment:NSTextAlignmentLeft];
        [dateEventLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:22]];
        [dateEventLabel setTextColor:colorApp];
        [dateEventLabel setText:NSLocalizedString(@"Date:",@"")];
        
        textFieldDate = [[UITextField alloc] initWithFrame:CGRectMake(120, 80, 140, 30)];
        UIView *viewDate = [[UIView alloc] initWithFrame:textFieldDate.frame];
        [textFieldDate setPlaceholder:@"date for event"];
        [textFieldDate setBorderStyle:UITextBorderStyleBezel];
        UITapGestureRecognizer *tapDate = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDatePickerDate)];
        [viewDate addGestureRecognizer:tapDate];
        
        UILabel *timeEventLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, 140, 40)];
        //[timeEventLabel setCenter:CGPointMake(40, 240)];
        [timeEventLabel setTextAlignment:NSTextAlignmentLeft];
        [timeEventLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:22]];
        [timeEventLabel setTextColor:colorApp];
        [timeEventLabel setText:NSLocalizedString(@"Time: ",@"")];
        
        textFieldTime = [[UITextField alloc] initWithFrame:CGRectMake(120, 120, 140, 30)];
        UIView *viewTime = [[UIView alloc] initWithFrame:textFieldTime.frame];
        [textFieldTime setPlaceholder:@"time for event"];
        [textFieldTime setBorderStyle:UITextBorderStyleBezel];
        UITapGestureRecognizer *tapTime = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDatePickerTime)];
        [viewTime addGestureRecognizer:tapTime];
        
//        UILabel *actionsEventLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, 140, 40)];
//        //[actionsEventLabel setCenter:CGPointMake(40, 300)];
//        [actionsEventLabel setTextAlignment:NSTextAlignmentLeft];
//        [actionsEventLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:22]];
//        [actionsEventLabel setTextColor:colorApp];
//        [actionsEventLabel setText:NSLocalizedString(@"Actions:",@"")];
        
        UILabel *roomEventLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 180, 140, 40)];
        //[timeEventLabel setCenter:CGPointMake(40, 240)];
        [roomEventLabel setTextAlignment:NSTextAlignmentLeft];
        [roomEventLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:22]];
        [roomEventLabel setTextColor:colorApp];
        [roomEventLabel setText:NSLocalizedString(@"Room:",@"")];
        
        textFieldRooms = [[UITextField alloc] initWithFrame:CGRectMake(120, 180, 140, 30)];
        UIView *viewRooms = [[UIView alloc] initWithFrame:textFieldRooms.frame];
        [textFieldRooms setPlaceholder:@"name for room"];
        [textFieldRooms setBorderStyle:UITextBorderStyleBezel];
        UITapGestureRecognizer *tapRooms = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRooms)];
        [viewRooms addGestureRecognizer:tapRooms];
        
        UILabel *serviceEventLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 220, 140, 40)];
        //[timeEventLabel setCenter:CGPointMake(40, 240)];
        [serviceEventLabel setTextAlignment:NSTextAlignmentLeft];
        [serviceEventLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:22]];
        [serviceEventLabel setTextColor:colorApp];
        [serviceEventLabel setText:NSLocalizedString(@"Service",@"")];
        
        textFieldServices = [[UITextField alloc] initWithFrame:CGRectMake(120, 220, 140, 30)];
        UIView *viewServices = [[UIView alloc] initWithFrame:textFieldServices.frame];
        [textFieldServices setPlaceholder:@"name for service"];
        [textFieldServices setBorderStyle:UITextBorderStyleBezel];
        UITapGestureRecognizer *tapServices = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showServices)];
        [viewServices addGestureRecognizer:tapServices];
        
        UILabel *actionsEventButton = [[UILabel alloc] initWithFrame:CGRectMake(20, 260, 140, 40)];
        //[descriptionEventLabel setCenter:CGPointMake(40, 120)];
        [actionsEventButton setTextAlignment:NSTextAlignmentLeft];
        [actionsEventButton setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:22]];
        [actionsEventButton setTextColor:colorApp];
        [actionsEventButton setText:NSLocalizedString(@"Actions:",@"")];
        
        textFieldActions = [[UITextField alloc] initWithFrame:CGRectMake(120, 260, 140, 30)];
        UIView *viewActions = [[UIView alloc] initWithFrame:textFieldActions.frame];
        [textFieldActions setPlaceholder:@"name for event"];
        [textFieldActions setBorderStyle:UITextBorderStyleBezel];
        UITapGestureRecognizer *tapActions = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showActions)];
        [viewActions addGestureRecognizer:tapActions];
        
        UILabel *dataEventLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, 140, 40)];
        //[descriptionEventLabel setCenter:CGPointMake(40, 120)];
        [dataEventLabel setTextAlignment:NSTextAlignmentLeft];
        [dataEventLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:22]];
        [dataEventLabel setTextColor:colorApp];
        [dataEventLabel setText:NSLocalizedString(@"Data:",@"")];
        
        textFieldData = [[UITextField alloc] initWithFrame:CGRectMake(120, 300, 140, 30)];
        UIView *viewData = [[UIView alloc] initWithFrame:textFieldData.frame];
        [textFieldData setPlaceholder:@"name for data"];
        [textFieldData setBorderStyle:UITextBorderStyleBezel];
        UITapGestureRecognizer *tapData = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showData)];
        [viewData addGestureRecognizer:tapData];
        
		
        [self.addTareaView addSubview:addButton];
        [self.addTareaView addSubview:cancelButton];
        
        [self.addTareaView addSubview:actionsEventButton];
        [self.addTareaView addSubview:textFieldActions];
        [self.addTareaView addSubview:viewActions];
        [self.addTareaView addSubview:roomEventLabel];
        [self.addTareaView addSubview:textFieldRooms];
        [self.addTareaView addSubview:viewRooms];
        [self.addTareaView addSubview:serviceEventLabel];
        [self.addTareaView addSubview:textFieldServices];
        [self.addTareaView addSubview:viewServices];
        [self.addTareaView addSubview:dataEventLabel];
        [self.addTareaView addSubview:textFieldData];
        [self.addTareaView addSubview:viewData];
        
        [self.addTareaView addSubview:titleEventLabel];
        [self.addTareaView addSubview:textFieldName];
        [self.addTareaView addSubview:nameEventLabel];
        [self.addTareaView addSubview:textFieldDescription];

        [self.addTareaView addSubview:textFieldDate];
        [self.addTareaView addSubview:viewDate];
        [self.addTareaView addSubview:dateEventLabel];
        [self.addTareaView addSubview:textFieldTime];
        [self.addTareaView addSubview:viewTime];
        [self.addTareaView addSubview:timeEventLabel];
		
		[self.parentViewController.view addSubview:self.addTareaView];
        
       
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

- (void)showData{
    isRoomSelected = NO;
    isServiceSelected = NO;
    isActionSelected = NO;
    isDataSelected = YES;
    [self hideDatePicker];
    [textFieldName resignFirstResponder];
    if([serviceName isEqualToString:@"TV"]) {
        TvItemViewController *roomsController = (TvItemViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"tvController"];
        [self presentViewController:roomsController animated:YES completion:nil];// pushViewController:roomsController animated:YES];
        [roomsController setModeTVItem:YES];
    }
    else{
        [self createTableView];
        [viewBackground setHidden:NO];
        [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.actionsView frameMoveToX:20];
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)showActions{
    isRoomSelected = NO;
    isServiceSelected = NO;
    isActionSelected = YES;
    isDataSelected = NO;
    
    [self hideDatePicker];
    [textFieldName resignFirstResponder];
    
    [self createTableView];
	[viewBackground setHidden:NO];
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		[self.actionsView frameMoveToX:20];
	} completion:^(BOOL finished) {
        
    }];
}

- (void)showServices{
    isRoomSelected = NO;
    isServiceSelected = YES;
    isActionSelected = NO;
    isDataSelected = NO;
    
    [self hideDatePicker];
    [textFieldName resignFirstResponder];
    
    [self createTableView];
	[viewBackground setHidden:NO];
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		[self.actionsView frameMoveToX:20];
	} completion:^(BOOL finished) {
        
    }];
}

- (void)showRooms{
    isRoomSelected = YES;
    isServiceSelected = NO;
    isActionSelected = NO;
    isDataSelected = NO;
    
    [self hideDatePicker];
    [textFieldName resignFirstResponder];
    
    [self createTableView];
	[viewBackground setHidden:NO];
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		[self.actionsView frameMoveToX:20];
	} completion:^(BOOL finished) {
        
    }];
}

- (void)addTarea{
    [self cancelTareaButton];
    
    [self createAddActionsToEventView];
    [viewBackground setHidden:NO];
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		[self.addActionsToEventView frameMoveToY:0];
	} completion:^(BOOL finished) {
        [self sendTarea];
        [self cleanAddTarea];
    }];
}

- (void)cancelTareaButton
{
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
		[self.addTareaView frameMoveToY:-400];
	} completion:^(BOOL finished) {
        [viewBackground setHidden:YES];
    }];
}

- (void)cancelActionsButton
{
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
		[self.actionsView frameMoveToX:640];
	} completion:^(BOOL finished) {
        [viewBackground setHidden:YES];
    }];
}

- (void) addButtonAction{
    [self createAddTareaMenu];
	[viewBackground setHidden:NO];
    [self createDatePicker];
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		[self.addTareaView frameMoveToY:80];
	} completion:^(BOOL finished) {
        
    }];
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
    if (self.tareasFechaPulsada != nil) {
        return [self.tareasFechaPulsada count];
    }
    else
        return 0;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   // UIViewController *vc = [self nextViewControllerAtPoint:CGPointZero];
   // [self.navigationController pushViewController:vc animated:YES];
    TareaViewController *vc = [[TareaViewController alloc] initWithConfig:[self.tareasFechaPulsada objectAtIndex:indexPath.row]];
    //[self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - Datepicker Methods
- (void)createDatePicker
{
    self.myDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, kSizeForDatePicker)];
    [self.myDatePicker setDatePickerMode:UIDatePickerModeDate];
    [self.myDatePicker setMinimumDate:[NSDate date]];
    [self.myDatePicker setBackgroundColor:[UIColor whiteColor]];
    [self.myDatePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    [self.parentViewController.view addSubview:self.myDatePicker];
}


- (void)showDatePickerTime
{
    isTimeDatePickerShow = YES;
    isDateDatePickerShow = NO;
    [textFieldName resignFirstResponder];
    [self.myDatePicker setDatePickerMode:UIDatePickerModeTime];
	[UIView animateWithDuration:0.4
					 animations:^{
						 [self.myDatePicker frameMoveToY:self.view.frame.size.height-kSizeForDatePicker];
					 } completion:^(BOOL finished) {
						 //isDataPickerShown = YES;
					 }];
}

- (void)showDatePickerDate
{
    isDateDatePickerShow = YES;
    isTimeDatePickerShow = NO;
    [textFieldName resignFirstResponder];
    [self.myDatePicker setDatePickerMode:UIDatePickerModeDate];
	[UIView animateWithDuration:0.4
					 animations:^{
						 [self.myDatePicker frameMoveToY:self.view.frame.size.height-kSizeForDatePicker];
					 } completion:^(BOOL finished) {
						 //isDataPickerShown = YES;
					 }];
}


- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    self.startDate = datePicker.date;
    self.startDateTime = datePicker.date;
}


- (void)hideDatePicker
{
    if (isDateDatePickerShow) {
        [self changeTextForDate];
    }
    else{
        [self changeTextForTime];
    }
    isDateDatePickerShow = NO;
    isTimeDatePickerShow = NO;
	[UIView animateWithDuration:0.3
					 animations:^{
						 [self.myDatePicker frameMoveToY:self.view.frame.size.height];
					 } completion:^(BOOL finished) {
						 //isDataPickerShown = NO;
					 }];
}

- (void)changeTextForTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    
    //Optionally for time zone converstions
    //[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    
    NSString *stringFromDate = [formatter stringFromDate:self.startDate];
    [textFieldTime setText:stringFromDate];
    
}

- (void)changeTextForDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    //Optionally for time zone converstions
    //[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    
    NSString *stringFromDate = [formatter stringFromDate:self.startDateTime];
    [textFieldDate setText:stringFromDate];
    
}

#pragma mark Tabla Actions and methods

- (void)createTableView{
    if (!self.actionsView) {
        
		self.actionsView = [[UIView alloc] initWithFrame:CGRectMake(640, 80, 280, 400)];
        //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchUpViewTable)];
        //[self.actionsView addGestureRecognizer:tap];
		[self.actionsView setBackgroundColor:[UIColor whiteColor]];
        
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        // [IonIcons label:cancelButton.titleLabel setIcon:icon_close_circled size:15.0f color:[UIColor whiteColor] sizeToFit:YES];
        [cancelButton setImage:[IonIcons imageWithIcon:icon_close_circled size:20.0f color:[UIColor blackColor]] forState:UIControlStateNormal];
		//[exit setImage:[UIImage imageNamed:icon_close_circled] forState:UIControlStateNormal];
        //[cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        //[cancelButton setTitleColor:colorApp forState:UIControlStateNormal];
		[cancelButton addTarget:self action:@selector(cancelActionsButton) forControlEvents:UIControlEventTouchUpInside];
		
		UILabel *titleEventLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.actionsView.frame.size.width/2 - 70, 30, 140, 40)];
        //[titleEventLabel setCenter:CGPointMake(self.addTareaView.frame.size.width/2, 30)];
        [titleEventLabel setTextAlignment:NSTextAlignmentCenter];
        [titleEventLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:22]];
        [titleEventLabel setTextColor:colorApp];
        [titleEventLabel setText:NSLocalizedString(@"Select one action",@"")];
        
        
        tableActions = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, 280, 330)];
        [tableActions setDelegate:self];
        [tableActions setDataSource:self];
        [tableActions setBackgroundColor:[UIColor whiteColor]];
        
        [self.actionsView addSubview:cancelButton];
        [self.actionsView addSubview:titleEventLabel];
        [self.actionsView addSubview:tableActions];
        
		[self.parentViewController.view addSubview:self.actionsView];
        
        
	}
    else{
        [tableActions reloadData];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isRoomSelected) {
       return [[self.dictionaryRooms allKeys] count];
    }
    else if (isServiceSelected){
       return [[[self.dictionaryRooms objectForKey:roomName] objectForKey:@"services"] count];
    }
    else if (isActionSelected){
       return [[[[[self.dictionaryRooms objectForKey:roomName] objectForKey:@"services"] objectAtIndex:serviceNumber] objectForKey:@"actions"] count];
    }
    else if (isDataSelected){
        if ([serviceName isEqualToString:@"LIGHTS"]) {
            arrayData = [[NSArray alloc] initWithObjects:@"ON",@"OFF",nil];
            return [arrayData count];
        }
        else if ([serviceName isEqualToString:@"BLINDS"]){
            arrayData = [[NSArray alloc] initWithObjects:@"UP",@"DOWN",nil];
            return [arrayData count];
        }
        else{
            return 0;
        }
    }
    else{
        return 3;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *nameCellIdentifier = @"NameCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nameCellIdentifier];
	if (!cell)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nameCellIdentifier];
	
	[cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    [cell.textLabel setText:@"Mola"];
    
    if (isRoomSelected) {
        [cell.textLabel setText:[[self.dictionaryRooms allKeys] objectAtIndex:indexPath.row]];
    }
    else if (isServiceSelected){
        [cell.textLabel setText:[[[[self.dictionaryRooms objectForKey:roomName] objectForKey:@"services"] objectAtIndex:indexPath.row] objectForKey:@"name"]];
    }
    else if (isActionSelected){
        [cell.textLabel setText:[[[[[self.dictionaryRooms objectForKey:roomName] objectForKey:@"services"] objectAtIndex:serviceNumber] objectForKey:@"actions"] objectAtIndex:indexPath.row]];
    }
    else if(isDataSelected){
        [cell.textLabel setText:[arrayData objectAtIndex:indexPath.row]];
    }
	
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self cancelActionsButton];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (isRoomSelected) {
        roomName = [cell.textLabel text];
        [textFieldRooms setText:roomName];
    }
    else if (isServiceSelected){
        serviceName = [cell.textLabel text];
        serviceNumber = indexPath.row;
        [textFieldServices setText:serviceName];
    }
    else if (isActionSelected){
        actionName = [cell.textLabel text];
        [textFieldActions setText:actionName];
    }
    else if (isDataSelected){
        data = [cell.textLabel text];
        [textFieldData setText:data];
    }
    else{
        [textFieldActions setText:[cell.textLabel text]];
    }
    
    isRoomSelected = NO;
    isServiceSelected = NO;
    isActionSelected = NO;
}

- (void)cleanAddTarea{
    [textFieldData setText:@""];
    [textFieldActions setText:@""];
    [textFieldDate setText:@""];
    [textFieldName setText:@""];
    [textFieldRooms setText:@""];
    [textFieldServices setText:@""];
    [textFieldTime setText:@""];
}

- (void)sendTarea{
    NSString *nameEvent = textFieldName.text;
    NSString *nameUser = appDelegate.nameUser;
    NSString *nameHouse = appDelegate.nameHouse;
    NSString *nameRoom = roomName;
    NSString *nameService = serviceName;//appDelegate.nameService;
    NSString *nameAction = actionName;//appDelegate.nameAction;
    NSString *time = [NSString stringWithFormat:@"%@ %@",textFieldDate.text,textFieldTime.text];
    NSString *dataEvent = textFieldData.text;
    //[NSString stringWithFormat:@"%d",button];
    //NSString *status = @"1";
    
    NSString* command = @"createprogramaction";//(sender.tag==1)?@"register":@"login";
    NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  command, @"command",
                                  nameEvent,@"programname",
                                  nameUser, @"username",
                                  nameHouse, @"housename",
                                  nameRoom, @"roomname",
                                  nameService, @"servicename",
                                  nameAction, @"actionname",
                                  dataEvent,@"data",
                                  time,@"start",
                                  nil];
    //make the call to the web API
    [[API sharedInstance] commandWithParams:params
                               onCompletion:^(NSDictionary *json) {
                                   //handle the response
                                   //result returned
                                   //NSDictionary* res = [[json objectForKey:@"result"] objectAtIndex:0];
                                   
                                   //Finaliza cargando
                                   //------------------
                                   if ([json objectForKey:@"ERROR"]==0) {
                                       // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pulsado" message:[NSString stringWithFormat:@"Enviado pulsación de boton %d",button] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                       //[alert show];
                                       DLog(@"Event has been created");
                                       
                                   } else {
                                       DLog(@"error to save event");
                                       //error
                                       //[UIAlertView error:[json objectForKey:@"error"]];
                                   }
                               }];
}


@end
