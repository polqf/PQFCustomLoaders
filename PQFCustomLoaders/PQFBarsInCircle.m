//
//  PQFBarsInCircle.m
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 6/3/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import "PQFBarsInCircle.h"

@implementation PQFBarsInCircle


#pragma mark - PQFLoader methods

+ (instancetype)showLoader:(PQFLoaderType)loaderType onView:(UIView *)view
{
    PQFBarsInCircle *loader = [self createLoader:loaderType onView:nil];
    return nil;
}

+ (id)createLoader:(PQFLoaderType)loaderType onView:(UIView *)view
{
    return nil;
}

- (void)showLoader
{
    
}

- (void)hideLoader
{
    
}

- (void)removeLoader
{
    
}

@end
