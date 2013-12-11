//
//  LivingRoomViewController.h
//  ehc
//
//  Created by kinki on 10/12/13.
//  Copyright (c) 2013 EHC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoomsViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong)IBOutlet UICollectionView *collectionItems;

- (id)initWithFrame:(CGRect)frame withNameOfRoom:(NSString*)roomName numberOfRoom:(int)roomNumber andNumberOfItems:(NSArray*)arrayOfItems;

@end
