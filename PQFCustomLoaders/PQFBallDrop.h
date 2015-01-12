//
//  PQFBallDrop.h
//  PQFCustomLoaders
//
//  Created by Pol Quintana on 4/12/14.
//  Copyright (c) 2014 Pol Quintana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PQFBallDrop : UIView

@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat loaderAlpha;
@property (nonatomic, strong) UIColor *loaderColor;
@property (nonatomic) CGFloat maxDiam;
@property (nonatomic) CGFloat delay;
@property (nonatomic) CGFloat duration;
@property (nonatomic, strong) UILabel *label;

- (instancetype)initLoader;
- (instancetype)initLoaderOnView:(UIView *)view;

- (void)remove;
- (void)show;
- (void)hide;


@end
