//
//  HousesViewController.h
//  ehc
//
//  Created by Víctor Vicente on 23/04/14.
//  Copyright (c) 2014 EHC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HousesViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong)IBOutlet UICollectionView *collectionHouses;

@end
