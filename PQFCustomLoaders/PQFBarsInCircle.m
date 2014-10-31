//
//  PQFBarsInCircle.m
//  randomAnimations
//
//  Created by Pol Quintana on 27/10/14.
//  Copyright (c) 2014 Pol Quintana. All rights reserved.
//

#import "PQFBarsInCircle.h"
#import <UIColor+FlatColors.h>

#define degreesToRadians(x) (M_PI * x /180.0)

@interface PQFBarsInCircle ()

@property (nonatomic, strong) NSArray *bars;
@property (nonatomic, strong) NSMutableArray *widthsArray;
@property (nonatomic, strong) NSMutableArray *heightArray;
@property (nonatomic) CGFloat angleInRad;
@property (nonatomic) CALayer *loaderLayer;
@property (nonatomic) BOOL animate;

@end

@implementation PQFBarsInCircle

- (instancetype)initLoaderOnView:(UIView *)view {
    CGRect frame = CGRectMake(0, 0, 200, 100);
    self = [super initWithFrame:frame];
    
    [self defaultValues];
    
    self.center = view.center;
    
    [view addSubview:self];
    [self setClipsToBounds:YES];
    
    return self;
}

- (void)defaultValues{
    self.numberOfBars = 40;
    self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
    self.loaderAlpha = 1.0;
    self.cornerRadius = 10;
    self.loaderColor = [UIColor flatCloudsColor];
    self.barHeightMin = 20;
    self.barHeightMax = 40;
    self.barWidthMin = 2;
    self.barWidthMax = 5;
    self.angleInRad = degreesToRadians(0);
    self.rotationSpeed = 6.0;
    self.barsSpeed = 0.5;
    
    if (self.frame.size.height < self.barHeightMax*2) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.x, self.frame.size.width, self.barHeightMax*2 + 10);
    }
    if (self.frame.size.width < self.barHeightMax*2) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.x, self.barHeightMax*2 + 10, self.frame.size.height);
    }
    
}

#pragma mark - public methods

- (void)show {
    self.alpha = 1.0;
    self.animate = YES;
    [self generateLoader];
    [self animateRotation];
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

#pragma mark - private methods

#pragma mark Custom Setters

- (void)setBackgroundAlpha:(CGFloat)backgroundAlpha {
    _backgroundAlpha = backgroundAlpha;
    self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:backgroundAlpha];
}

- (void)generateLoader {
    
    self.widthsArray = [[NSMutableArray alloc] initWithCapacity:self.numberOfBars];
    self.heightArray = [[NSMutableArray alloc] initWithCapacity:self.numberOfBars];
    
    self.layer.cornerRadius = self.cornerRadius;
    
    NSMutableArray *temp = [[NSMutableArray alloc] initWithCapacity:self.numberOfBars];
    self.loaderLayer = [CALayer layer];
    self.loaderLayer.bounds = self.bounds;
    self.loaderLayer.position = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    self.loaderLayer.opacity = self.loaderAlpha;
    
    [self.layer addSublayer:self.loaderLayer];
    
    for (int i = 0 ; i < self.numberOfBars ; i++) {
        CALayer *bar = [CALayer layer];
        bar.backgroundColor = self.loaderColor.CGColor;
        CGFloat randomWidth = 0;
        CGFloat randomHeight = 0;
        [self.heightArray addObject:[NSNumber numberWithFloat:randomHeight]];
        [self.widthsArray addObject:[NSNumber numberWithFloat:randomWidth]];
        bar.bounds = CGRectMake(0, 0, 0, 0);
        bar.anchorPoint = CGPointMake(0.5, 1.0);
        bar.position = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
        CGFloat angle = degreesToRadians(360/self.numberOfBars*(i+1));
        CATransform3D rotate = CATransform3DMakeRotation(angle, 0, 0, 1);
        bar.transform = rotate;
        [temp addObject:bar];
        [self.loaderLayer addSublayer:bar];
    }
    
    self.bars = [temp copy];
}

- (CGFloat)randomFloatBetween:(CGFloat)a and:(CGFloat)b {
    CGFloat random = ((CGFloat) rand()) / (CGFloat) RAND_MAX;
    CGFloat diff = b - a;
    CGFloat r = random * diff;
    return a + r;
}

- (void)startAnimation {
    if (self.animate) {
        for (int i = 0; i < self.numberOfBars; i++) {
            CALayer *bar = [self.bars objectAtIndex:i];
            [self animateBar:bar atIndex:i];
        }
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
    if (self.animate) {
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
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([@"anim1" isEqualToString:[anim valueForKey:@"animation"]]) {
        [self startAnimation];
    }
    if ([@"anim2" isEqualToString:[anim valueForKey:@"animation"]]) {
        [self animateRotation];
    }
}


@end
