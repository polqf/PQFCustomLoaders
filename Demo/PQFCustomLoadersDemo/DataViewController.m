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
}
@property (weak, nonatomic) IBOutlet UIButton *presentModallyOutlet;
@property (nonatomic, strong) id modalLoader;
@property (nonatomic, strong) UIButton *modalButton;

@end

@implementation DataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.presentModallyOutlet.layer.cornerRadius = 4;
    self.presentModallyOutlet.layer.borderColor = [UIColor whiteColor].CGColor;
    self.presentModallyOutlet.layer.borderWidth = .5;
    self.presentModallyOutlet.layer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.1].CGColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.dataLabel.text = NSStringFromClass([self.loader class]);
    
    if (_showing) return;
    
    [self showLoader];
    _showing = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.loader remove];
    _showing = NO;
}

- (void)showLoader
{
    self.loader = [[[self.loader class] alloc] initLoaderOnView:self.view];
    [self.loader show];
}


#pragma mark - User interaction

- (IBAction)presentLoaderModally:(id)sender
{
    if ([self.loader respondsToSelector:@selector(initLoader)]) {
        [self.loader remove];
        self.modalLoader = [[[self.loader class] alloc] initLoader];
        [self.modalLoader show];
        
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        
        [window addSubview:self.modalButton];
    }
}

- (void)hideModal
{
    [self showLoader];
    [self.modalLoader remove];
    [self.modalButton removeFromSuperview];
}


#pragma mark - Lazy

- (UIButton *)modalButton
{
    if (!_modalButton) {
        _modalButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 180, 40)];
        _modalButton.layer.backgroundColor = [UIColor redColor].CGColor;
        _modalButton.layer.cornerRadius = 4;
        [_modalButton setTitle:@"Hide Modal" forState:UIControlStateNormal];
        _modalButton.center = self.presentModallyOutlet.center;
        [_modalButton addTarget:self action:@selector(hideModal) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _modalButton;
}

@end
