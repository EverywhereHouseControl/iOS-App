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

@interface SetRoomsViewController (){
    NSArray *roomsArray;
    NSArray *itemsForLiving;
    NSArray *itemsForKitchen;
    NSArray *itemsForGarage;
    NSArray *itemsForBathRoom;
    NSArray *itemsForSingleRoom;
    NSArray *itemsForGarden;
    NSDictionary *dictionaryForItemsInRooms;
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
	// Do any additional setup after loading the view.
    [self.collectionRooms registerNib:[UINib nibWithNibName:@"RoomsCell" bundle:nil] forCellWithReuseIdentifier:@"RoomsCellID"];
    roomsArray = [[NSArray alloc] initWithObjects:@"Salón",@"Cocina",@"Garage",@"Baño",@"Habitación",@"Jardín", nil];
    itemsForLiving = [[NSArray alloc] initWithObjects:@"TV",@"DVD",@"Minicadena",@"Aire",@"Calefacción",@"Luces", nil];
    itemsForKitchen = [[NSArray alloc] initWithObjects:@"TV",@"Microhondas",@"Minicadena",@"Aire",@"Calefacción",@"Luces", nil];
    itemsForGarage = [[NSArray alloc] initWithObjects:@"Puerta",@"Minicadena",@"Aire",@"Calefacción",@"Luces", nil];
    itemsForBathRoom = [[NSArray alloc] initWithObjects:@"Calefacción",@"Luces", nil];
    itemsForSingleRoom = [[NSArray alloc] initWithObjects:@"TV",@"Minicadena",@"Aire",@"Calefacción",@"Luces", nil];
    itemsForGarden = [[NSArray alloc] initWithObjects:@"Luces",@"Video", nil];
    dictionaryForItemsInRooms = [NSDictionary dictionaryWithObjectsAndKeys:itemsForLiving,roomsArray[0],itemsForKitchen,roomsArray[1],itemsForGarage,roomsArray[2],itemsForBathRoom,roomsArray[3],itemsForSingleRoom,roomsArray[4],itemsForGarden,roomsArray[5], nil];
    
    self.navigationItem.title = @"Rooms";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Datasource
//
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return 6;
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
    
    switch (indexPath.row) {
        case 0:
            [cell.roomName setText:@"Salón"];
            [cell.roomName setTextColor:[UIColor whiteColor]];
            [cell setBackgroundColor:[UIColor clearColor]];
            break;
        case 1:
            [cell.roomName setText:@"Terraza"];
            [cell.roomName setTextColor:[UIColor whiteColor]];
            [cell setBackgroundColor:[UIColor clearColor]];
            break;
        case 2:
            [cell.roomName setText:@"Cocina"];
            [cell.roomName setTextColor:[UIColor whiteColor]];
            [cell setBackgroundColor:[UIColor clearColor]];
            break;
        case 3:
            [cell.roomName setText:@"Garage"];
            [cell.roomName setTextColor:[UIColor whiteColor]];
            [cell setBackgroundColor:[UIColor clearColor]];
            break;
        case 4:
            [cell.roomName setText:@"Habitación 1"];
            [cell.roomName setTextColor:[UIColor whiteColor]];
            [cell setBackgroundColor:[UIColor clearColor]];
            break;
        case 5:
            [cell.roomName setText:@"Habitación 2"];
            [cell.roomName setTextColor:[UIColor whiteColor]];
            [cell setBackgroundColor:[UIColor clearColor]];
            break;
            
        default:
            break;
    }
        
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
    for (int i = 0; i < [roomsArray count]; i++) {
        
        RoomsViewController *room = [[RoomsViewController alloc] initWithFrame:CGRectMake(0, 0, 320, 568) withNameOfRoom:roomsArray[i] numberOfRoom:i andNumberOfItems:dictionaryForItemsInRooms[roomsArray[i]] andDelegate:self];
        room.title = roomsArray[i];
        [array addObject:room];
    }
    [annotatedPager setViewControllers:array animated:NO];
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

@end
