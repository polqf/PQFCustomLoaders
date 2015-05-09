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
/** Text label of the Loader. Hidden if text is nil */
@property (nonatomic, strong) UILabel *label;
/** Corner radius of the Loader background */
@property (nonatomic) CGFloat cornerRadius;
/** Color of the Loader */
@property (nonatomic, strong) UIColor *loaderColor;
/** Alpha of the loader */
@property (nonatomic) CGFloat loaderAlpha;
/** Duration of each animation */
@property (nonatomic) CGFloat duration;
/** Size of the label text */
@property (nonatomic) CGFloat fontSize;
/** Number of rotating bars */
@property (nonatomic) CGFloat numberOfBars;
/** Minimum height of the bars */
@property (nonatomic) CGFloat barHeightMin;
/** Maximum height of the bars */
@property (nonatomic) CGFloat barHeightMax;
/** Minimum width of the bars */
@property (nonatomic) CGFloat barWidthMin;
/** Maximum width of the bars */
@property (nonatomic) CGFloat barWidthMax;
/** Rotation speed in seconds (Less amount, more speed) */
@property (nonatomic) CGFloat rotationSpeed;
/** Bar size speed in seconds (Less amount, more speed) */
@property (nonatomic) CGFloat barsSpeed;
/** Alpha of the hole view */
@property (nonatomic) CGFloat alpha;
@end
