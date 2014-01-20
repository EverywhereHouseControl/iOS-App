//
//  LivingRoomViewController.m
//  ehc
//
//  Created by kinki on 10/12/13.
//  Copyright (c) 2013 EHC. All rights reserved.
//

#import "RoomsViewController.h"
#import "ItemsCell.h"
#import "SGViewPagerController.h"
#import "SGAnnotatedPagerController.h"
#import "TvItemViewController.h"
#import "SetRoomsViewController.h"

#define kNameOfLivingRoom 0
#define kNameOfKitchenRoom 1
#define kNameOfGarageRoom 2
#define kNameOfBathRoom 3
#define kNameOfSingleRoom 4
#define kNameOfGardenRoom 5

#define TITLE_CONTROL_HEIGHT 25.0
#define STATUSBAR_HEIGHT 22.0

@interface RoomsViewController (){
    NSArray *itemsNamesArray;
}

@end

@implementation RoomsViewController
@synthesize collectionItems = _collectionItems;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withNameOfRoom:(NSString*)roomName numberOfRoom:(int)roomNumber andNumberOfItems:(NSArray*)arrayOfItems andDelegate:(id<protocolItemsDelegate>)delegate{
    self = [super init];
    if (self) {
        [self.view setFrame:frame];
        _delegate = delegate;
        /*switch (roomNumber) {
            case kNameOfLivingRoom:
                [self.view setBackgroundColor:[UIColor brownColor]];
                break;
            case kNameOfKitchenRoom:
                [self.view setBackgroundColor:[UIColor lightGrayColor]];
                break;
            case kNameOfGarageRoom:
                [self.view setBackgroundColor:[UIColor darkGrayColor]];
                break;
            case kNameOfBathRoom:
                [self.view setBackgroundColor:[UIColor whiteColor]];
                break;
            case kNameOfGardenRoom:
                [self.view setBackgroundColor:[UIColor greenColor]];
                break;
            case kNameOfSingleRoom:
                [self.view setBackgroundColor:[UIColor purpleColor]];
                break;
                
            default:
                [self.view setBackgroundColor:[UIColor brownColor]];
                break;
        }*/
        
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
        
        [_collectionItems registerNib:[UINib nibWithNibName:@"ItemsCell" bundle:nil] forCellWithReuseIdentifier:@"ItemsCellID"];
        
        //[self.view setBackgroundColor:[UIColor brownColor]];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionItems = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, 568) collectionViewLayout:layout];
        [_collectionItems setDataSource:self];
        [_collectionItems setDelegate:self];
        [_collectionItems setScrollEnabled:YES];
        
        [_collectionItems registerClass:[ItemsCell class] forCellWithReuseIdentifier:@"ItemsCellID"];
        [_collectionItems setBackgroundColor:[UIColor clearColor]];
        
        [self.view addSubview:_collectionItems];
        
       /* UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, STATUSBAR_HEIGHT, 320, 50)];
        [labelTitle setText:roomName];
        [labelTitle setTextAlignment:NSTextAlignmentCenter];
        [labelTitle setFont:[UIFont fontWithName:@"Noteworthy-Bold" size:25]];
        [labelTitle setTextColor:[UIColor whiteColor]];
        [self.view addSubview:labelTitle];*/
        
        itemsNamesArray = [NSArray arrayWithArray:arrayOfItems];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //[self.view setBackgroundColor:[UIColor brownColor]];
    //[self.collectionItems registerNib:[UINib nibWithNibName:@"ItemsCell" bundle:nil] forCellWithReuseIdentifier:@"ItemsCellID"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Datasource
//
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [itemsNamesArray count];
}
//
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}
//
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifierRooms = @"ItemsCellID";
    
    ItemsCell* cell;
    cell = [cv dequeueReusableCellWithReuseIdentifier:CellIdentifierRooms forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ItemsCell alloc] initWithFrame:CGRectMake(0, 0, 130, 130)];
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    UIImageView *img = [self devolverImagenItem:itemsNamesArray[indexPath.row]];
    [cell addSubview:img];
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, 130, 60)];
    
    if ([itemsNamesArray[indexPath.row] isEqualToString:@"Aire Acondicionado"]) {
        labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, 130, 60)];
    }
    else{
        labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, 130, 60)];
    }
    
    [labelTitle setText:itemsNamesArray[indexPath.row]];
    [labelTitle setTextAlignment:NSTextAlignmentCenter];
    [labelTitle setTextColor:[UIColor whiteColor]];
    [labelTitle setNumberOfLines:3];
    [labelTitle setFont:[UIFont fontWithName:@"Noteworthy-Bold" size:17]];
    [cell addSubview:labelTitle];
    
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
    
    /*SGAnnotatedPagerController *annotatedPager = [[SGAnnotatedPagerController alloc] initWithNibName:@"SGAnnotatedPagerController" bundle:nil];
    annotatedPager.title = @"TitleControl";
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:5];
    for (int i = 0; i < 5; i++) {
        RoomsViewController *living = [[RoomsViewController alloc] init];
        living.title = [NSString stringWithFormat:@"Salón"];
        [array addObject:living];
    }
    [annotatedPager setViewControllers:array animated:NO];
    
    [self presentViewController:annotatedPager animated:YES completion:nil];*/
    //    UITabBarController *tabC = [[UITabBarController alloc] init];
    //    [tabC setViewControllers:[NSArray arrayWithObjects:pager, annotatedPager, nil] animated:NO];
    
    if ([itemsNamesArray[indexPath.row] isEqualToString:@"TV"]) {
        [self llamarAsacarTv];
    }
    else if ([itemsNamesArray[indexPath.row] isEqualToString:@"Luces"]) {
        [self llamarAsacarLuces];
    }
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
    //int fichaSeleccionada = indexPath.row;
    //fichaSeleccionada = -1;
    [[_collectionItems cellForItemAtIndexPath:indexPath] setSelected:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize retval = CGSizeMake(130, 130);
    return retval;
}


- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 20, 50, 20);
}

#pragma mark - Methods Pager

- (void)loadView {
    [super loadView];
    
    self.view.autoresizesSubviews = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (NSString *)title {
    return [NSString stringWithFormat:@"%@", super.title];
}

#pragma mark - Metodos de llamada a delegate

- (void)llamarAsacarTv{
    if ([_delegate conformsToProtocol:@protocol(protocolItemsDelegate)] && [_delegate respondsToSelector:@selector(sacarTV)]) {
        [_delegate sacarTV];
    }
}

- (void)llamarAsacarLuces{
    if ([_delegate conformsToProtocol:@protocol(protocolItemsDelegate)] && [_delegate respondsToSelector:@selector(sacarLight)]) {
        [_delegate sacarLight];
    }
}

#pragma mark - Metodos de clase

- (UIImageView*)devolverImagenItem:(NSString*)item{
    UIImageView *img;
    
    if ([item isEqualToString:@"TV"]) {
        img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Tele"]];
        [img setFrame:CGRectMake(10, 10, 100, 90)];
    }
    else if ([item isEqualToString:@"DVD"]) {
        img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DVD"]];
        [img setFrame:CGRectMake(10, 10, 100, 90)];
    }
    else if ([item isEqualToString:@"Minicadena"]) {
        img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Minicadena"]];
        [img setFrame:CGRectMake(10, 10, 100, 90)];
    }
    else if ([item isEqualToString:@"Aire Acondicionado"]) {
        img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Aire"]];
        [img setFrame:CGRectMake(10, 10, 100, 99)];
    }
    else if ([item isEqualToString:@"Luces"]) {
        img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Bombilla"]];
        [img setFrame:CGRectMake(30, 10, 61, 90)];
    }
    else if ([item isEqualToString:@"Calefaccion"]) {
        img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pantalla"]];
        [img setFrame:CGRectMake(10, 10, 100, 90)];
    }
    else if ([item isEqualToString:@"Microhondas"]) {
        img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Microhondas"]];
        [img setFrame:CGRectMake(10, 10, 100, 90)];
    }
    else if ([item isEqualToString:@"Proyector"]) {
        img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Proyector"]];
        [img setFrame:CGRectMake(10, 10, 100, 90)];
    }
    
    return img;
}


@end
