//
//  PQFBouncingBalls.h
//  randomAnimations
//
//  Created by Pol Quintana on 28/10/14.
//  Copyright (c) 2014 Pol Quintana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PQFBouncingBalls : UIView

@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat loaderAlpha;
@property (nonatomic, strong) UIColor *loaderColor;
@property (nonatomic) CGFloat diameter;
@property (nonatomic) CGFloat jumpAmount;
@property (nonatomic) CGFloat separation;
@property (nonatomic) CGFloat zoomAmount;
@property (nonatomic) CGFloat duration;
@property (nonatomic, strong) UILabel *label;

- (instancetype)initLoaderOnView:(UIView *)view;

- (void)remove;
- (void)show;
- (void)hide;

@end
