//
//  PQFBallDrop.m
//  PQFCustomLoaders
//
//  Created by Pol Quintana on 4/12/14.
//  Copyright (c) 2014 Pol Quintana. All rights reserved.
//

#import "PQFBallDrop.h"
#import <UIColor+FlatColors.h>
#import <pop/POP.h>

@interface PQFBallDrop () <POPAnimationDelegate, UICollisionBehaviorDelegate>

@property (nonatomic, strong) UIDynamicAnimator *mainAnimator;
@property (nonatomic, strong) UIView *fallingBall;
@property (nonatomic, strong) UIView *mainBall;
@property (nonatomic) BOOL animate;
@property (nonatomic, strong) UIView *loaderView;
@property (nonatomic) CGFloat fontSize;
@property (nonatomic) CGFloat rectSize;
@property (nonatomic) CGFloat amountZoom;

@end

@implementation PQFBallDrop

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
    
    self.mainBall = [[UIView alloc] init];
    
    self.fallingBall = [[UIView alloc] initWithFrame:CGRectMake(self.loaderView.frame.size.width/2 - 5, 0, 10, 10)];
    self.fallingBall.backgroundColor = self.loaderColor;
    self.fallingBall.layer.cornerRadius = 5;
    
    [self.loaderView addSubview:self.fallingBall];
    
    return self;
}

- (void)defaultValues {
    self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.0];
    self.loaderAlpha = 1.0;
    self.loaderColor = [UIColor flatCloudsColor];
    self.maxDiam = 100;
    self.amountZoom = 5;
    self.delay = 1.7;
    self.duration = 2.0;
    self.fontSize = 14.0;
    self.rectSize = self.maxDiam;
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.rectSize + 30, self.fontSize*2+10)];
}

#pragma mark - public methods

- (void)show {
    self.alpha = 1.0;
    self.animate = YES;
    [self generateLoader];
    [self animateDrop];
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
    self.rectSize = self.maxDiam;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.rectSize + 20);
    self.loaderView.frame = CGRectMake(self.loaderView.frame.origin.x, self.loaderView.frame.origin.y, self.rectSize + 10, self.rectSize + 10);
    
    //Layer
    self.mainBall.frame = CGRectMake(0, 0, 5, 5);
    self.mainBall.layer.cornerRadius = 5/2;
    self.mainBall.layer.opacity = self.loaderAlpha;
    self.mainBall.layer.backgroundColor = [UIColor flatCloudsColor].CGColor;
    self.mainBall.center = CGPointMake(CGRectGetWidth(self.loaderView.frame)/2 , CGRectGetHeight(self.loaderView.frame)/2);
    
    [self.loaderView addSubview:self.mainBall];
    
    [self autolayoutByCode];
    
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

- (void)animateDrop {
    self.fallingBall.center = CGPointMake(CGRectGetWidth(self.loaderView.frame)/2, 0);
    self.fallingBall.hidden = NO;
    
    self.animate = YES;
    
    self.mainAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.loaderView];
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.fallingBall]];
    gravity.magnitude = 1.0;
    
    [self.mainAnimator addBehavior:gravity];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.fallingBall]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    collision.collisionDelegate = self;
    [collision addBoundaryWithIdentifier:@"boundary"
                               fromPoint:CGPointMake(CGRectGetWidth(self.loaderView.frame)/2 -10, CGRectGetHeight(self.loaderView.frame)/2  - CGRectGetHeight(self.mainBall.frame)/2) toPoint:CGPointMake(CGRectGetWidth(self.loaderView.frame)/2 +10 , CGRectGetHeight(self.loaderView.frame)/2  - CGRectGetHeight(self.mainBall.frame)/2)];
   
    [self.mainAnimator addBehavior:collision];
    
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.mainBall, self.fallingBall]];
    itemBehavior.elasticity = 0.9;
    itemBehavior.density = 5;
    [self.mainAnimator addBehavior:itemBehavior];
}

- (void)animateMainBall {
    POPSpringAnimation *bounds = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBounds];
    bounds.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, CGRectGetWidth(self.mainBall.frame) + self.amountZoom, CGRectGetWidth(self.mainBall.frame) + self.amountZoom)];
    bounds.springBounciness = 20;
    bounds.springSpeed = 0;
    bounds.delegate = self;
    [self.mainBall pop_addAnimation:bounds forKey:@"animateBounds"];
    
    POPSpringAnimation *radius = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerCornerRadius];
    radius.toValue = @(CGRectGetWidth(self.mainBall.frame)/2 + self.amountZoom/2);
    radius.springBounciness = 20;
    radius.springSpeed = 0;
    [self.mainBall.layer pop_addAnimation:radius forKey:@"animateRadius"];
    
    [self performSelector:@selector(animateDrop) withObject:nil afterDelay: self.delay];
}

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished {
    
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {
    
    if (self.animate) {
        if ([@"boundary" isEqualToString:(NSString *)identifier]) {
            self.animate = NO;
            self.fallingBall.hidden = YES;
            [self animateMainBall];
        }
    }
}


@end
