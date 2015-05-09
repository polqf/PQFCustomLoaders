//
//  DataViewController.m
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 5/1/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import "DataViewController.h"

static const CGFloat kButtonCornerRadius = 4;
#define kButtonColor [UIColor colorWithWhite:0.2 alpha:0.5]

@interface DataViewController () {
    BOOL _showing;
    BOOL _showingModal;
    BOOL _showingText;
}
@property (weak, nonatomic) IBOutlet UIButton *presentModallyOutlet;
@property (weak, nonatomic) IBOutlet UIButton *showTextOutlet;
@property (nonatomic, strong) UIButton *modalButton;
@end

@implementation DataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.presentModallyOutlet.layer.cornerRadius = kButtonCornerRadius;
    self.presentModallyOutlet.layer.backgroundColor = kButtonColor.CGColor;
    self.showTextOutlet.layer.cornerRadius = kButtonCornerRadius;
    self.showTextOutlet.layer.backgroundColor = kButtonColor.CGColor;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.dataLabel.text = NSStringFromClass([self.loader class]);
    if (_showing) return;
    [self.loader showLoader];
    _showing = YES;
    _showingText = NO;
    [self.showTextOutlet setTitle:@"Show Text" forState:UIControlStateNormal];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.loader removeLoader];
    self.loader = nil;
    _showing = NO;
    _showingModal = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (!_showingModal) return;
    [self presentLoaderModally:self];
}


#pragma mark - User interaction

- (IBAction)presentLoaderModally:(id)sender
{
    if (!_showingModal) {
        [self.loader removeLoader];
        self.loader = [[self loaderClass] createModalLoader];
        [self.loader showLoader];
        [[[UIApplication sharedApplication].delegate window] addSubview:self.modalButton];
        _showingModal = YES;
    }
    else {
        [self.loader removeLoader];
        self.loader = nil;
        [self.modalButton removeFromSuperview];
        [self.loader showLoader];
        _showingModal = NO;
    }
}

- (IBAction)showText:(id)sender {
    NSString *title;
    [self.loader removeLoader];
    self.loader = nil;
    if (!_showingText) {
        title = @"Hide Text";
        [self.loader label].text = @"Your description here";
        [self.loader setBackgroundColor:[UIColor colorWithWhite:0.2 alpha:0.6]];
    }
    else {
        title = @"Show Text";
        [self.loader label].text = nil;
    }
    _showingText = !_showingText;
    [self.showTextOutlet setTitle:title forState:UIControlStateNormal];
    [self.loader showLoader];
}


#pragma mark - Helper

- (Class)loaderClass
{
    switch (self.pageIndex) {
        case 0:
            return [PQFBouncingBalls class];
            break;
        case 1:
            return [PQFBarsInCircle class];
            break;
        case 2:
            return [PQFCirclesInTriangle class];
            break;
        case 3:
            return [PQFBallDrop class];
            break;
            
        default:
            return nil;
            break;
    }
}


#pragma mark - Lazy

- (id)loader
{
    if (!_loader) {
        _loader = [[self loaderClass] createLoaderOnView:self.view];
    }
    return _loader;
}
- (UIButton *)modalButton
{
    if (!_modalButton) {
        _modalButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 180, 40)];
        _modalButton.layer.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1.0].CGColor;
        _modalButton.layer.cornerRadius = 4;
        [_modalButton setTitle:@"Hide Modal" forState:UIControlStateNormal];
        _modalButton.center = self.presentModallyOutlet.center;
        [_modalButton addTarget:self action:@selector(presentLoaderModally:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _modalButton;
}

@end
