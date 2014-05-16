//
//  RoomsViewController.m
//  ehc
//
//  Created by kinki on 09/12/13.
//  Copyright (c) 2013 EHC. All rights reserved.
//

#import "SetRoomsViewController.h"
#import "RoomsCell.h"
#import "SGViewPagerController.h"
#import "SGAnnotatedPagerController.h"
#import "RoomsViewController.h"
#import "AppDelegate.h"
#import "TvItemViewController.h"
#import "LightItemViewController.h"
#import "ECSlidingViewController.h"
#import "IonIcons.h"
#import "ProfileViewController.h"
#import "EventosViewController.h"
#import "BlindsViewController.h"

@interface SetRoomsViewController (){
    int numberOfRooms;
    NSArray *arrayForRooms;
}

@end

@implementation SetRoomsViewController
@synthesize collectionRooms;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.000 green:0.681 blue:0.681 alpha:1.000]];
    self.navigationController.navigationBar.tintColor =  [UIColor whiteColor];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationItem setHidesBackButton:YES];
    
    [self.navigationItem setLeftBarButtonItem: [[UIBarButtonItem alloc] initWithImage:[IonIcons imageWithIcon:icon_navicon size:28.0f color:[UIColor whiteColor]] style:UIBarButtonItemStylePlain target:self action:@selector(menuButton:)]];
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        
        //        if (isIpad){
        //            self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuIpad"];
        //        }
        //        else {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu5"];
        ((MenuViewController*)self.slidingViewController.underLeftViewController).delegateActions = self;
    }
    //        else{
    //            self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    //        }
    //    }
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
	// Do any additional setup after loading the view.
    [self.collectionRooms registerNib:[UINib nibWithNibName:@"RoomsCell" bundle:nil] forCellWithReuseIdentifier:@"RoomsCellID"];
    
    //numberOfRooms = ((NSString*)[appDelegate.jsonArray objectForKey:@"numerosH"]).intValue;
    
    
    numberOfRooms = [[appDelegate.currentHouseDic objectForKey:@"rooms"] count];
    arrayForRooms = [appDelegate.currentHouseDic objectForKey:@"rooms"];
    
    self.navigationItem.title = @"Rooms";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Datasource
//
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return numberOfRooms;
}
//
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}
//
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifierRooms = @"RoomsCellID";
    
    RoomsCell* cell;
    cell = [cv dequeueReusableCellWithReuseIdentifier:CellIdentifierRooms forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[RoomsCell alloc] initWithFrame:CGRectMake(0, 0, 130, 130)];
    }
    
    //NSArray *arrayRooms = [dictionaryForRooms objectForKey:[NSString stringWithFormat:@"R%d",indexPath.row+1]];
    NSDictionary *room = [arrayForRooms objectAtIndex:indexPath.row];
    
    [cell.roomName setText:[room objectForKey:@"name"]];
    [cell.roomName setTextColor:[UIColor whiteColor]];
    [cell setBackgroundColor:[UIColor lightGrayColor]];
    [cell.layer setCornerRadius:0.5];

    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
    int fichaSeleccionada = indexPath.row+1;
    
/*    SGViewPagerController *pager = [[SGViewPagerController alloc] initWithNibName:@"SGViewPagerController" bundle:nil];
    pager.title = @"UIPageControl";
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:5];
    for (int i = 0; i < 5; i++) {
        SGExampleController *ec = [[SGExampleController alloc] init];
        ec.title = [NSString stringWithFormat:@"Nr. %d", i+1];
        [array addObject:ec];
    }
    [pager setViewControllers:array animated:NO];*/
    
    SGAnnotatedPagerController *annotatedPager = [[SGAnnotatedPagerController alloc] initWithNibName:@"SGAnnotatedPagerController" bundle:nil];
    annotatedPager.title = @"Items";
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:5];
    for (int i = 0; i < numberOfRooms; i++) {
        //NSArray *arrayRooms = [dictionaryForRooms objectForKey:[NSString stringWithFormat:@"H%d",i+1]];
        NSDictionary *dic = [arrayForRooms objectAtIndex:i];
        if (indexPath.row == i) {
            appDelegate.nameRoom = [dic objectForKey:@"name"];
        }
        NSLog(@"%@",dic);
        RoomsViewController *room = [[RoomsViewController alloc] initWithFrame:CGRectMake(0, 0, 320, 568) withNameOfRoom:[dic objectForKey:@"name"] numberOfRoom:i andNumberOfItems:[dic objectForKey:@"services"] andDelegate:self];
        room.title = [dic objectForKey:@"name"];
        [array addObject:room];
    }
    [annotatedPager setViewControllers:array animated:NO];
    NSLog(@"Row:%d",indexPath.row);
    [annotatedPager loadView];
    [annotatedPager setPageIndex:indexPath.row animated:YES];
    [self.navigationController pushViewController:annotatedPager animated:YES];
//    app.window.rootViewController = annotatedPager;
//    [self presentViewController:annotatedPager animated:YES completion:nil];
//    UITabBarController *tabC = [[UITabBarController alloc] init];
//    [tabC setViewControllers:[NSArray arrayWithObjects:pager, annotatedPager, nil] animated:NO];
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
    //int fichaSeleccionada = indexPath.row;
    //fichaSeleccionada = -1;
    [[collectionRooms cellForItemAtIndexPath:indexPath] setSelected:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

        CGSize retval = CGSizeMake(130, 130);
        return retval;
}


- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 20, 50, 20);
}


#pragma mark - Methods Protocol Items

- (void)sacarTV{
    TvItemViewController *roomsController = (TvItemViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"tvController"];
    [self.navigationController pushViewController:roomsController animated:YES];
}

- (void)sacarLight{
    LightItemViewController *roomsController = (LightItemViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"lightController"];
    [self.navigationController pushViewController:roomsController animated:YES];
}

- (void)sacarBlinds{
    BlindsViewController *roomsController = (BlindsViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"blindsController"];
    [self.navigationController pushViewController:roomsController animated:YES];
}

- (void)menuButton:(id)sender{
        [self.slidingViewController anchorTopViewTo:ECRight];
}

#pragma mark - Metodos de protocolo

-(void)cambiarDeVista:(NSString*)newView{
    if ([newView isEqualToString:@"Profile5"]) {
        [self llamarAperfil:newView];
    }
    else if ([newView isEqualToString:@"Settings5"]){
        [self llamarAajustes:newView];
    }
    else if ([newView isEqualToString:@"Control5"]){
        [self llamarAcontrol:newView];
    }
    else if ([newView isEqualToString:@"Tasks5"]){
        [self llamarAtasks:newView];
    }
    else if ([newView isEqualToString:@"Intranet5"]){
        [self llamarAintranet:newView];
    }
    else if ([newView isEqualToString:@"Help5"]){
        [self llamarAayuda:newView];
    }
}

-(void)llamarAperfil:(NSString*)identifier{
        ProfileViewController* perfilView = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
        [self.navigationController pushViewController:perfilView animated:NO];
}

-(void)llamarAajustes:(NSString*)identifier{
    //    AjustesViewController *ajustesView = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    //    [self.navigationController pushViewController:ajustesView animated:NO];
    //    voyAjugar = NO;
}

-(void)llamarAcontrol:(NSString*)identifier{
        SetRoomsViewController *marketView = [self.storyboard instantiateViewControllerWithIdentifier:@"roomsView"];
        [self.navigationController pushViewController:marketView animated:NO];
}

-(void)llamarAtasks:(NSString*)identifier{
        EventosViewController *rankingView = [self.storyboard instantiateViewControllerWithIdentifier:@"eventsView"];
        [self.navigationController pushViewController:rankingView animated:NO];
}

-(void)llamarAintranet:(NSString*)identifier{
    //    RankingViewController *rankingView = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    //    [self.navigationController pushViewController:rankingView animated:NO];
    //    voyAjugar = NO;
}

-(void)llamarAayuda:(NSString*)identifier{
    //    AyudaViewController *ayudaView = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    //    [self.navigationController pushViewController:ayudaView animated:NO];
    //    voyAjugar = NO;
}

@end