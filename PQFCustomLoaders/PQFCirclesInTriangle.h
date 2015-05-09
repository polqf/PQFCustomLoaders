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
/** Number of circles to animate. 3 or 6 are the recommended values */
@property (nonatomic) CGFloat numberOfCircles;
/** Maximum diameter of the circles */
@property (nonatomic) CGFloat maxDiam;
/** Separation between the circles */
@property (nonatomic) CGFloat separation;
/** Border width of the circles*/
@property (nonatomic) CGFloat borderWidth;
/** Delay between the animations */
@property (nonatomic) CGFloat delay;
/** Alpha of the hole view */
@property (nonatomic) CGFloat alpha;
@end
