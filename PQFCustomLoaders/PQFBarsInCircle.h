//
//  PQFBarsInCircle.h
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 6/3/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PQFLoader.h"

@interface PQFBarsInCircle : PQFLoader
@property (nonatomic, strong) UILabel *label;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat alpha;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *loaderColor;
@property (nonatomic) CGFloat numberOfBars;
@property (nonatomic) CGFloat loaderAlpha;
@property (nonatomic) CGFloat barHeightMin;
@property (nonatomic) CGFloat barHeightMax;
@property (nonatomic) CGFloat barWidthMin;
@property (nonatomic) CGFloat barWidthMax;
@property (nonatomic) CGFloat angleInRad;
@property (nonatomic) CGFloat rotationSpeed;
@property (nonatomic) CGFloat barsSpeed;
@property (nonatomic) CGFloat fontSize;
@end
