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
/** Text label of the Loader. Hidden if text is nil */
@property (nonatomic, strong) UILabel *label;
/** Corner radius of the Loader background */
@property (nonatomic) CGFloat cornerRadius;
/** Color of the Loader */
@property (nonatomic, strong) UIColor *loaderColor;
/** Alpha of the loader */
@property (nonatomic) CGFloat loaderAlpha;
/** Diameter of the bouncing balls */
@property (nonatomic) CGFloat diameter;
/** Movement amount on the X axis */
@property (nonatomic) CGFloat jumpAmount;
/** Separation between the bouncing balls */
@property (nonatomic) CGFloat separation;
/** Ball added size when jumping */
@property (nonatomic) CGFloat zoomAmount;
/** Duration of each animation */
@property (nonatomic) CGFloat duration;
/** Size of the label text */
@property (nonatomic) CGFloat fontSize;
/** Alpha of the hole view */
@property (nonatomic) CGFloat alpha;
@end
