//
//  ViewController.m
//  PQFInspectableDemo
//
//  Created by Pol Quintana on 24/5/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import "ViewController.h"
#import "PQFCustomLoaders.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet PQFBouncingBalls *bouncingBallsLoader;
@property (weak, nonatomic) IBOutlet PQFBarsInCircle *barsInCircleLoader;
@property (weak, nonatomic) IBOutlet PQFCirclesInTriangle *circlesInTriangleLoader;
@property (weak, nonatomic) IBOutlet PQFBallDrop *ballDropLoader;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.bouncingBallsLoader showLoader];
    [self.barsInCircleLoader showLoader];
    [self.circlesInTriangleLoader showLoader];
    [self.ballDropLoader showLoader];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
