//
//  MenuCell.m
//  TriviSeries
//
//  Created by Alvaro Olave on 17/11/13.
//  Copyright (c) 2013 AKA7. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell
- (id)init
{
    self = [super init];
    _titleLabel = [[UILabel alloc] init];
    _icono = [[NSString alloc] init];
    return self;
}

-(void) drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect icoRect = CGRectMake(11, 7, 30, 30);
    CGRect lblRect = CGRectMake(49, 4, 230, 36);
    UIImage *source = [[UIImage alloc]init];
    source = [UIImage imageNamed:_icono];
    
    UIImage *fondo = [[UIImage alloc]init];
    fondo = [UIImage imageNamed:@"celdaMenuiPh.png"];
    [fondo drawInRect:rect];
    
    //CGContextSetFillColorWithColor(context,[UIColor grayColor].CGColor);
    //CGContextFillRect(context,rectang);
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [_titleLabel setFont:[UIFont fontWithName:@"Noteworthy" size:14]];
    _titleLabel.textColor = [UIColor whiteColor];
    [source drawInRect:icoRect];
    [_titleLabel drawTextInRect:lblRect];
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 0.5);

    CGContextMoveToPoint(context, rect.origin.x +5, rect.size.height - 1);
    //CGContextAddLineToPoint(context, 195, rect.size.height - 1);
    CGContextStrokePath(context);
    
    //CGContextAddRect(context,rectang);
    CGContextAddRect(context,icoRect);
    CGContextAddRect(context,lblRect);
    
}
@end