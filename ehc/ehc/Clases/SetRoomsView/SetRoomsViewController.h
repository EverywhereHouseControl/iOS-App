//
//  RoomsViewController.h
//  ehc
//
//  Created by kinki on 09/12/13.
//  Copyright (c) 2013 EHC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomsViewController.h"

@interface SetRoomsViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,protocolItemsDelegate>

@property (nonatomic, strong)IBOutlet UICollectionView *collectionRooms;

@end

