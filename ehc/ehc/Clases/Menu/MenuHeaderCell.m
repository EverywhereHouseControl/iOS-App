//
//  MenuHeaderCell.m
//  TriviSeries
//
//  Created by Alvaro Olave on 17/11/13.
//  Copyright (c) 2013 AKA7. All rights reserved.
//

#import "MenuHeaderCell.h"

@implementation MenuHeaderCell
- (id)init
{
    self = [super init];
    _titleLabel = [[UILabel alloc] init];
    return self;
}

-(void) drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rectang = CGRectMake(rect.origin.x + 0.5, rect.origin.y + 0.5, rect.size.width - 1, rect.size.height - 1);
    CGContextSetFillColorWithColor(context,[UIColor blackColor].CGColor);
    CGContextFillRect(context,rectang);
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [_titleLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:17]];
    _titleLabel.textColor = [UIColor whiteColor];
    
    //[source drawInRect:rectang blendMode:kCGBlendModeLuminosity alpha:1.0];
    [_titleLabel drawTextInRect:rectang];
    
    CGContextAddRect(context,rectang);
    
}
@end