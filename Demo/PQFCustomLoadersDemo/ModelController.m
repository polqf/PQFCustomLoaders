//
//  ModelController.m
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 5/1/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import "ModelController.h"
#import "DataViewController.h"

#import "PQFCustomLoaders.h"

@interface ModelController ()

@property (readonly, strong, nonatomic) NSArray *pageData;

@end

@implementation ModelController

- (instancetype)init {
    self = [super init];
    if (self) {
        _pageData = @[@"PQFBouncingBalls", @"PQFBarsInCircle", @"PQFCirclesInTriangle", @"PQFBallDrop"];
    }
    return self;
}

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard {
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }

    DataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"DataViewController"];
    
    [self presentLoaderAtIndex:index onViewController:dataViewController];
    
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(DataViewController *)viewController {
    
    NSString *loaderClass = NSStringFromClass([viewController.loader class]);

    return [self.pageData indexOfObject:loaderClass];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageData count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

#pragma mark - Add loaders

- (void)presentLoaderAtIndex:(NSUInteger)index onViewController:(DataViewController *)viewController {
    
    if (index == 0) {
        viewController.loader = [[PQFBouncingBalls alloc] initLoaderOnView:viewController.view];
    }
    if (index == 1) {
        viewController.loader = [[PQFBarsInCircle alloc] initLoaderOnView:viewController.view];
    }
    if (index == 2) {
        viewController.loader = [[PQFCirclesInTriangle alloc] initLoaderOnView:viewController.view];
    }
    if (index == 3) {
        viewController.loader = [[PQFBallDrop alloc] initLoaderOnView:viewController.view];
    }
    
    [viewController.loader show];
    
}



@end
