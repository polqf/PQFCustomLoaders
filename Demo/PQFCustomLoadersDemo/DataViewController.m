//
//  DataViewController.m
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 5/1/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController ()

@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.ballDrop) {
        self.dataLabel.text = NSStringFromClass([self.ballDrop class]);
        [self.ballDrop show];
    }
    else if (self.barsInCircle) {
        self.dataLabel.text = NSStringFromClass([self.barsInCircle class]);
        [self.barsInCircle show];
    }
    else if (self.bouncingBalls) {
        self.dataLabel.text = NSStringFromClass([self.bouncingBalls class]);
        [self.bouncingBalls show];
    }
    else if (self.circlesInTriangle) {
        self.dataLabel.text = NSStringFromClass([self.circlesInTriangle class]);
        [self.circlesInTriangle show];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.ballDrop) {
        [self.ballDrop hide];
    }
    else if (self.barsInCircle) {
        [self.barsInCircle hide];
    }
    else if (self.bouncingBalls) {
        [self.bouncingBalls hide];
    }
    else if (self.circlesInTriangle) {
        [self.circlesInTriangle hide];
    }
}

@end
