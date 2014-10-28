//
//  PQFCirclesInTriangle.m
//  randomAnimations
//
//  Created by Pol Quintana on 28/10/14.
//  Copyright (c) 2014 Pol Quintana. All rights reserved.
//

#import "PQFCirclesInTriangle.h"
#import <UIColor+FlatColors.h>

@interface PQFCirclesInTriangle ()

@property (nonatomic, strong) NSArray *balls;

@end

@implementation PQFCirclesInTriangle

#warning Overwrite init method!!!!

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self generateLoader];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self generateLoader];
    }
    return self;
}

- (void)generateLoader {
    self.numberOfCircles = 6;
    self.delay = 0.5;
    self.width = 2.0;
    self.maxDiam = 50;
    self.separation = 8.0;
    self.duration = 2.0;
    self.color = [UIColor flatCloudsColor];
    self.backgroundColor = [UIColor flatTurquoiseColor];
    
    NSMutableArray *temp = [[NSMutableArray alloc] initWithCapacity:3];
    
    for (int i = 0; i< self.numberOfCircles; i++) {
        CALayer *ball = [CALayer layer];
        ball.bounds = CGRectMake(0, 0, 0 , 0);
        ball.borderWidth = self.width;
        ball.borderColor = self.color.CGColor;
        
        switch (i) {
            case 0:
                ball.position = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2 -self.separation);
                break;
            case 1:
                ball.position = CGPointMake(CGRectGetWidth(self.frame)/2 - self.separation, CGRectGetHeight(self.frame)/2 + self.separation);
                break;
            case 2:
                ball.position = CGPointMake(CGRectGetWidth(self.frame)/2 + self.separation, CGRectGetHeight(self.frame)/2 + self.separation);
                break;
            case 3:
                ball.position = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2 -self.separation);
                break;
            case 4:
                ball.position = CGPointMake(CGRectGetWidth(self.frame)/2 - self.separation, CGRectGetHeight(self.frame)/2 + self.separation);
                break;
            case 5:
                ball.position = CGPointMake(CGRectGetWidth(self.frame)/2 + self.separation, CGRectGetHeight(self.frame)/2 + self.separation);
                break;
        }
        
        [self.layer addSublayer:ball];
        [temp addObject:ball];
    }
    
    self.balls = [temp copy];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self startAnimation];
    if (self.numberOfCircles > 3) {
        [self performSelector:@selector(startSecondAnimation) withObject:self afterDelay:self.delay];
    }
}

- (void)startAnimation {
    for (int i = 0; i<3; i++) {
        CALayer *ball = [self.balls objectAtIndex:i];
        [self animateBall:ball atIndex:i];
    }
}

- (void)startSecondAnimation {
    for (int i = 3; i<6; i++) {
        CALayer *ball = [self.balls objectAtIndex:i];
        [self animateBall:ball atIndex:i];
    }
}

- (void)animateBall:(CALayer *)ball atIndex:(int)index {
    
    CAKeyframeAnimation *bounds1 = [CAKeyframeAnimation animationWithKeyPath:@"bounds.size"];
    bounds1.duration = self.duration;
    bounds1.values = @[[NSValue valueWithCGSize:CGSizeMake(0, 0)],
                       [NSValue valueWithCGSize:CGSizeMake(self.maxDiam, self.maxDiam)]];
    bounds1.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    
    
    CAKeyframeAnimation *radius = [CAKeyframeAnimation animationWithKeyPath:@"cornerRadius"];
    radius.duration = self.duration;
    radius.values = @[@(0), @(self.maxDiam/2)];
    radius.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    
    
    CAKeyframeAnimation *position = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    position.duration = self.duration/2;
    CGPoint point;
    switch (index) {
        case 0:
            point = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2 - self.separation);
            break;
        case 1:
            point = CGPointMake(CGRectGetWidth(self.frame)/2 - self.separation, CGRectGetHeight(self.frame)/2 + self.separation);
            break;
        case 2:
            point = CGPointMake(CGRectGetWidth(self.frame)/2 + self.separation, CGRectGetHeight(self.frame)/2 + self.separation);
            break;
        case 3:
            point = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2 - self.separation);
            break;
        case 4:
            point = CGPointMake(CGRectGetWidth(self.frame)/2 - self.separation, CGRectGetHeight(self.frame)/2 + self.separation);
            break;
        case 5:
            point = CGPointMake(CGRectGetWidth(self.frame)/2 + self.separation, CGRectGetHeight(self.frame)/2 + self.separation);
            break;
            
        default:
            break;
    }
    
    position.values = @[[NSValue valueWithCGPoint:point],
                        [NSValue valueWithCGPoint:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2)]];
    position.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    position.beginTime = CACurrentMediaTime() + self.duration/2;
    
    //Fade Out
    
    CAKeyframeAnimation *miniBounds = [CAKeyframeAnimation animationWithKeyPath:@"bounds.size"];
    miniBounds.duration = self.duration/2;
    miniBounds.values = @[[NSValue valueWithCGSize:CGSizeMake(self.maxDiam, self.maxDiam)],
                          [NSValue valueWithCGSize:CGSizeMake(0, 0)]];
    miniBounds.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    miniBounds.beginTime = CACurrentMediaTime() + self.duration;
    if (index == self.numberOfCircles - 1) {
        miniBounds.delegate = self;
    }
    
    CAKeyframeAnimation *radius2 = [CAKeyframeAnimation animationWithKeyPath:@"cornerRadius"];
    radius2.duration = self.duration/2;
    radius2.values = @[@(self.maxDiam/2), @(0)];
    radius2.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    radius2.beginTime = CACurrentMediaTime() + self.duration;
    
    CAKeyframeAnimation *position2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    position2.duration = self.duration/2;
    position2.values = @[[NSValue valueWithCGPoint:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2)],
                         [NSValue valueWithCGPoint:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2)]];
    position2.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    position2.beginTime = CACurrentMediaTime() + self.duration;
    
    [ball addAnimation:bounds1 forKey:@"bounds1"];
    [ball addAnimation:radius forKey:@"radius"];
    [ball addAnimation:position forKey:@"position"];
    
    [ball addAnimation:miniBounds forKey:@"boundsFinal"];
    [ball addAnimation:radius2 forKey:@"radius2"];
    [ball addAnimation:position2 forKey:@"position2"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self touchesBegan:nil withEvent:nil];
}


@end
