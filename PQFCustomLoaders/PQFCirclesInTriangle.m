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
@property (nonatomic) BOOL animate;
@property (nonatomic, strong) UIView *loaderView;
@property (nonatomic) CGFloat fontSize;
@property (nonatomic) CGFloat rectSize;

@end

@implementation PQFCirclesInTriangle

- (instancetype)initLoaderOnView:(UIView *)view {
    self = [super init];
    
    [self defaultValues];
    
    self.frame = CGRectMake(0, 0, view.frame.size.width, self.rectSize + 20);
    self.center = view.center;
    
    [self setClipsToBounds:YES];
    
    [view addSubview:self];
    
    //Loader View Initialization
    self.loaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.rectSize + 10, self.rectSize + 10)];
    self.loaderView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    [self addSubview:self.loaderView];
    
    return self;
}

- (void)defaultValues {
    self.numberOfCircles = 6;
    self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.0];
    self.cornerRadius = 0;
    self.loaderAlpha = 1.0;
    self.loaderColor = [UIColor flatCloudsColor];
    self.maxDiam = 50;
    self.separation = 8.0;
    self.borderWidth = 2.0;
    self.delay = 0.5;
    self.duration = 2.0;
    self.fontSize = 14.0;
    self.rectSize = self.separation*2 + self.maxDiam;
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.rectSize + 30, self.fontSize*2+10)];
}

#pragma mark - public methods

- (void)show {
    self.alpha = 1.0;
    self.animate = YES;
    [self generateLoader];
    [self startAnimation];
}

- (void)hide {
    self.alpha = 0.0;
    self.animate = NO;
}

- (void)remove {
    [self hide];
    [self removeFromSuperview];
}

#pragma mark Custom Setters


#pragma mark - private methods

- (void)generateLoader {
    //GenerateFrames
    self.layer.cornerRadius = self.cornerRadius;
    self.rectSize = self.separation*2 + self.maxDiam;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.rectSize + 20);
    self.loaderView.frame = CGRectMake(self.loaderView.frame.origin.x, self.loaderView.frame.origin.y, self.rectSize + 10, self.rectSize + 10);
    
    
    //Layers
    NSMutableArray *temp = [[NSMutableArray alloc] initWithCapacity:3];
    
    for (int i = 0; i< self.numberOfCircles; i++) {
        CALayer *ball = [CALayer layer];
        ball.bounds = CGRectMake(0, 0, 0 , 0);
        ball.borderWidth = self.borderWidth;
        ball.borderColor = self.loaderColor.CGColor;
        ball.opacity = self.loaderAlpha;
        
        switch (i) {
            case 0:
                ball.position = CGPointMake(CGRectGetWidth(self.loaderView.frame)/2, CGRectGetHeight(self.loaderView.frame)/2 -self.separation);
                break;
            case 1:
                ball.position = CGPointMake(CGRectGetWidth(self.loaderView.frame)/2 - self.separation, CGRectGetHeight(self.loaderView.frame)/2 + self.separation);
                break;
            case 2:
                ball.position = CGPointMake(CGRectGetWidth(self.loaderView.frame)/2 + self.separation, CGRectGetHeight(self.loaderView.frame)/2 + self.separation);
                break;
            case 3:
                ball.position = CGPointMake(CGRectGetWidth(self.loaderView.frame)/2, CGRectGetHeight(self.loaderView.frame)/2 -self.separation);
                break;
            case 4:
                ball.position = CGPointMake(CGRectGetWidth(self.loaderView.frame)/2 - self.separation, CGRectGetHeight(self.loaderView.frame)/2 + self.separation);
                break;
            case 5:
                ball.position = CGPointMake(CGRectGetWidth(self.loaderView.frame)/2 + self.separation, CGRectGetHeight(self.loaderView.frame)/2 + self.separation);
                break;
        }
        
        [self.loaderView.layer addSublayer:ball];
        [temp addObject:ball];
    }
    
    [self autolayoutByCode];
    
    self.balls = [temp copy];
    
}

- (void)autolayoutByCode {
    
    if ([self.label.text isEqualToString:@""]) {
        self.label.text = nil;
    }
    
    if (self.label.text) {
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.numberOfLines = 3;
        self.label.textColor = [UIColor whiteColor];
        self.label.font = [UIFont systemFontOfSize:self.fontSize];
        
        CGFloat xCenter = self.center.x;
        CGFloat yCenter = self.center.y;
        
        self.loaderView.frame = CGRectMake(self.loaderView.frame.origin.x, self.loaderView.frame.origin.y, self.loaderView.frame.size.width, self.loaderView.frame.size.height + self.fontSize*2);
    
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.loaderView.frame.size.height + 10);
        self.center = CGPointMake(xCenter, yCenter);
        self.loaderView.center = CGPointMake(CGRectGetWidth(self.frame)/2, self.loaderView.center.y);
    
        CGFloat xPoint = CGRectGetWidth(self.loaderView.frame)/2;
        CGFloat yPoint = CGRectGetWidth(self.loaderView.frame)/2;
        self.label.center = CGPointMake(xPoint, yPoint + self.maxDiam/2 + self.fontSize/2*(self.label.numberOfLines));
        [self.loaderView addSubview:self.label];

    }
    
}

- (void)startAnimation {
    [self startFirstAnimation];
    if (self.numberOfCircles >3) {
        [self performSelector:@selector(startSecondAnimation) withObject:nil afterDelay:self.delay];
    }
}

- (void)startFirstAnimation {
    if (self.animate) {
        for (int i = 0; i<3; i++) {
            CALayer *ball = [self.balls objectAtIndex:i];
            [self animateBall:ball atIndex:i];
        }
    }
    
}

- (void)startSecondAnimation {
    if (self.animate) {
        for (int i = 3; i<6; i++) {
            CALayer *ball = [self.balls objectAtIndex:i];
            [self animateBall:ball atIndex:i];
        }
    }
}

- (void)animateBall:(CALayer *)ball atIndex:(int)index {
    CGPoint point;
    switch (index) {
        case 0:
            point = CGPointMake(ball.position.x, ball.position.y + self.separation);
            break;
        case 1:
            point = CGPointMake(ball.position.x + self.separation, ball.position.y - self.separation);
            break;
        case 2:
            point = CGPointMake(ball.position.x - self.separation, ball.position.y - self.separation);
            break;
        case 3:
            point = CGPointMake(ball.position.x, ball.position.y + self.separation);
        case 4:
            if (index == 4) {
                point = CGPointMake(ball.position.x + self.separation, ball.position.y - self.separation);
            }
            break;
        case 5:
            point = CGPointMake(ball.position.x - self.separation, ball.position.y - self.separation);
            break;
            
        default:
            break;
    }
    
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
    position.values = @[[NSValue valueWithCGPoint:ball.position],
                        [NSValue valueWithCGPoint:point]];
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
    position2.values = @[[NSValue valueWithCGPoint:point],
                         [NSValue valueWithCGPoint:point]];
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
    [self startAnimation];
}


@end
