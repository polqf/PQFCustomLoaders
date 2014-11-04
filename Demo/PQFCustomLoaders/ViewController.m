//
//  ViewController.m
//  PQFCustomLoaders
//
//  Created by Pol Quintana on 28/10/14.
//  Copyright (c) 2014 Pol Quintana. All rights reserved.
//

#import "ViewController.h"
#import "PQFCustomLoaders.h"
#import <UIColor+FlatColors.h>

@interface ViewController ()

@property (nonatomic, strong) PQFBarsInCircle *barsInCircle;
@property (nonatomic, strong) PQFBouncingBalls *bouncingBalls;
@property (nonatomic, strong) PQFCirclesInTriangle *circlesInTriangle;
@property (nonatomic) BOOL showLabels;
@property (nonatomic) BOOL showBackground;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor flatTurquoiseColor];
    self.showLabels = YES;
    self.showBackground = YES;
    [self showLoaders];
}

- (void)showLoaders {
    //BOUNCING BALLS
    self.bouncingBalls = [[PQFBouncingBalls alloc] init];
    self.bouncingBalls.frame = CGRectMake(0, 0, 0, 150);
    
    self.barsInCircle = [[PQFBarsInCircle alloc] initLoaderOnView:self.view];
    self.barsInCircle.center = CGPointMake(self.barsInCircle.center.x, self.barsInCircle.center.y - self.bouncingBalls.frame.size.height - 20);
    
    self.circlesInTriangle = [[PQFCirclesInTriangle alloc] initLoaderOnView:self.view];
    self.circlesInTriangle.center = CGPointMake(self.circlesInTriangle.center.x, self.circlesInTriangle.center.y + self.bouncingBalls.frame.size.height + 20);
    if (self.showLabels) {
        self.barsInCircle.label.text = self.textField.text;
        self.circlesInTriangle.label.text = self.textField.text;
    }
    if (!self.showBackground) {
        self.barsInCircle.backgroundColor = [UIColor clearColor];
        self.circlesInTriangle.backgroundColor = [UIColor clearColor];
    }
    
    [self.barsInCircle show];
    [self.circlesInTriangle show];
    
}

- (IBAction)addLabelsButton:(id)sender {
    self.showLabels = YES;
    [self removeLoaders];
    [self showLoaders];
}
- (IBAction)removeLabelsButton:(id)sender {
    self.showLabels = NO;
    [self removeLoaders];
    [self showLoaders];
}
- (IBAction)addBackgroundButton:(id)sender {
    self.showBackground = YES;
    [self removeLoaders];
    [self showLoaders];
}

- (IBAction)removeBackgroundButton:(id)sender {
    self.showBackground = NO;
    [self removeLoaders];
    [self showLoaders];
}

- (IBAction)removeLoaders {
    [self.barsInCircle remove];
    [self.circlesInTriangle remove];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
