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
@property (nonatomic, strong) PQFBallDrop *bouncingBalls;
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
    self.showBackground = NO;
    [self showLoaders];
}

- (void)showLoaders {
    //BOUNCING BALLS
    self.bouncingBalls = [[PQFBallDrop alloc] initLoaderOnView:self.view];
    self.bouncingBalls.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
    
    //BARS IN CIRCLE
    self.barsInCircle = [[PQFBarsInCircle alloc] initLoaderOnView:self.view];
    self.barsInCircle.center = CGPointMake(self.barsInCircle.center.x, self.barsInCircle.center.y - self.bouncingBalls.frame.size.height - 40);
    self.barsInCircle.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
    
    //CIRCLES IN TRIANGLE
    self.circlesInTriangle = [[PQFCirclesInTriangle alloc] initLoaderOnView:self.view];
    self.circlesInTriangle.center = CGPointMake(self.circlesInTriangle.center.x, self.circlesInTriangle.center.y + self.bouncingBalls.frame.size.height + 40);
    self.circlesInTriangle.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
    
    //OPTIONS IN DEMO
    if (self.showLabels) {
        self.barsInCircle.label.text = self.textField.text;
        self.circlesInTriangle.label.text = self.textField.text;
        self.bouncingBalls.label.text = self.textField.text;
    }
    if (!self.showBackground) {
        self.barsInCircle.backgroundColor = [UIColor clearColor];
        self.circlesInTriangle.backgroundColor = [UIColor clearColor];
        self.bouncingBalls.backgroundColor = [UIColor clearColor];
    }
    
    //SHOW LOADERS
    [self.barsInCircle show];
    [self.circlesInTriangle show];
    [self.bouncingBalls show];
    
}

- (IBAction)addLabelsButton:(id)sender {
    self.showLabels = YES;
    [self regenerateLoaders];
}
- (IBAction)removeLabelsButton:(id)sender {
    self.showLabels = NO;
    [self regenerateLoaders];
}
- (IBAction)addBackgroundButton:(id)sender {
    self.showBackground = YES;
    [self regenerateLoaders];
}

- (IBAction)removeBackgroundButton:(id)sender {
    self.showBackground = NO;
    [self regenerateLoaders];
}

- (void)removeLoaders {
    [self.barsInCircle remove];
    [self.circlesInTriangle remove];
    [self.bouncingBalls remove];
}

- (void)regenerateLoaders {
    [self removeLoaders];
    [self showLoaders];
}
- (IBAction)dismissKeyboard:(id)sender {
    [self.textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
