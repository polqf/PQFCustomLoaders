//
//  DataViewController.h
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 5/1/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PQFCustomLoaders.h"

@interface DataViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (nonatomic, strong) PQFBallDrop *ballDrop;
@property (nonatomic, strong) PQFBarsInCircle *barsInCircle;
@property (nonatomic, strong) PQFBouncingBalls *bouncingBalls;
@property (nonatomic, strong) PQFCirclesInTriangle *circlesInTriangle;

@end

