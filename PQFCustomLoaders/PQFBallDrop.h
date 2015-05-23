//
//  PQFBallDrop.h
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 6/3/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PQFLoader.h"

@interface PQFBallDrop : PQFLoader
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
/** Maximum diameter of the circles */
@property (nonatomic) CGFloat maxDiam;
/** Delay between the animations */
@property (nonatomic) CGFloat delay;
/** Ball added size when droping */
@property (nonatomic) CGFloat amountZoom;
/** Alpha of the hole view */
@property (nonatomic) CGFloat alpha;
@end
