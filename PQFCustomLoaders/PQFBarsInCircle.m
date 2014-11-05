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
@property (nonatomic) CGFloat fontSize;
@property (nonatomic) CALayer *loaderLayer;
@property (nonatomic) BOOL animate;
@property (nonatomic, strong) UIView *loaderView;

@end

@implementation PQFBarsInCircle

- (instancetype)initLoaderOnView:(UIView *)view {
    self = [super init];

    [self defaultValues];
    
    self.frame = CGRectMake(0, 0, view.frame.size.width, self.barHeightMax*2 + 20);
    self.center = view.center;    
    
    [self setClipsToBounds:YES];
    
    [view addSubview:self];
    
    //Loader View Initialization
    self.loaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.barHeightMax*2 + 10, self.barHeightMax*2 + 10)];
    self.loaderView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    [self addSubview:self.loaderView];
    
    return self;
}

- (void)defaultValues{
    self.numberOfBars = 35;
    self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.0];
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
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.barHeightMax*2 + 30, self.fontSize*2+10)];
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

- (void)generateLoader {
    
    self.widthsArray = [[NSMutableArray alloc] initWithCapacity:self.numberOfBars];
    self.heightArray = [[NSMutableArray alloc] initWithCapacity:self.numberOfBars];
    
    //GenerateFrames
    self.layer.cornerRadius = self.cornerRadius;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.barHeightMax*2 + 20);
    self.loaderView.frame = CGRectMake(self.loaderView.frame.origin.x, self.loaderView.frame.origin.y, self.loaderView.frame.size.width, self.barHeightMax*2 + 10);
    
    
    NSMutableArray *temp = [[NSMutableArray alloc] initWithCapacity:self.numberOfBars];
    self.loaderLayer = [CALayer layer];
    self.loaderLayer.position = CGPointMake(CGRectGetWidth(self.loaderView.frame)/2, CGRectGetHeight(self.loaderView.frame)/2);
    self.loaderLayer.opacity = self.loaderAlpha;
    
    //Loader View
    [self.loaderView.layer addSublayer:self.loaderLayer];
    
    for (int i = 0 ; i < self.numberOfBars ; i++) {
        CALayer *bar = [CALayer layer];
        bar.backgroundColor = self.loaderColor.CGColor;
        CGFloat randomWidth = 0;
        CGFloat randomHeight = 0;
        [self.heightArray addObject:[NSNumber numberWithFloat:randomHeight]];
        [self.widthsArray addObject:[NSNumber numberWithFloat:randomWidth]];
        bar.bounds = CGRectMake(0, 0, 0, 0);
        bar.anchorPoint = CGPointMake(0.5, 1.0);
        bar.position = CGPointMake(CGRectGetWidth(self.loaderLayer.frame)/2, CGRectGetHeight(self.loaderLayer.frame)/2);
        CGFloat angle = degreesToRadians(360/self.numberOfBars*(i+1));
        CATransform3D rotate = CATransform3DMakeRotation(angle, 0, 0, 1);
        bar.transform = rotate;
        [temp addObject:bar];
        [self.loaderLayer addSublayer:bar];
    }
    [self autolayoutByCode];
    
    self.bars = [temp copy];
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

        self.frame = CGRectMake(0, 0, self.frame.size.width, self.loaderView.frame.size.height + self.fontSize*2 + 10);
        self.center = CGPointMake(xCenter, yCenter);

        self.loaderView.frame = CGRectMake(self.loaderView.frame.origin.x, self.loaderView.frame.origin.y, self.loaderView.frame.size.width, self.loaderView.frame.size.height + self.fontSize*2);
        self.loaderView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
        
        CGFloat xPoint = CGRectGetWidth(self.loaderView.frame)/2;
        CGFloat yPoint = CGRectGetHeight(self.loaderView.frame)/2 + self.barHeightMax;
        
        self.label.center = CGPointMake(xPoint, yPoint);
        [self.loaderView addSubview:self.label];
    }

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
