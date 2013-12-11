//
//  MenuViewController.h
//  TriviSeries
//
//  Created by KINKI on 5/14/13.
//  Copyright (c) 2013 AKA7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MenuViewController : UITableViewController<UIActionSheetDelegate>{
    //AppDelegate *appDelegate;
}

-(void)llamarAperfil;
-(void)llamarAdetallesCuenta;
-(void)llamarAajustes;
-(void)llamarAinicio;



@end
