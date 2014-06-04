//
//  HousesViewController.m
//  ehc
//
//  Created by Víctor Vicente on 23/04/14.
//  Copyright (c) 2014 EHC. All rights reserved.
//

#import "HousesViewController.h"
#import "HousesCell.h"
#import "InitViewController.h"

@interface HousesViewController (){
    int numberOfHouses;
    NSArray *dictionaryForHouses;
}

@end

@implementation HousesViewController
@synthesize collectionHouses;

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
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.collectionHouses registerNib:[UINib nibWithNibName:@"HousesCell" bundle:nil] forCellWithReuseIdentifier:@"HousesCellID"];
    
    //numberOfRooms = ((NSString*)[appDelegate.jsonArray objectForKey:@"numerosH"]).intValue;
    numberOfHouses = [[appDelegate.jsonArray objectForKey:@"houses"] count];
    dictionaryForHouses = [appDelegate.jsonArray objectForKey:@"houses"];
    
    self.navigationItem.title = @"Houses";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];

//    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.000 green:0.681 blue:0.681 alpha:1.000]];
//    self.navigationController.navigationBar.tintColor =  [UIColor whiteColor];
//    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationItem setHidesBackButton:YES];
    //[self.navigationController.navigationBar setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Datasource
//
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return numberOfHouses;
}
//
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}
//
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifierRooms = @"HousesCellID";
    
    HousesCell* cell;
    cell = [cv dequeueReusableCellWithReuseIdentifier:CellIdentifierRooms forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[HousesCell alloc] initWithFrame:CGRectMake(0, 0, 130, 130)];
    }
    
    //NSArray *arrayRooms = [dictionaryForRooms objectForKey:[NSString stringWithFormat:@"R%d",indexPath.row+1]];
    NSDictionary *house = [dictionaryForHouses objectAtIndex:indexPath.row];
    
    [cell.houseName setText:[house objectForKey:@"name"]];
    [cell.houseName setTextColor:[UIColor whiteColor]];
    [cell setBackgroundColor:[UIColor lightGrayColor]];
    [cell.layer setCornerRadius:0.5];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
    int houseSelected = indexPath.row;
    appDelegate.houseSelected = indexPath.row;
    
    appDelegate.nameHouse = [[dictionaryForHouses objectAtIndex:houseSelected] objectForKey:@"name"];
    appDelegate.nameCountry = [[dictionaryForHouses objectAtIndex:houseSelected] objectForKey:@"country"];
    appDelegate.nameCity = [[dictionaryForHouses objectAtIndex:houseSelected] objectForKey:@"city"];
    appDelegate.currentHouseDic = [dictionaryForHouses objectAtIndex:houseSelected];
    appDelegate.tasks = [[dictionaryForHouses objectAtIndex:houseSelected] objectForKey:@"events"];
    
    InitViewController *initController = (InitViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"initView"];
    [self presentViewController:initController animated:YES completion:nil];
    /*    SGViewPagerController *pager = [[SGViewPagerController alloc] initWithNibName:@"SGViewPagerController" bundle:nil];
     pager.title = @"UIPageControl";
     
     NSMutableArray *array = [NSMutableArray arrayWithCapacity:5];
     for (int i = 0; i < 5; i++) {
     SGExampleController *ec = [[SGExampleController alloc] init];
     ec.title = [NSString stringWithFormat:@"Nr. %d", i+1];
     [array addObject:ec];
     }
     [pager setViewControllers:array animated:NO];*/
    
    //    app.window.rootViewController = annotatedPager;
    //    [self presentViewController:annotatedPager animated:YES completion:nil];
    //    UITabBarController *tabC = [[UITabBarController alloc] init];
    //    [tabC setViewControllers:[NSArray arrayWithObjects:pager, annotatedPager, nil] animated:NO];
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
    //int fichaSeleccionada = indexPath.row;
    //fichaSeleccionada = -1;
    [[collectionHouses cellForItemAtIndexPath:indexPath] setSelected:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize retval = CGSizeMake(130, 130);
    return retval;
}


- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 20, 50, 20);
}

- (void)configView{
    
}

@end
