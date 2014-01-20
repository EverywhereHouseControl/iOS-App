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

@interface SetRoomsViewController (){
    int numberOfRooms;
    NSDictionary *dictionaryForRooms;
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
    
    numberOfRooms = ((NSString*)[appDelegate.jsonArray objectForKey:@"numerosH"]).intValue;
    dictionaryForRooms = [appDelegate.jsonArray objectForKey:@"Habitaciones"];
    
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
    
    NSArray *arrayRooms = [dictionaryForRooms objectForKey:[NSString stringWithFormat:@"H%d",indexPath.row+1]];
    
    [cell.roomName setText:[arrayRooms objectAtIndex:0]];
    [cell.roomName setTextColor:[UIColor whiteColor]];
    [cell setBackgroundColor:[UIColor clearColor]];
        
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
        NSArray *arrayRooms = [dictionaryForRooms objectForKey:[NSString stringWithFormat:@"H%d",i+1]];

        RoomsViewController *room = [[RoomsViewController alloc] initWithFrame:CGRectMake(0, 0, 320, 568) withNameOfRoom:[arrayRooms objectAtIndex:0] numberOfRoom:i andNumberOfItems:[arrayRooms objectAtIndex:1] andDelegate:self];
        room.title = [arrayRooms objectAtIndex:0];
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

@end
