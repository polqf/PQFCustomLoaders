//
//  PQFBouncingBalls.m
//  randomAnimations
//
//  Created by Pol Quintana on 28/10/14.
//  Copyright (c) 2014 Pol Quintana. All rights reserved.
//

#import "PQFBouncingBalls.h"
#import <UIColor+FlatColors.h>

@interface PQFBouncingBalls ()

@property CALayer *ball1;
@property CALayer *ball2;
@property CALayer *ball3;

@property (nonatomic, strong) NSArray *balls;
@property (nonatomic) BOOL animate;
@property (nonatomic, strong) UIView *loaderView;
@property (nonatomic) CGFloat fontSize;
@property (nonatomic) CGFloat rectSize;

@end

@implementation PQFBouncingBalls

- (instancetype)initLoaderOnView:(UIView *)view {
    self = [super init];
    
    [self defaultValues];
    
    self.frame = CGRectMake(0, 0, view.frame.size.width, self.rectSize + 40);
    self.center = view.center;
    
    //[self setClipsToBounds:YES];
    
    [view addSubview:self];
    
    //Loader View Initialization
    self.loaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.rectSize + 10, self.rectSize + 10)];
    self.loaderView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    [self addSubview:self.loaderView];
    
    return self;
}

- (void)defaultValues {
    self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.0];
    self.cornerRadius = 0;
    self.loaderAlpha = 1.0;
    self.loaderColor = [UIColor flatCloudsColor];
    self.diameter = 16;
    self.jumpAmount = 50;
    self.separation = 20;
    self.zoomAmount = 20;
    self.duration = 1.0;
    self.fontSize = 14.0;
    self.rectSize = self.diameter + self.jumpAmount + self.zoomAmount/2;
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
    
    //Generate frames
    self.rectSize = self.diameter + self.jumpAmount + self.zoomAmount/2;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.rectSize + 40);
    self.loaderView.frame = CGRectMake(self.loaderView.frame.origin.x, self.loaderView.frame.origin.y, self.loaderView.frame.size.width, self.rectSize + 10);
    
    
    //Layers
    self.layer.cornerRadius = self.cornerRadius;
    
    self.ball1 = [CALayer layer];
    self.ball1.bounds = CGRectMake(0, 0, self.diameter, self.diameter);
    self.ball1.cornerRadius = self.diameter/2;
    self.ball1.backgroundColor = self.loaderColor.CGColor;
    self.ball1.opacity = self.loaderAlpha;
    
    self.ball3 = [CALayer layer];
    self.ball3.bounds = CGRectMake(0, 0, self.diameter, self.diameter);
    self.ball3.cornerRadius = self.diameter/2;
    self.ball3.backgroundColor = self.loaderColor.CGColor;
    self.ball3.opacity = self.loaderAlpha;
    
    self.ball2 = [CALayer layer];
    self.ball2.bounds = CGRectMake(0, 0, self.diameter, self.diameter);
    self.ball2.cornerRadius = self.diameter/2;
    self.ball2.backgroundColor = self.loaderColor.CGColor;
    self.ball2.opacity = self.loaderAlpha;
    
    self.ball1.position = CGPointMake(CGRectGetWidth(self.frame)/2 - self.separation, CGRectGetHeight(self.frame)/2 + self.jumpAmount/2);
    self.ball2.position = CGPointMake(CGRectGetWidth(self.frame)/2 , CGRectGetHeight(self.frame)/2 + self.jumpAmount/2);
    self.ball3.position = CGPointMake(CGRectGetWidth(self.frame)/2 + self.separation, CGRectGetHeight(self.frame)/2 + self.jumpAmount/2);
    
    [self.layer addSublayer:self.ball1];
    [self.layer addSublayer:self.ball2];
    [self.layer addSublayer:self.ball3];
    
    [self autolayoutByCode];
}


- (void)autolayoutByCode {
    
    //Loader View
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.numberOfLines = 3;
    self.label.textColor = [UIColor whiteColor];
    self.label.font = [UIFont systemFontOfSize:self.fontSize];
    if ([self.label.text isEqualToString:@""]) {
        self.label.text = nil;
    }
        
    if (self.label.text) {
        CGFloat xCenter = self.center.x;
        CGFloat yCenter = self.center.y;
    
        self.loaderView.frame = CGRectMake(self.loaderView.frame.origin.x, self.loaderView.frame.origin.y, self.loaderView.frame.size.width, self.loaderView.frame.size.height + 10 + self.label.frame.size.height );

        self.frame = CGRectMake(0, 0, self.frame.size.width, self.loaderView.frame.size.height + 10 );
        self.center = CGPointMake(xCenter, yCenter);
        self.loaderView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);

        CGFloat xPoint = CGRectGetWidth(self.loaderView.frame)/2;
        CGFloat yPoint = CGRectGetHeight(self.loaderView.frame) - self.fontSize/2 *[self.label numberOfLines];
        
        self.label.center = CGPointMake(xPoint, yPoint);
        [self.loaderView addSubview:self.label];
    }
    
}


- (void)startAnimation {
    if (self.animate) {
        [self animateToLeft];
        [self animateToRight];
    }
}

- (void)animateToLeft {
    //Time 1
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    animation.duration = self.duration;
    animation.values = @[@(self.ball1.position.y), @(self.ball1.position.y - self.jumpAmount), @(self.ball1.position.y)];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithControlPoints:0.5 :-1 :1.0 :1.0],[CAMediaTimingFunction functionWithControlPoints:0.8 :0.0 :0.8 :0.0]];
    animation.beginTime = CACurrentMediaTime();
    
    CAKeyframeAnimation *down = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    down.duration = self.duration;
    down.values = @[@(self.ball2.position.x), @(self.ball2.position.x -self.separation/2 ), @(self.ball2.position.x -self.separation)];
    down.timingFunctions = @[[CAMediaTimingFunction functionWithControlPoints:0.5 :-1 :1.0 :1.0],[CAMediaTimingFunction functionWithControlPoints:0.8 :0.0 :0.8 :0.0]];
    down.beginTime = CACurrentMediaTime();
    
    CAKeyframeAnimation *move = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    move.duration = self.duration;
    move.values = @[@(self.ball1.position.x), @(self.ball1.position.x +self.separation/2 ), @(self.ball1.position.x +self.separation)];
    move.timingFunctions = @[[CAMediaTimingFunction functionWithControlPoints:0.5 :-1 :1.0 :1.0],[CAMediaTimingFunction functionWithControlPoints:0.8 :0.0 :0.8 :0.0]];
    move.beginTime = CACurrentMediaTime();
    
    CAKeyframeAnimation *miniBounds = [CAKeyframeAnimation animationWithKeyPath:@"bounds.size"];
    miniBounds.duration = self.duration;
    miniBounds.values = @[[NSValue valueWithCGSize:CGSizeMake(self.ball1.frame.size.width, self.ball1.frame.size.height)],
                          [NSValue valueWithCGSize:CGSizeMake(self.ball1.frame.size.width + self.zoomAmount, self.ball1.frame.size.height +self.zoomAmount)],
                          [NSValue valueWithCGSize:CGSizeMake(self.ball1.frame.size.width , self.ball1.frame.size.height)]];
    miniBounds.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    CAKeyframeAnimation *radius = [CAKeyframeAnimation animationWithKeyPath:@"cornerRadius"];
    radius.duration = self.duration;
    radius.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    radius.values = @[@(self.diameter/2), @((self.diameter + self.zoomAmount)/2), @(self.diameter/2)];
    
    [self.ball2 addAnimation:miniBounds forKey:@"miniBounds"];
    [self.ball2 addAnimation:down forKey:@"anything2"];
    [self.ball2 addAnimation:animation forKey:@"anything"];
    [self.ball1 addAnimation:move forKey:@"anything3"];
    [self.ball2 addAnimation:radius forKey:@"radius"];
    
}

- (void)animateToRight {
    CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    animation2.duration = self.duration;
    animation2.values = @[@(self.ball2.position.y), @(self.ball2.position.y - self.jumpAmount), @(self.ball2.position.y)];
    animation2.timingFunctions = @[[CAMediaTimingFunction functionWithControlPoints:0.5 :-1 :1.0 :1.0],[CAMediaTimingFunction functionWithControlPoints:0.8 :0.0 :0.8 :0.0]];
    animation2.beginTime = CACurrentMediaTime() + self.duration;
    
    CAKeyframeAnimation *down2 = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    down2.duration = self.duration;
    down2.values = @[@(self.ball2.position.x), @(self.ball2.position.x + self.separation/2 ), @(self.ball2.position.x +self.separation)];
    down2.timingFunctions = @[[CAMediaTimingFunction functionWithControlPoints:0.5 :-1 :1.0 :1.0],[CAMediaTimingFunction functionWithControlPoints:0.8 :0.0 :0.8 :0.0]];
    down2.beginTime = CACurrentMediaTime() + self.duration;
    
    CAKeyframeAnimation *move2 = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    move2.duration = self.duration;
    move2.delegate = self;
    move2.values = @[@(self.ball3.position.x), @(self.ball3.position.x - self.separation/2 ), @(self.ball3.position.x - self.separation)];
    move2.timingFunctions = @[[CAMediaTimingFunction functionWithControlPoints:0.5 :-1 :1.0 :1.0],[CAMediaTimingFunction functionWithControlPoints:0.8 :0.0 :0.8 :0.0]];
    move2.beginTime = CACurrentMediaTime() + self.duration ;
    
    CAKeyframeAnimation *miniBounds2 = [CAKeyframeAnimation animationWithKeyPath:@"bounds.size"];
    miniBounds2.duration = self.duration;
    miniBounds2.values = @[[NSValue valueWithCGSize:CGSizeMake(self.ball2.frame.size.width, self.ball2.frame.size.height)],
                           [NSValue valueWithCGSize:CGSizeMake(self.ball2.frame.size.width + self.zoomAmount, self.ball2.frame.size.height + self.zoomAmount)],
                           [NSValue valueWithCGSize:CGSizeMake(self.ball2.frame.size.width , self.ball2.frame.size.height)]];
    miniBounds2.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    miniBounds2.beginTime = CACurrentMediaTime() + self.duration ;
    
    CAKeyframeAnimation *radius2 = [CAKeyframeAnimation animationWithKeyPath:@"cornerRadius"];
    radius2.duration = self.duration;
    radius2.values = @[@(self.diameter/2), @((self.diameter + self.zoomAmount)/2), @(self.diameter/2)];
    radius2.beginTime = CACurrentMediaTime() + self.duration;
    radius2.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    [self.ball2 addAnimation:animation2 forKey:@"anything5"];
    [self.ball2 addAnimation:down2 forKey:@"anything6"];
    [self.ball3 addAnimation:move2 forKey:@"anything4"];
    [self.ball2 addAnimation:miniBounds2 forKey:@"miniBounds2"];
    [self.ball2 addAnimation:radius2 forKey:@"radius2"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self startAnimation];
}

@end