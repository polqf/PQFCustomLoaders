//
//  ViewController.m
//  PQFCustomLoaders
//
//  Created by Pol Quintana on 28/10/14.
//  Copyright (c) 2014 Pol Quintana. All rights reserved.
//

#import "ViewController.h"
#import "PQFCustomLoaders.h"
#import <UIColor+FlatColors.h>

@interface ViewController ()

@property (nonatomic, strong) PQFBarsInCircle *loader;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor flatTurquoiseColor];
}

- (IBAction)showBarsInCircle:(id)sender {
    [self.loader remove];

    self.loader = [[PQFBarsInCircle alloc] initLoaderOnView:self.view];
    self.loader.label.text = self.textField.text;
    
    [self.loader show];
}

- (IBAction)showBouncingBalls:(id)sender {
    [self.loader remove];
    
}

- (IBAction)showCirclesInTriangles:(id)sender {
    [self.loader remove];

}

- (IBAction)removeLoader:(id)sender {
    [self.loader remove];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
