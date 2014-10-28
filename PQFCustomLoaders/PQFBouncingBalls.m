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

@end

@implementation PQFBouncingBalls

#warning Overwrite init method!!!!

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self generateBalls];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self generateBalls];
    }
    return self;
}

- (void)generateBalls {
    self.backgroundColor = [UIColor flatTurquoiseColor];
    
    self.diameter = 20;
    self.jumpAmount = 60;
    self.separation = 30;
    self.zoomAmount = 20;
    self.color = [UIColor flatCloudsColor];
    
    self.ball1 = [CALayer layer];
    self.ball1.bounds = CGRectMake(0, 0, self.diameter, self.diameter);
    self.ball1.cornerRadius = self.diameter/2;
    self.ball1.backgroundColor = self.color.CGColor;
    
    self.ball3 = [CALayer layer];
    self.ball3.bounds = CGRectMake(0, 0, self.diameter, self.diameter);
    self.ball3.cornerRadius = self.diameter/2;
    self.ball3.backgroundColor = self.color.CGColor;
    
    self.ball2 = [CALayer layer];
    self.ball2.bounds = CGRectMake(0, 0, self.diameter, self.diameter);
    self.ball2.cornerRadius = self.diameter/2;
    self.ball2.backgroundColor = self.color.CGColor;
    
    
    self.ball1.position = CGPointMake(CGRectGetWidth(self.frame)/2 - self.separation, CGRectGetHeight(self.frame)/2);
    self.ball2.position = CGPointMake(CGRectGetWidth(self.frame)/2 , CGRectGetHeight(self.frame)/2);
    self.ball3.position = CGPointMake(CGRectGetWidth(self.frame)/2 + self.separation, CGRectGetHeight(self.frame)/2);
    
    [self.layer addSublayer:self.ball1];
    [self.layer addSublayer:self.ball2];
    [self.layer addSublayer:self.ball3];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self animateToLeft];
    [self animateToRight];
}

- (void)animateToLeft {
    //Time 1
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    animation.duration = 1.0;
    animation.values = @[@(self.ball1.position.y), @(self.ball1.position.y - self.jumpAmount), @(self.ball1.position.y)];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithControlPoints:0.5 :-1 :1.0 :1.0],[CAMediaTimingFunction functionWithControlPoints:0.8 :0.0 :0.8 :0.0]];
    animation.beginTime = CACurrentMediaTime();
    
    CAKeyframeAnimation *down = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    down.duration = 1.0;
    down.values = @[@(self.ball2.position.x), @(self.ball2.position.x -self.separation/2 ), @(self.ball2.position.x -self.separation)];
    down.timingFunctions = @[[CAMediaTimingFunction functionWithControlPoints:0.5 :-1 :1.0 :1.0],[CAMediaTimingFunction functionWithControlPoints:0.8 :0.0 :0.8 :0.0]];
    down.beginTime = CACurrentMediaTime();
    
    CAKeyframeAnimation *move = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    move.duration = 1.0;
    move.values = @[@(self.ball1.position.x), @(self.ball1.position.x +self.separation/2 ), @(self.ball1.position.x +self.separation)];
    move.timingFunctions = @[[CAMediaTimingFunction functionWithControlPoints:0.5 :-1 :1.0 :1.0],[CAMediaTimingFunction functionWithControlPoints:0.8 :0.0 :0.8 :0.0]];
    move.beginTime = CACurrentMediaTime();
    
    CAKeyframeAnimation *miniBounds = [CAKeyframeAnimation animationWithKeyPath:@"bounds.size"];
    miniBounds.duration = 1.0;
    miniBounds.values = @[[NSValue valueWithCGSize:CGSizeMake(self.ball1.frame.size.width, self.ball1.frame.size.height)],
                          [NSValue valueWithCGSize:CGSizeMake(self.ball1.frame.size.width + self.zoomAmount, self.ball1.frame.size.height +self.zoomAmount)],
                          [NSValue valueWithCGSize:CGSizeMake(self.ball1.frame.size.width , self.ball1.frame.size.height)]];
    miniBounds.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    CAKeyframeAnimation *radius = [CAKeyframeAnimation animationWithKeyPath:@"cornerRadius"];
    radius.duration = 1.0;
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
    animation2.duration = 1.0;
    animation2.values = @[@(self.ball2.position.y), @(self.ball2.position.y - self.jumpAmount), @(self.ball2.position.y)];
    animation2.timingFunctions = @[[CAMediaTimingFunction functionWithControlPoints:0.5 :-1 :1.0 :1.0],[CAMediaTimingFunction functionWithControlPoints:0.8 :0.0 :0.8 :0.0]];
    animation2.beginTime = CACurrentMediaTime() + 1;
    
    CAKeyframeAnimation *down2 = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    down2.duration = 1.0;
    down2.values = @[@(self.ball2.position.x), @(self.ball2.position.x + self.separation/2 ), @(self.ball2.position.x +self.separation)];
    down2.timingFunctions = @[[CAMediaTimingFunction functionWithControlPoints:0.5 :-1 :1.0 :1.0],[CAMediaTimingFunction functionWithControlPoints:0.8 :0.0 :0.8 :0.0]];
    down2.beginTime = CACurrentMediaTime() + 1;
    
    CAKeyframeAnimation *move2 = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    move2.duration = 1.0;
    move2.delegate = self;
    move2.values = @[@(self.ball3.position.x), @(self.ball3.position.x - self.separation/2 ), @(self.ball3.position.x - self.separation)];
    move2.timingFunctions = @[[CAMediaTimingFunction functionWithControlPoints:0.5 :-1 :1.0 :1.0],[CAMediaTimingFunction functionWithControlPoints:0.8 :0.0 :0.8 :0.0]];
    move2.beginTime = CACurrentMediaTime() +1 ;
    
    CAKeyframeAnimation *miniBounds2 = [CAKeyframeAnimation animationWithKeyPath:@"bounds.size"];
    miniBounds2.duration = 1.0;
    miniBounds2.values = @[[NSValue valueWithCGSize:CGSizeMake(self.ball2.frame.size.width, self.ball2.frame.size.height)],
                           [NSValue valueWithCGSize:CGSizeMake(self.ball2.frame.size.width + self.zoomAmount, self.ball2.frame.size.height + self.zoomAmount)],
                           [NSValue valueWithCGSize:CGSizeMake(self.ball2.frame.size.width , self.ball2.frame.size.height)]];
    miniBounds2.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    miniBounds2.beginTime = CACurrentMediaTime() +1 ;
    
    CAKeyframeAnimation *radius2 = [CAKeyframeAnimation animationWithKeyPath:@"cornerRadius"];
    radius2.duration = 1.0;
    radius2.values = @[@(self.diameter/2), @((self.diameter + self.zoomAmount)/2), @(self.diameter/2)];
    radius2.beginTime = CACurrentMediaTime() +1 ;
    radius2.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    [self.ball2 addAnimation:animation2 forKey:@"anything5"];
    [self.ball2 addAnimation:down2 forKey:@"anything6"];
    [self.ball3 addAnimation:move2 forKey:@"anything4"];
    [self.ball2 addAnimation:miniBounds2 forKey:@"miniBounds2"];
    [self.ball2 addAnimation:radius2 forKey:@"radius2"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self touchesBegan:nil withEvent:nil];
}

//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
//    [self animationReapeat];
//}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end