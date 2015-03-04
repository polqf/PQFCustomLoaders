//
//  PQFBarsInCircle.h
//  randomAnimations
//
//  Created by Pol Quintana on 27/10/14.
//  Copyright (c) 2014 Pol Quintana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PQFBarsInCircle : UIView

@property (nonatomic) NSInteger numberOfBars;
@property (nonatomic) CGFloat barWidthMax;
@property (nonatomic) CGFloat barHeightMax;
@property (nonatomic) CGFloat barWidthMin;
@property (nonatomic) CGFloat barHeightMin;
@property (nonatomic) CGFloat barsSpeed;
@property (nonatomic) CGFloat rotationSpeed;

+ (instancetype)showLoaderOnView:(UIView *)view;

- (instancetype)initLoader;
- (instancetype)initLoaderOnView:(UIView *)view;

- (void)remove;
- (void)show;
- (void)hide;

@end
