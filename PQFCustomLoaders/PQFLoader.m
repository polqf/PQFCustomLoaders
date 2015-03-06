//
//  PQFLoader.m
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 6/3/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import "PQFLoader.h"

@implementation PQFLoader

+ (id)showModalLoader:(PQFLoaderType)loaderType
{
    return [PQFLoader showLoader:loaderType onView:nil];
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
    
    return [PQFLoader new];
}

+ (void)removeAllLoadersOnView:(UIView *)view
{
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[PQFLoader class]]) {
            [subview removeFromSuperview];
        }
    }
}


- (void)showLoader {}

- (void)removeLoader {}

@end
