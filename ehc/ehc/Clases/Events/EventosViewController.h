//
//  EventosViewController.h
//  ehc
//
//  Created by Víctor Vicente on 28/02/14.
//  Copyright (c) 2014 EHC. All rights reserved.
//

@import UIKit;

#import <UIKit/UIKit.h>

@interface EventosViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property(nonatomic,strong) UICollectionView *collectionViewTareas;

@end
