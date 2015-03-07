//
//  PQFLoader.m
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 6/3/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import "PQFLoader.h"
#import "PQFBouncingBalls.h"
#import "PQFBarsInCircle.h"
#import "PQFCirclesInTriangle.h"
#import "PQFBallDrop.h"

@implementation PQFLoader


#pragma mark - SHOW methods

+ (id)showModalLoader:(PQFLoaderType)loaderType
{
    return [self showModalLoader:loaderType];
}

+ (id)showLoader:(PQFLoaderType)loaderType onView:(UIView *)view
{
    return [[PQFLoader loaderClassForType:loaderType] showLoader:loaderType onView:view];
}

- (void)showLoader {}


#pragma mark - CREATE methods

+ (id)createModalLoader:(PQFLoaderType)loaderType
{
    return [self createLoader:loaderType onView:nil];
}

+ (id)createLoader:(PQFLoaderType)loaderType onView:(UIView *)view
{
    return [[PQFLoader loaderClassForType:loaderType] createLoader:loaderType onView:view];
}


#pragma mark - REMOVE methods

+ (void)removeAllLoadersOnView:(UIView *)view
{
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[PQFLoader class]]) {
            [subview removeFromSuperview];
        }
    }
}

- (void)removeLoader {}

- (void)hideLoader {}

#pragma mark - Helpers

+ (Class)loaderClassForType:(PQFLoaderType)loaderType
{
    switch (loaderType) {
        case 0:
            return [PQFBouncingBalls class];
            break;
        case 1:
            return [PQFBarsInCircle class];
            break;
        case 2:
            return [PQFCirclesInTriangle class];
            break;
        case 3:
            return [PQFBallDrop class];
            break;
    }
    return nil;
}


#pragma mark - Deprecated methods

- (instancetype)initLoaderOnView:(UIView *)view { return nil; }

- (void)show
{
    [self showLoader];
}

- (void)hide
{
    [self hideLoader];
}

- (void)remove
{
    [self removeLoader];
}

@end
