//
//  TvItemViewController.h
//  ehc
//
//  Created by kinki on 11/12/13.
//  Copyright (c) 2013 EHC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDBrowser.h"

@interface TvItemViewController : UIViewController<BrowserViewDelegate>{
    MDBrowser *browser;
}

@property (weak, nonatomic) IBOutlet UILabel *labelState;

- (IBAction)pulsadoBoton:(id)sender;

- (IBAction)pulsadoBotonBack:(id)sender;

-(IBAction)pulsadoBotonTeletexto:(id)sender;

@end
