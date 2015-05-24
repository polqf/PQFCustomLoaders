//
//  PQFBallDrop.h
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 6/3/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PQFLoader.h"

IB_DESIGNABLE
@interface PQFBallDrop : PQFLoader
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
/** Maximum diameter of the circles */
@property (nonatomic, assign) IBInspectable CGFloat maxDiam;
/** Delay between the animations */
@property (nonatomic, assign) IBInspectable CGFloat delay;
/** Ball added size when droping */
@property (nonatomic, assign) IBInspectable CGFloat amountZoom;
/** Alpha of the hole view */
@property (nonatomic, assign) IBInspectable CGFloat alpha;
@end
