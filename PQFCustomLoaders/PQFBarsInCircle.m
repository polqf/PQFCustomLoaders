//
//  PQFBarsInCircle.m
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 6/3/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import "PQFBarsInCircle.h"
#import <UIColor+FlatColors/UIColor+FlatColors.h>

#define degreesToRadians(x) (M_PI * x /180.0)

@interface PQFBarsInCircle () <PQFLoaderProtocol>
@property (nonatomic, strong) UIView *loaderView;
@property (nonatomic, strong) CALayer *loaderLayer;

@property (nonatomic, strong) NSArray *bars;
@property (nonatomic, strong) NSMutableArray *widthsArray;
@property (nonatomic, strong) NSMutableArray *heightArray;
@property (nonatomic, assign) BOOL animate;
@property (nonatomic) CGFloat angleInRad;
@end

@implementation PQFBarsInCircle


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
    PQFBarsInCircle *loader = [self createLoaderOnView:view];
    [loader showLoader];
    return loader;
}

+ (instancetype)createLoaderOnView:(UIView *)view
{
    if (!view) view = [[UIApplication sharedApplication].delegate window];
    PQFBarsInCircle *loader = [PQFBarsInCircle new];
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
    self.numberOfBars = 35;
    self.loaderAlpha = 1.0;
    self.cornerRadius = 0;
    self.loaderColor = [UIColor flatCloudsColor];
    self.barHeightMin = 20;
    self.barHeightMax = 32;
    self.barWidthMin = 2;
    self.barWidthMax = 4;
    self.angleInRad = degreesToRadians(0);
    self.rotationSpeed = 6.0;
    self.barsSpeed = 0.5;
    self.fontSize = 14.0;
}


#pragma mark - Before showing


- (void)generateLoader
{
    self.loaderView.frame = CGRectMake(0, 0, self.frame.size.width, self.barHeightMax*2 + 10);
    self.loaderView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    self.loaderLayer.frame = self.loaderView.bounds;
    self.loaderLayer.cornerRadius = self.cornerRadius;
    
    [self layoutBars];
    
    if (self.label.text) [self layoutLabel];
}

- (void)layoutBars
{
    NSMutableArray *temp = [NSMutableArray new];
    for (int i = 0 ; i < self.numberOfBars ; i++) {
        CALayer *bar = [CALayer layer];
        bar.backgroundColor = self.loaderColor.CGColor;
        [self.heightArray addObject:[NSNumber numberWithFloat:0]];
        [self.widthsArray addObject:[NSNumber numberWithFloat:0]];
        bar.bounds = CGRectMake(0, 0, 0, 0);
        bar.anchorPoint = CGPointMake(0.5, 1.0);
        bar.position = CGPointMake(CGRectGetWidth(self.loaderView.frame)/2, CGRectGetHeight(self.loaderView.frame)/2);
        if (self.label.text) {
            bar.position = CGPointMake(bar.position.x, bar.position.y + 10);
        }
        CGFloat angle = degreesToRadians(360/self.numberOfBars*(i+1));
        CATransform3D rotate = CATransform3DMakeRotation(angle, 0, 0, 1);
        bar.transform = rotate;
        [temp addObject:bar];
        [self.loaderLayer addSublayer:bar];
    }
    self.bars = [temp copy];
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
    [self animateRotation];
    [self animateBars];
}

- (void)animateBars
{
    for (int i = 0; i < self.numberOfBars; i++) {
        CALayer *bar = [self.bars objectAtIndex:i];
        [self animateBar:bar atIndex:i];
    }
}

- (void)animateBar:(CALayer *)bar atIndex:(NSInteger)index {
    
    NSNumber *widthInArray = [self.widthsArray objectAtIndex:index];
    CGFloat width = [widthInArray floatValue];
    CGFloat width2 = [self randomFloatBetween:self.barWidthMin and:self.barWidthMax];
    [self.widthsArray replaceObjectAtIndex:index withObject:[NSNumber numberWithFloat:width2]];
    
    NSNumber *heightInArray = [self.heightArray objectAtIndex:index];
    CGFloat height = [heightInArray floatValue];
    CGFloat height2 = [self randomFloatBetween:self.barHeightMin and:self.barHeightMax];
    [self.heightArray replaceObjectAtIndex:index withObject:[NSNumber numberWithFloat:height2]];
    
    CAKeyframeAnimation *heightMoving = [CAKeyframeAnimation animationWithKeyPath:@"bounds.size"];
    heightMoving.duration = self.barsSpeed;
    heightMoving.values = @[[NSValue valueWithCGSize:CGSizeMake(width, height)],
                            [NSValue valueWithCGSize:CGSizeMake(width2, height2)]];
    heightMoving.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    heightMoving.fillMode = kCAFillModeForwards;
    heightMoving.removedOnCompletion = NO;
    
    if (index == self.numberOfBars -1) {
        heightMoving.delegate = self;
        [heightMoving setValue:@"anim1" forKey:@"animation"];
    }
    
    [bar addAnimation:heightMoving forKey:@"height"];
}

- (void)animateRotation {
    if (!self.animate) return;
    CAKeyframeAnimation *rotate = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotate.duration = self.rotationSpeed;
    rotate.additive = YES;
    rotate.values = @[[NSNumber numberWithFloat:self.angleInRad], [NSNumber numberWithFloat:(self.angleInRad + M_PI_4)]];
    rotate.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    rotate.delegate = self;
    rotate.fillMode = kCAFillModeForwards;
    rotate.removedOnCompletion = NO;
    
    [rotate setValue:@"anim2" forKey:@"animation"];
    
    self.angleInRad = self.angleInRad + M_PI_4;
    [self.loaderLayer addAnimation:rotate forKey:@"rotation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (!self.animate) return;
    if ([@"anim1" isEqualToString:[anim valueForKey:@"animation"]]) {
        [self animateBars];
    }
    if ([@"anim2" isEqualToString:[anim valueForKey:@"animation"]]) {
        [self animateRotation];
    }
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
    [self performSelector:@selector(changeBarsColor:) withObject:loaderColor afterDelay:0];
}

- (void)changeBarsColor:(UIColor *)loaderColor
{
    CGColorRef color = loaderColor.CGColor;
    for (CALayer *layer in self.bars) {
        layer.backgroundColor = color;
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

- (NSMutableArray *)widthsArray
{
    if (!_widthsArray) _widthsArray = [NSMutableArray new];
    return _widthsArray;
}

- (NSMutableArray *)heightArray
{
    if (!_heightArray) _heightArray = [NSMutableArray new];
    return _heightArray;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [UILabel new];
    }
    return _label;
}


#pragma mark - Helper

- (CGFloat)randomFloatBetween:(CGFloat)a and:(CGFloat)b {
    CGFloat random = ((CGFloat) rand()) / (CGFloat) RAND_MAX;
    CGFloat diff = b - a;
    CGFloat r = random * diff;
    return a + r;
}


#pragma mark - Deprecated methods

- (instancetype)initLoaderOnView:(UIView *)view
{
    return [PQFBarsInCircle createLoaderOnView:view];
}


#pragma mark - Draw rect for IB_DESIGNABLE

- (void)drawRect:(CGRect)rect {
#if TARGET_INTERFACE_BUILDER
    self.loaderView.frame = CGRectMake(0, 0, self.frame.size.width, self.barHeightMax*2 + 10);
    self.loaderView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    self.hidden = NO;

    NSMutableArray *temp = [NSMutableArray new];
    for (int i = 0 ; i < self.numberOfBars ; i++) {
        CALayer *bar = [CALayer layer];
        bar.backgroundColor = self.loaderColor.CGColor;
        bar.bounds = CGRectMake(0, 0, [self randomFloatBetween:self.barWidthMin and:self.barWidthMax], [self randomFloatBetween:self.barHeightMin and:self.barHeightMax]);
        bar.anchorPoint = CGPointMake(0.5, 1.0);
        bar.position = CGPointMake(CGRectGetWidth(self.loaderView.frame)/2, CGRectGetHeight(self.loaderView.frame)/2);
        if (self.label.text) {
            bar.position = CGPointMake(bar.position.x, bar.position.y + 10);
        }
        CGFloat angle = degreesToRadians(360/self.numberOfBars*(i+1));
        CATransform3D rotate = CATransform3DMakeRotation(angle, 0, 0, 1);
        bar.transform = rotate;
        [temp addObject:bar];
        [self.loaderLayer addSublayer:bar];
    }
    self.bars = [temp copy];
#endif
}

@end
