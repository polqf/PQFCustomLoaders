//
//  PQFCirclesInTriangle.m
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 6/3/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import "PQFCirclesInTriangle.h"
#import <UIColor+FlatColors/UIColor+FlatColors.h>

@interface PQFCirclesInTriangle () <PQFLoaderProtocol>
@property (nonatomic, strong) UIView *loaderView;
@property (nonatomic, strong) CALayer *loaderLayer;
@property (nonatomic, strong) NSArray *circles;
@property (nonatomic, assign) BOOL animate;
@property (nonatomic) CGFloat rectSize;
@end

@implementation PQFCirclesInTriangle


#pragma mark - IB_DESIGNABLE

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialSetupWithView:nil];
    }
    return self;
}


#pragma mark - PQFLoader methods

+ (instancetype)showLoaderOnView:(UIView *)view
{
    PQFCirclesInTriangle *loader = [self createLoaderOnView:view];
    [loader showLoader];
    return loader;
}

+ (instancetype)createLoaderOnView:(UIView *)view
{
    if (!view) view = [[UIApplication sharedApplication].delegate window];
    PQFCirclesInTriangle *loader = [PQFCirclesInTriangle new];
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
    self.numberOfCircles = 6;
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
}


#pragma mark - Before showing


- (void)generateLoader
{
    self.loaderView.frame = CGRectMake(0, 0, self.frame.size.width, self.rectSize + 10);
    self.loaderView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    
    self.loaderLayer.frame = self.loaderView.bounds;
    self.loaderLayer.cornerRadius = self.cornerRadius;
    
    [self layoutCircles];
    
    if (self.label.text) [self layoutLabel];
}

- (void)layoutCircles
{
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i< self.numberOfCircles; i++) {
        CALayer *circle = [CALayer layer];
        circle.bounds = CGRectMake(0, 0, 0 , 0);
        circle.borderWidth = self.borderWidth;
        circle.borderColor = self.loaderColor.CGColor;
        if (i == 0 || i == 3) {
            circle.position = CGPointMake(CGRectGetWidth(self.loaderView.frame)/2, CGRectGetHeight(self.loaderView.frame)/2 -self.separation);
        }
        if (i == 1 || i == 4) {
            circle.position = CGPointMake(CGRectGetWidth(self.loaderView.frame)/2 - self.separation, CGRectGetHeight(self.loaderView.frame)/2 + self.separation);
        }
        if (i == 2 || i == 5) {
            circle.position = CGPointMake(CGRectGetWidth(self.loaderView.frame)/2 + self.separation, CGRectGetHeight(self.loaderView.frame)/2 + self.separation);
        }
        if (self.label.text) { circle.position = CGPointMake(circle.position.x, circle.position.y + 10); }
        [temp addObject:circle];
        [self.loaderLayer addSublayer:circle];
    }
    self.circles = temp;
}

- (void)layoutLabel
{
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.numberOfLines = 3;
    self.label.textColor = [UIColor whiteColor];
    self.label.font = [UIFont systemFontOfSize:self.fontSize];
    
    CGFloat xCenter = self.center.x;
    CGFloat yCenter = self.center.y;
    
    self.loaderView.frame = CGRectMake(self.loaderView.frame.origin.x, self.loaderView.frame.origin.y, self.loaderView.frame.size.width, self.loaderView.frame.size.height + 10 + self.fontSize*2+10 );
    
    self.frame = CGRectMake(0, 0, self.frame.size.width, self.loaderView.frame.size.height + 10 );
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
    [self firstAnimation];
    if (self.numberOfCircles <= 3) return;
    [self performSelector:@selector(secondAnimation) withObject:nil afterDelay:self.delay];
}

- (void)firstAnimation {
    if (!self.animate) return;
    int limit = (self.numberOfCircles < 4) ? self.numberOfCircles : 3;
    for (int i = 0; i < limit; i++) {
        [self animateCircle:[self.circles objectAtIndex:i] atIndex:i];
    }
}

- (void)secondAnimation {
    if (!self.animate) return;
    for (int i = 3; i<self.numberOfCircles; i++) {
        [self animateCircle:[self.circles objectAtIndex:i] atIndex:i];
    }
}

- (void)animateCircle:(CALayer *)circle atIndex:(int)index {
    CGPoint point;
    
    if (index == 0 || index == 3) {
        point = CGPointMake(circle.position.x, circle.position.y + self.separation);
    }
    if (index == 1 || index == 4) {
        point = CGPointMake(circle.position.x + self.separation, circle.position.y - self.separation);
    }
    if (index == 2 || index == 5) {
        point = CGPointMake(circle.position.x - self.separation, circle.position.y - self.separation);
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
    position.values = @[[NSValue valueWithCGPoint:circle.position],
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
    
    [circle addAnimation:bounds1 forKey:@"bounds1"];
    [circle addAnimation:radius forKey:@"radius"];
    [circle addAnimation:position forKey:@"position"];
    
    [circle addAnimation:miniBounds forKey:@"boundsFinal"];
    [circle addAnimation:radius2 forKey:@"radius2"];
    [circle addAnimation:position2 forKey:@"position2"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.animate) [self startAnimating];
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
    [self performSelector:@selector(changeCirclesColor:) withObject:loaderColor afterDelay:0];
}

- (void)changeCirclesColor:(UIColor *)loaderColor
{
    CGColorRef color = loaderColor.CGColor;
    for (CALayer *layer in self.circles) {
        layer.borderColor = color;
    }
}


#pragma mark - Lazy inits

- (UIView *)loaderView
{
    if (!_loaderView) {
        _loaderView = [UIView new];
        [self addSubview:_loaderView];
    }
    return _loaderView;
}

- (CALayer *)loaderLayer
{
    if (!_loaderLayer) {
        _loaderLayer = [CALayer layer];
        [self.loaderView.layer addSublayer:_loaderLayer];
    }
    return _loaderLayer;
}

- (NSArray *)circles
{
    if (!_circles) _circles = [NSArray new];
    return _circles;
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
    return [PQFCirclesInTriangle createLoaderOnView:view];
}


#pragma mark - Draw rect for IB_DESIGNABLE

- (void)drawRect:(CGRect)rect {
#if TARGET_INTERFACE_BUILDER
    self.loaderView.frame = CGRectMake(0, 0, self.frame.size.width, self.separation*2 + self.maxDiam + 10);
    self.loaderView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    self.hidden = NO;
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i< self.numberOfCircles; i++) {
        CALayer *circle = [CALayer layer];
        if (i == 0 || i == 3) {
            circle.bounds = CGRectMake(0, 0, self.maxDiam, self.maxDiam);
        }
        if (i == 1 || i == 4) {
            circle.bounds = CGRectMake(0, 0, self.maxDiam - self.maxDiam/4, self.maxDiam - self.maxDiam/4);
        }
        if (i == 2 || i == 5) {
            circle.bounds = CGRectMake(0, 0, self.maxDiam - self.maxDiam/2, self.maxDiam - self.maxDiam/2);
        }
        circle.cornerRadius = circle.frame.size.height/2;
        circle.borderWidth = self.borderWidth;
        circle.borderColor = self.loaderColor.CGColor;
        circle.position = CGPointMake(CGRectGetWidth(self.loaderView.frame)/2, CGRectGetHeight(self.loaderView.frame)/2);
        [temp addObject:circle];
        [self.loaderLayer addSublayer:circle];
    }
    self.circles = temp;
#endif
}

@end
