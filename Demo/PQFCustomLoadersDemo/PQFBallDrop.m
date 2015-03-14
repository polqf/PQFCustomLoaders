//
//  PQFBallDrop.m
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 6/3/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import "PQFBallDrop.h"
#import <UIColor+FlatColors.h>
#import <pop/POP.h>

@interface PQFBallDrop () <POPAnimationDelegate, UICollisionBehaviorDelegate>
@property (nonatomic, strong) UIView *loaderView;
@property (nonatomic, strong) UIView *fallingBall;
@property (nonatomic, strong) UIView *mainBall;
@property (nonatomic, strong) UIDynamicAnimator *mainAnimator;
@property (nonatomic) BOOL restart;
@property (nonatomic) BOOL animate;

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIColor *loaderColor;
@property (nonatomic) CGFloat loaderAlpha;
@property (nonatomic) CGFloat maxDiam;
@property (nonatomic) CGFloat amountZoom;
@property (nonatomic) CGFloat delay;
@property (nonatomic) CGFloat duration;
@property (nonatomic) CGFloat fontSize;
@property (nonatomic) CGFloat rectSize;
@end

@implementation PQFBallDrop


+ (instancetype)showLoader:(PQFLoaderType)loaderType onView:(UIView *)view
{
    PQFBallDrop *loader = [self createLoader:loaderType onView:view];
    [loader showLoader];
    return loader;
}

+ (instancetype)createLoader:(PQFLoaderType)loaderType onView:(UIView *)view
{
    if (!view) view = [[UIApplication sharedApplication].delegate window];
    PQFBallDrop *loader = [PQFBallDrop new];
    [loader initialSetupWithView:view];
    return loader;
}

- (void)showLoader
{
    [self performSelector:@selector(startShowingLoader) withObject:nil afterDelay:0];
}

- (void)startShowingLoader
{
    self.hidden = NO;
    self.animate = YES;
    [self generateLoader];
    [self startAnimating];
}

- (void)removeLoader
{
    self.hidden = YES;
    self.animate = NO;
    [self removeFromSuperview];
}


#pragma mark - Prepare loader

- (void)initialSetupWithView:(UIView *)view
{
    //Setting up frame
    self.frame = view.frame;
    self.center = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
    
    //If it is modal, background for the loader
    if ([view isKindOfClass:[UIWindow class]]) {
        UIView *bgView = [[UIView alloc] initWithFrame:view.bounds];
        bgView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.6];
        [self addSubview:bgView];
    }
    
    //Add loader to its superview
    [view addSubview:self];
    
    //Initial Values
    [self defaultValues];
    
    //Initially hidden
    self.hidden = YES;
}

- (void)defaultValues
{
    self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.4];
    self.restart = YES;
    self.loaderAlpha = 1.0;
    self.loaderColor = [UIColor flatCloudsColor];
    self.maxDiam = 50;
    self.amountZoom = 5;
    self.delay = 1.7;
    self.duration = 2.0;
    self.fontSize = 14.0;
    self.rectSize = self.maxDiam;
}


#pragma mark - Before showing


- (void)generateLoader
{
    self.loaderView.frame = CGRectMake(0, 0, self.frame.size.width, self.rectSize + 30);
    self.loaderView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    self.label.frame = CGRectMake(0, 0, self.rectSize + 30, self.fontSize*2+10);

    self.layer.cornerRadius = self.cornerRadius;
    
    [self layoutBalls];
    
    if (self.label.text) [self layoutLabel];
}

- (void)layoutBalls
{
    self.fallingBall.frame = CGRectMake(self.loaderView.frame.size.width/2 - 5, 0, 10, 10);
    self.fallingBall.layer.cornerRadius = 5;
    self.fallingBall.center = CGPointMake(CGRectGetWidth(self.loaderView.frame)/2, 0);
    self.mainBall.frame = CGRectMake(0, 0, 0, 0);
    self.mainBall.layer.cornerRadius = 0;
    self.mainBall.center = CGPointMake(CGRectGetWidth(self.loaderView.frame)/2 , CGRectGetHeight(self.loaderView.frame)/2);
    
    self.mainAnimator;
}

- (void)layoutLabel
{
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.numberOfLines = 3;
    self.label.textColor = [UIColor whiteColor];
    self.label.font = [UIFont systemFontOfSize:self.fontSize];
    
    CGFloat xCenter = self.center.x;
    CGFloat yCenter = self.center.y;
    
    self.loaderView.frame = CGRectMake(self.loaderView.frame.origin.x, self.loaderView.frame.origin.y, self.loaderView.frame.size.width, self.loaderView.frame.size.height + 10 + self.label.frame.size.height );
    
    self.frame = CGRectMake(0, 0, self.frame.size.width, self.loaderView.frame.size.height + 10 );
    self.center = CGPointMake(xCenter, yCenter);
    self.loaderView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    
    CGFloat xPoint = CGRectGetWidth(self.loaderView.frame)/2;
    CGFloat yPoint = CGRectGetHeight(self.loaderView.frame) - self.fontSize/2 *[self.label numberOfLines];
    
    self.label.center = CGPointMake(xPoint, yPoint);
}


#pragma mark - Animate

- (void)startAnimating
{
    if (!self.animate) return;
    [self animateDrop];
}

- (void)animateDrop {
    if (CGRectGetWidth(self.mainBall.frame) >= self.maxDiam) {
        self.mainBall.bounds = CGRectMake(0, 0, 0, 0);
        self.restart = YES;
    }
    self.fallingBall.hidden = NO;
    self.fallingBall.center = CGPointMake(CGRectGetWidth(self.loaderView.frame)/2, 0);
}

- (void)animateMainBall {
    
    POPSpringAnimation *bounds = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBounds];
    bounds.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, CGRectGetWidth(self.mainBall.frame) + self.amountZoom, CGRectGetWidth(self.mainBall.frame) + self.amountZoom)];
    bounds.springBounciness = 20;
    bounds.springSpeed = 0;
    bounds.delegate = self;
    [self.mainBall pop_addAnimation:bounds forKey:@"animateBounds"];
    
    POPSpringAnimation *radius = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerCornerRadius];
    if (self.restart) {
        self.restart = NO;
        self.mainBall.layer.cornerRadius = 0;
    }
    radius.toValue = @(CGRectGetWidth(self.mainBall.frame)/2 + self.amountZoom/2);
    NSLog(@"%f", self.mainBall.layer.cornerRadius);
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
            self.fallingBall.hidden = YES;
            [self animateMainBall];
        }
    }
}


#pragma mark - Custom setters

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    self.loaderView.backgroundColor = backgroundColor;
}

- (void)setLoaderColor:(UIColor *)loaderColor
{
    _loaderColor = loaderColor;
    self.mainBall.backgroundColor = loaderColor;
    self.fallingBall.backgroundColor = loaderColor;
}

- (void)setLoaderAlpha:(CGFloat)loaderAlpha
{
    _loaderAlpha = loaderAlpha;
    self.loaderView.alpha = loaderAlpha;
    self.mainBall.alpha = loaderAlpha;
    self.fallingBall.alpha = loaderAlpha;
}


#pragma mark - Lazy inits

- (UIView *)loaderView
{
    if (!_loaderView) {
        _loaderView = [UIView new];
        [_loaderView setClipsToBounds:YES];
        [self addSubview:_loaderView];
    }
    return _loaderView;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [UILabel new];
        [self.loaderView addSubview:_label];
    }
    return _label;
}

- (UIView *)fallingBall
{
    if (!_fallingBall) {
        _fallingBall = [UIView new];
        [self.loaderView addSubview:_fallingBall];
    }
    return _fallingBall;
}

- (UIView *)mainBall
{
    if (!_mainBall) {
        _mainBall = [UIView new];
        [self.loaderView addSubview:_mainBall];
    }
    return _mainBall;
}

- (UIDynamicAnimator *)mainAnimator
{
    if (!_mainAnimator) {
        _mainAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.loaderView];
        UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.fallingBall]];
        gravity.magnitude = 0.85;
        [_mainAnimator addBehavior:gravity];
        UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.fallingBall]];
        collision.translatesReferenceBoundsIntoBoundary = YES;
        collision.collisionDelegate = self;
        [collision addBoundaryWithIdentifier:@"boundary"
                                   fromPoint:CGPointMake(CGRectGetWidth(self.loaderView.frame)/2 -10, CGRectGetHeight(self.loaderView.frame)/2  - CGRectGetHeight(self.mainBall.frame)/2) toPoint:CGPointMake(CGRectGetWidth(self.loaderView.frame)/2 +10 , CGRectGetHeight(self.loaderView.frame)/2  - CGRectGetHeight(self.mainBall.frame)/2)];
        [_mainAnimator addBehavior:collision];
    }
    return _mainAnimator;
}


#pragma mark - Deprecated methods

- (instancetype)initLoaderOnView:(UIView *)view
{
    return [PQFBallDrop createLoader:PQFLoaderTypeBallDrop onView:view];
}

@end
