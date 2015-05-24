//
//  PQFCirclesInTriangle.h
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 6/3/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PQFLoader.h"

IB_DESIGNABLE
@interface PQFCirclesInTriangle : PQFLoader
/** Text label of the Loader. Hidden if text is nil */
@property (nonatomic, strong) IBInspectable UILabel *label;
/** Corner radius of the Loader background */
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
/** Color of the Loader */
@property (nonatomic, strong) IBInspectable UIColor *loaderColor;
/** Alpha of the loader */
@property (nonatomic, assign) IBInspectable CGFloat loaderAlpha;
/** Duration of each animation */
@property (nonatomic, assign) IBInspectable CGFloat duration;
/** Size of the label text */
@property (nonatomic, assign) IBInspectable CGFloat fontSize;
/** Number of circles to animate. 3 or 6 are the recommended values */
@property (nonatomic, assign) IBInspectable CGFloat numberOfCircles;
/** Maximum diameter of the circles */
@property (nonatomic, assign) IBInspectable CGFloat maxDiam;
/** Separation between the circles */
@property (nonatomic, assign) IBInspectable CGFloat separation;
/** Border width of the circles*/
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
/** Delay between the animations */
@property (nonatomic, assign) IBInspectable CGFloat delay;
/** Alpha of the hole view */
@property (nonatomic, assign) IBInspectable CGFloat alpha;
@end
