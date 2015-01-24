//
//  RootViewController.m
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 5/1/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import "RootViewController.h"
#import "ModelController.h"
#import "DataViewController.h"

@interface RootViewController ()

@property (readonly, strong, nonatomic) ModelController *modelController;
@end

@implementation RootViewController

@synthesize modelController = _modelController;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;

    DataViewController *startingViewController = [self.modelController viewControllerAtIndex:0 storyboard:self.storyboard];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

    self.pageViewController.dataSource = self.modelController;
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];

    CGRect pageViewRect = self.view.bounds;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        pageViewRect = CGRectInset(pageViewRect, 40.0, 40.0);
    }
    self.pageViewController.view.frame = pageViewRect;

    [self.pageViewController didMoveToParentViewController:self];
    
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (ModelController *)modelController {
    if (!_modelController) {
        _modelController = [[ModelController alloc] init];
    }
    return _modelController;
}

#pragma mark - UIPageViewController delegate methods

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    if (UIInterfaceOrientationIsPortrait(orientation) || ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)) {
        
        UIViewController *currentViewController = self.pageViewController.viewControllers[0];
        NSArray *viewControllers = @[currentViewController];
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        
        self.pageViewController.doubleSided = NO;
        return UIPageViewControllerSpineLocationMin;
    }

    DataViewController *currentViewController = self.pageViewController.viewControllers[0];
    NSArray *viewControllers = nil;

    NSUInteger indexOfCurrentViewController = [self.modelController indexOfViewController:currentViewController];
    if (indexOfCurrentViewController == 0 || indexOfCurrentViewController % 2 == 0) {
        UIViewController *nextViewController = [self.modelController pageViewController:self.pageViewController viewControllerAfterViewController:currentViewController];
        
        viewControllers = @[currentViewController, nextViewController];
    } else {
        UIViewController *previousViewController = [self.modelController pageViewController:self.pageViewController viewControllerBeforeViewController:currentViewController];
        viewControllers = @[previousViewController, currentViewController];
    }
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];


    return UIPageViewControllerSpineLocationMid;
}

@end
