//
//  ItemsCell.m
//  ehc
//
//  Created by kinki on 10/12/13.
//  Copyright (c) 2013 EHC. All rights reserved.
//

#import "ItemsCell.h"

@implementation ItemsCell
@synthesize itemName,imageItem;

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setFrame:CGRectMake(0, 0, 130, 130)];
        [itemName setText:@"Vacio"];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setFrame:CGRectMake(0, 0, 130, 130)];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
