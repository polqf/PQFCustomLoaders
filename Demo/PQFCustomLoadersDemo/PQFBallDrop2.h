//
//  PQFBallDrop.h
//  PQFCustomLoaders
//
//  Created by Pol Quintana on 4/12/14.
//  Copyright (c) 2014 Pol Quintana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PQFBallDrop : UIView

@property (nonatomic) CGFloat maxDiam;
@property (nonatomic) CGFloat delay;
@property (nonatomic) CGFloat duration;

+ (instancetype)showLoaderOnView:(UIView *)view;

- (instancetype)initLoader;
- (instancetype)initLoaderOnView:(UIView *)view;

- (void)remove;
- (void)show;
- (void)hide;


@end
