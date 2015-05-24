//
//  PQFBarsInCircle.h
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 6/3/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PQFLoader.h"

IB_DESIGNABLE
@interface PQFBarsInCircle : PQFLoader
/** Text label of the Loader. Hidden if text is nil */
@property (nonatomic, strong) IBInspectable UILabel *label;
/** Corner radius of the Loader background */
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
/** Color of the Loader */
@property (nonatomic, strong) IBInspectable UIColor *loaderColor;
/** Alpha of the loader */
@property (nonatomic, assign) IBInspectable CGFloat loaderAlpha;
/** Size of the label text */
@property (nonatomic, assign) IBInspectable CGFloat fontSize;
/** Number of rotating bars */
@property (nonatomic, assign) IBInspectable CGFloat numberOfBars;
/** Minimum height of the bars */
@property (nonatomic, assign) IBInspectable CGFloat barHeightMin;
/** Maximum height of the bars */
@property (nonatomic, assign) IBInspectable CGFloat barHeightMax;
/** Minimum width of the bars */
@property (nonatomic, assign) IBInspectable CGFloat barWidthMin;
/** Maximum width of the bars */
@property (nonatomic, assign) IBInspectable CGFloat barWidthMax;
/** Rotation speed in seconds (Less amount, more speed) */
@property (nonatomic, assign) IBInspectable CGFloat rotationSpeed;
/** Bar size speed in seconds (Less amount, more speed) */
@property (nonatomic, assign) IBInspectable CGFloat barsSpeed;
/** Alpha of the hole view */
@property (nonatomic, assign) IBInspectable CGFloat alpha;
@end
