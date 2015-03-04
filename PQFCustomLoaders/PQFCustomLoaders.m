//
//  PQFCustomLoaders.m
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 6/2/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import "PQFCustomLoaders.h"

@implementation PQFCustomLoaders

+ (id)showModalLoader:(PQFLoaderType)loaderType
{
    return [PQFCustomLoaders showLoader:loaderType onView:nil];
}

+ (id)showLoader:(PQFLoaderType)loaderType onView:(UIView *)view
{
    switch (loaderType) {
        case 0:
            //return [PQFBouncingBalls showLoaderOnView:view];
            break;
        case 1:
            //return [PQFBarsInCircle showLoaderOnView:view];
            break;
        case 2:
            //return [PQFCirclesInTriangle showLoaderOnView:view];
            break;
        case 3:
            //return [PQFBallDrop showLoaderOnView:view];
            break;
    }
    
    return [PQFCustomLoaders new];
}

+ (void)removeAllLoadersOnView:(UIView *)view
{
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[PQFCustomLoaders class]]) {
            [subview removeFromSuperview];
        }
    }
}


- (void)showLoader {}

- (void)removeLoader {}

@end
