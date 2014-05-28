//
//  LivingRoomViewController.h
//  ehc
//
//  Created by kinki on 10/12/13.
//  Copyright (c) 2013 EHC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol protocolItemsDelegate <NSObject>

- (void)sacarTV;
- (void)sacarLight;
- (void)sacarBlinds;
- (void)sacarIntercom;
- (void)mostrarTemperatura;

@end

@interface RoomsViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong)IBOutlet UICollectionView *collectionItems;
@property (nonatomic, strong) id<protocolItemsDelegate> delegate;

- (id)initWithFrame:(CGRect)frame withNameOfRoom:(NSString*)roomName numberOfRoom:(int)roomNumber andNumberOfItems:(NSArray*)arrayOfItems andDelegate:(id<protocolItemsDelegate>)delegate;

@end
