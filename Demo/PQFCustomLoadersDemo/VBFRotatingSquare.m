//
//  VBFRotatingSquare.m
//  VBFFlatLoaders
//
//  Created by Victor Baro on 19/09/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "VBFRotatingSquare.h"
#import <UIColor+FlatColors/UIColor+FlatColors.h>


@interface VBFRotatingSquare ()
@property (nonatomic, strong) UIView *loaderView;
@property (nonatomic, strong) UIView *square;
@property (nonatomic, strong) CAShapeLayer *shadow;
@property (nonatomic, assign) BOOL animate;
@property (nonatomic) CGFloat rectSize;
@end

@implementation VBFRotatingSquare

#pragma mark - PQFLoader methods

+ (instancetype)showLoaderOnView:(UIView *)view
{
    VBFRotatingSquare *loader = [self createLoaderOnView:view];
    [loader showLoader];
    return loader;
}

+ (instancetype)createLoaderOnView:(UIView *)view
{
    if (!view) view = [[UIApplication sharedApplication].delegate window];
    VBFRotatingSquare *loader = [VBFRotatingSquare new];
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
    [self startAnimation];
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
    self.cornerRadius = 0;
    self.loaderAlpha = 1.0;
    self.loaderColor = [UIColor flatCloudsColor];
    self.borderColor = [UIColor whiteColor];
    self.side = 30;
    self.duration = 0.65;
    self.fontSize = 14.0;
    self.rectSize = self.side * sqrt(2);
    self.tensionValue = 1;
}



#pragma mark - Before showing

- (void)generateLoader
{
    [self.loaderView layoutSubviews];
    self.loaderView.frame = CGRectMake(0, 0, self.frame.size.width, self.rectSize + 30);
    self.loaderView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    self.loaderView.layer.cornerRadius  = self.cornerRadius;
    
    [self addSquare];
    [self addShadow];
    
    if (self.label.text) [self layoutLabel];
}

- (void)layoutLabel
{
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.numberOfLines = 3;
    self.label.textColor = [UIColor whiteColor];
    self.label.font = [UIFont systemFontOfSize:self.fontSize];
    
    self.loaderView.frame = CGRectMake(self.loaderView.frame.origin.x, self.loaderView.frame.origin.y, self.loaderView.frame.size.width, self.loaderView.frame.size.height + 10 + self.fontSize*2+10 );
    self.loaderView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    
    CGFloat xPoint = CGRectGetWidth(self.loaderView.frame)/2;
    CGFloat yPoint = CGRectGetHeight(self.loaderView.frame) - self.fontSize/2 *[self.label numberOfLines];
    
    self.label.frame = CGRectMake(0, 0, CGRectGetHeight(self.loaderView.frame), self.fontSize*2+10);
    self.label.center = CGPointMake(xPoint, yPoint);
}

- (void) addSquare {
    self.square = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                      0,
                                                      _side,
                                                      _side)];
    self.square.center = self.center;
    self.square.backgroundColor = self.loaderColor;
    self.square.layer.borderColor = self.borderColor.CGColor;
    _square.layer.borderWidth = 1.0;
    
    [self addSubview:_square];
}

- (void) addShadow {
    _shadow = [CAShapeLayer layer];

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(_square.frame.origin.x,
                                  _square.frame.origin.y + _side + 2)];
    [path addLineToPoint:CGPointMake(_square.frame.origin.x + _side,
                                     _square.frame.origin.y + _side + 2)];
    
    self.shadow.path = path.CGPath;
    self.shadow.strokeColor = [UIColor colorWithWhite:0.3 alpha:0.4].CGColor;
    self.shadow.lineWidth = 0.0;
    self.shadow.lineCap = kCALineCapRound;
    
    [self.layer addSublayer:self.shadow];
}

#pragma mark - Animate

- (void) startAnimation {
    if (!self.animate) return;
    [self.square.layer addAnimation:[self addAnimationRotation] forKey:@"rot"];
    [self.square.layer addAnimation:[self addAnimationVerticalMovement] forKey:@"trans"];
    [self.shadow addAnimation:[self addShadowAnimation] forKey:@"stroke"];
}

- (CAKeyframeAnimation *) addAnimationRotation {
    CAKeyframeAnimation *rotation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.values = @[@0, @(M_PI_4), @(M_PI_2)];
    rotation.keyTimes = @[@0.0, @0.5, @1.0];
    rotation.duration = self.duration;
    rotation.calculationMode = kCAAnimationCubic;
    rotation.tensionValues = @[@(-self.tensionValue + 1.1),@(0.0),@(-self.tensionValue - 2)];
    rotation.delegate = self;
    return rotation;
}

- (CAKeyframeAnimation  *) addAnimationVerticalMovement {
    CAKeyframeAnimation *translation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    CGFloat yValue = self.square.center.y;
    CGFloat amount = ((sqrtf(2) * self.side) - self.side)/2;
    translation.values = @[@(yValue), @(yValue - amount), @(yValue)];
    translation.keyTimes = @[@0.0, @0.5, @1.0];
    translation.duration = self.duration;
    translation.calculationMode = kCAAnimationCubic;
    translation.tensionValues = @[@(-self.tensionValue + 1),@(0.0),@(-self.tensionValue - 2)];
    
    return translation;
}

- (CAKeyframeAnimation *) addShadowAnimation {
    CAKeyframeAnimation *shadow = [CAKeyframeAnimation animationWithKeyPath:@"lineWidth"];
    shadow.values = @[@0.0, @2, @0.0];
    shadow.keyTimes = @[@0.0, @0.5, @1.0];
    shadow.duration = self.duration;
    shadow.calculationMode = kCAAnimationCubic;
    shadow.tensionValues = @[@(-self.tensionValue + 1),@(0.0),@(-self.tensionValue - 2)];

    return shadow;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self startAnimation];
}

#pragma mark - Custom setters

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:[UIColor clearColor]];
    self.loaderView.backgroundColor = backgroundColor;
    self.loaderView.layer.backgroundColor = backgroundColor.CGColor;
}

- (void)setLoaderAlpha:(CGFloat)loaderAlpha
{
    _loaderAlpha = loaderAlpha;
    self.loaderView.alpha = loaderAlpha;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.loaderView.layer.cornerRadius = cornerRadius;
}

- (void)setLoaderColor:(UIColor *)loaderColor
{
    _loaderColor = loaderColor;
    self.square.backgroundColor = loaderColor;
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
    }
    return _label;
}
@end
