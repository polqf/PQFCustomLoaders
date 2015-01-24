//
//  DataViewController.m
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 5/1/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController () {
    BOOL _showing;
}

@end

@implementation DataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.dataLabel.text = NSStringFromClass([self.loader class]);
    
    if (_showing) return;
    
    [self showLoader];
    _showing = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.loader remove];
    _showing = NO;
}

- (void)showLoader
{
    self.loader = [[[self.loader class] alloc] initLoaderOnView:self.view];
    [self.loader show];
}


@end
