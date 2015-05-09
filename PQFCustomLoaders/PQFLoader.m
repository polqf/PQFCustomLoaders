//
//  PQFLoader.m
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 6/3/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import "PQFLoader.h"

@implementation PQFLoader


#pragma mark - SHOW methods

+ (instancetype)showModalLoader
{
    return [self showModalLoader];
}

+ (instancetype)showLoaderOnView:(UIView *)view
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"PQFLoader is an abstract class, use a loader type class"]
                                 userInfo:nil];
}

- (void)showLoader {}


#pragma mark - CREATE methods

+ (instancetype)createModalLoader
{
    return [self createLoaderOnView:nil];
}

+ (instancetype)createLoaderOnView:(UIView *)view
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"PQFLoader is an abstract class, use a loader type class"]
                                 userInfo:nil];
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


#pragma mark - Deprecated methods

- (instancetype)initLoaderOnView:(UIView *)view { return nil; }

- (void)show
{
    [self showLoader];
}

- (void)hide
{
    [self removeLoader];
}

- (void)remove
{
    [self removeLoader];
}

@end
