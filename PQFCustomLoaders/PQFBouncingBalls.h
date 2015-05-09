//
//  PQFBouncingBalls.h
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 6/3/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PQFLoader.h"

@interface PQFBouncingBalls : PQFLoader
@property (nonatomic, strong) UILabel *label;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat alpha;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *loaderColor;
@property (nonatomic) CGFloat loaderAlpha;
@property (nonatomic) CGFloat diameter;
@property (nonatomic) CGFloat jumpAmount;
@property (nonatomic) CGFloat separation;
@property (nonatomic) CGFloat zoomAmount;
@property (nonatomic) CGFloat duration;
@property (nonatomic) CGFloat fontSize;
@property (nonatomic) CGFloat rectSize;

@end
