//
//  PQFBouncingBalls.h
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 6/3/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PQFLoader.h"

IB_DESIGNABLE
@interface PQFBouncingBalls : PQFLoader
/** Text label of the Loader. Hidden if text is nil */
@property (nonatomic, strong) IBInspectable UILabel *label;
/** Corner radius of the Loader background */
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
/** Color of the Loader */
@property (nonatomic, strong) IBInspectable UIColor *loaderColor;
/** Alpha of the loader */
@property (nonatomic, assign) IBInspectable CGFloat loaderAlpha;
/** Diameter of the bouncing balls */
@property (nonatomic, assign) IBInspectable CGFloat diameter;
/** Movement amount on the X axis */
@property (nonatomic, assign) IBInspectable CGFloat jumpAmount;
/** Separation between the bouncing balls */
@property (nonatomic, assign) IBInspectable CGFloat separation;
/** Ball added size when jumping */
@property (nonatomic, assign) IBInspectable CGFloat zoomAmount;
/** Duration of each animation */
@property (nonatomic, assign) IBInspectable CGFloat duration;
/** Size of the label text */
@property (nonatomic, assign) IBInspectable CGFloat fontSize;
/** Alpha of the hole view */
@property (nonatomic, assign) IBInspectable CGFloat alpha;
@end
