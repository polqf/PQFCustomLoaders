//
//  PQFBallDrop.m
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 6/3/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import "PQFBallDrop.h"

@interface PQFBallDrop ()

@end

@implementation PQFBallDrop


#pragma mark - PQFLoader methods

+ (instancetype)showLoader:(PQFLoaderType)loaderType onView:(UIView *)view
{
    PQFBallDrop *loader = [self createLoader:loaderType onView:nil];
    [loader showLoader];
    return nil;
}

+ (id)createLoader:(PQFLoaderType)loaderType onView:(UIView *)view
{
    if (!view) {
        
    }
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
