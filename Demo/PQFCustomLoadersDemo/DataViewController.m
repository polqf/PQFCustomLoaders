//
//  DataViewController.m
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 5/1/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController () {
    BOOL _showing;
    BOOL _showingModal;
}
@property (weak, nonatomic) IBOutlet UIButton *presentModallyOutlet;
@property (nonatomic, strong) UIButton *modalButton;

@end

@implementation DataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.presentModallyOutlet.layer.cornerRadius = 4;
    self.presentModallyOutlet.layer.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.9].CGColor;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.dataLabel.text = NSStringFromClass([self.loader class]);
    if (_showing) return;
    [self.loader showLoader];
    _showing = YES;
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
        self.loader = [PQFLoader createModalLoader:(int)self.pageIndex];
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


#pragma mark - Lazy

- (PQFLoader *)loader
{
    if (!_loader) {
        _loader = [PQFLoader createLoader:(int)self.pageIndex onView:self.view];
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
