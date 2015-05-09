//
//  PQFCirclesInTriangle.h
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 6/3/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PQFLoader.h"

@interface PQFCirclesInTriangle : PQFLoader
@property (nonatomic, strong) UILabel *label;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat alpha;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *loaderColor;
@property (nonatomic) CGFloat numberOfCircles;
@property (nonatomic) CGFloat loaderAlpha;
@property (nonatomic) CGFloat maxDiam;
@property (nonatomic) CGFloat separation;
@property (nonatomic) CGFloat borderWidth;
@property (nonatomic) CGFloat delay;
@property (nonatomic) CGFloat duration;
@property (nonatomic) CGFloat fontSize;
@property (nonatomic) CGFloat rectSize;
@end
