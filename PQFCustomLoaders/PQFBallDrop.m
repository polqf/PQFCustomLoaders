//
//  PQFBallDrop.m
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 6/3/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import "PQFBallDrop.h"
#import <UIColor+FlatColors/UIColor+FlatColors.h>
#import <pop/POP.h>

@interface PQFBallDrop () <POPAnimationDelegate, UICollisionBehaviorDelegate, PQFLoaderProtocol>
@property (nonatomic, strong) UIView *loaderView;
@property (nonatomic, strong) UIView *fallingBall;
@property (nonatomic, strong) UIView *mainBall;
@property (nonatomic, strong) UIDynamicAnimator *mainAnimator;
@property (nonatomic, strong) UIGravityBehavior *gravityBehaviour;
@property (nonatomic, strong) UICollisionBehavior *collisionBehaviour;
@property (nonatomic) BOOL restart;
@property (nonatomic) BOOL animate;
@property (nonatomic) CGFloat rectSize;
@end

@implementation PQFBallDrop


#pragma mark - IB_DESIGNABLE

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialSetupWithView:nil];
    }
    return self;
}


+ (instancetype)showLoaderOnView:(UIView *)view
{
    PQFBallDrop *loader = [self createLoaderOnView:view];
    [loader showLoader];
    return loader;
}

+ (instancetype)createLoaderOnView:(UIView *)view
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

- (void)hideLoader
{
    self.hidden = YES;
    self.animate = NO;
}

- (void)removeLoader
{
    [self hideLoader];
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
    
    [self.loaderView addSubview:self.label];
    
    //Initial Values
    [self defaultValues];
    
    //Initially hidden
    self.hidden = YES;
}

- (void)defaultValues
{
    [super setBackgroundColor:[UIColor clearColor]];
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
    self.loaderView.layer.cornerRadius  = self.cornerRadius;
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
}

- (void)layoutLabel
{
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.numberOfLines = 3;
    self.label.textColor = [UIColor whiteColor];
    self.label.font = [UIFont systemFontOfSize:self.fontSize];
    
    CGFloat xCenter = self.center.x;
    CGFloat yCenter = self.center.y;
    self.mainBall.center = CGPointMake(self.mainBall.center.x, self.mainBall.center.y + 10);
    
    self.loaderView.frame = CGRectMake(self.loaderView.frame.origin.x, self.loaderView.frame.origin.y, self.loaderView.frame.size.width, self.loaderView.frame.size.height + 10 + self.fontSize*2+10 );
    
    self.frame = CGRectMake(0, 0, self.frame.size.width, self.loaderView.frame.size.height + 10);
    self.center = CGPointMake(xCenter, yCenter);
    self.loaderView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    
    CGFloat xPoint = CGRectGetWidth(self.loaderView.frame)/2;
    CGFloat yPoint = CGRectGetHeight(self.loaderView.frame) - self.fontSize/2 *[self.label numberOfLines];
    
    self.label.frame = CGRectMake(0, 0, CGRectGetHeight(self.loaderView.frame), self.fontSize*2+10);
    self.label.center = CGPointMake(xPoint, yPoint);
}


#pragma mark - Animate

- (void)startAnimating
{
    if (!self.animate) return;
    [self animateDrop];
}

- (void)animateDrop {
    self.mainBall.alpha = 1.0;
    self.fallingBall.hidden = NO;
    self.fallingBall.center = CGPointMake(CGRectGetWidth(self.loaderView.frame)/2, 0);

    [self.mainAnimator addBehavior:self.gravityBehaviour];
    [self.mainAnimator addBehavior:self.collisionBehaviour];
}

- (void)animateMainBall {
    
    POPSpringAnimation *bounds = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBounds];
    if (CGRectGetWidth(self.mainBall.frame) + self.amountZoom >= self.maxDiam) {
        bounds.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 0, 0)];
        bounds.springBounciness = 0;
        bounds.springSpeed = 20;
    }
    else {
        bounds.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, CGRectGetWidth(self.mainBall.frame) + self.amountZoom, CGRectGetWidth(self.mainBall.frame) + self.amountZoom)];
        bounds.springBounciness = 20;
        bounds.springSpeed = 0;
    }
    bounds.delegate = self;
    [bounds setValue:@"bounds" forKey:@"identifier"];
    [self.mainBall pop_addAnimation:bounds forKey:@"animateBounds"];
    
    POPSpringAnimation *radius = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerCornerRadius];
    if (CGRectGetWidth(self.mainBall.frame) + self.amountZoom >= self.maxDiam) {
        radius.toValue = @0;
        radius.springSpeed = 20;
        radius.springBounciness = 0;
    }
    else {
        radius.toValue = @(CGRectGetWidth(self.mainBall.frame)/2 + self.amountZoom/2);
        radius.springSpeed = 0;
        radius.springBounciness = 20;
    }
    [self.mainBall.layer pop_addAnimation:radius forKey:@"animateRadius"];
    
    [self performSelector:@selector(animateDrop) withObject:nil afterDelay: self.delay];
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {
    if (self.animate && [@"boundary" isEqualToString:(NSString *)identifier]) {
        self.fallingBall.hidden = YES;
        [self animateMainBall];
        for (UIDynamicBehavior *behaviour in self.mainAnimator.behaviors) {
            [self.mainAnimator removeBehavior:behaviour];
        }
    }
}


#pragma mark - Custom setters

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:[UIColor clearColor]];
    self.loaderView.backgroundColor = backgroundColor;
    self.loaderView.layer.backgroundColor = backgroundColor.CGColor;
}

- (void)setLoaderColor:(UIColor *)loaderColor
{
    _loaderColor = loaderColor;
    self.mainBall.backgroundColor = loaderColor;
    self.fallingBall.backgroundColor = loaderColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.loaderView.layer.cornerRadius = cornerRadius;
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
    if (!_mainAnimator) _mainAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.loaderView];
    return _mainAnimator;
}

- (UIGravityBehavior *)gravityBehaviour
{
    _gravityBehaviour = [[UIGravityBehavior alloc] initWithItems:@[self.fallingBall]];
    _gravityBehaviour.magnitude = 0.85;
    return _gravityBehaviour;
}

- (UICollisionBehavior *)collisionBehaviour
{
    _collisionBehaviour = [[UICollisionBehavior alloc] initWithItems:@[self.fallingBall]];
    _collisionBehaviour.translatesReferenceBoundsIntoBoundary = YES;
    _collisionBehaviour.collisionDelegate = self;
    [_collisionBehaviour addBoundaryWithIdentifier:@"boundary"
                               fromPoint:CGPointMake(self.mainBall.center.x - 10, self.mainBall.center.y - self.mainBall.frame.size.height/2)
                                           toPoint:CGPointMake(self.mainBall.center.x + 10, self.mainBall.center.y - self.mainBall.frame.size.height/2)];
    return _collisionBehaviour;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [UILabel new];
    }
    return _label;
}


#pragma mark - Deprecated methods

- (instancetype)initLoaderOnView:(UIView *)view
{
    return [PQFBallDrop createLoaderOnView:view];
}


#pragma mark - Draw rect for IB_DESIGNABLE

- (void)drawRect:(CGRect)rect {
#if TARGET_INTERFACE_BUILDER
    self.loaderView.frame = CGRectMake(0, 0, self.frame.size.width, self.maxDiam + 30);
    self.loaderView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    self.mainBall.bounds = CGRectMake(0, 0, self.maxDiam/2, self.maxDiam/2);
    self.hidden = NO;
    [self layoutBalls];
    self.mainBall.bounds = CGRectMake(0, 0, self.maxDiam/2, self.maxDiam/2);
    self.mainBall.layer.cornerRadius = self.maxDiam/4;
#endif
}

@end
