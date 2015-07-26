//
//  VBFRotatingSquare.h
//  VBFFlatLoaders
//
//  Created by Victor Baro on 19/09/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PQFLoader.h"

@interface VBFRotatingSquare : PQFLoader
/** Text label of the Loader. Hidden if text is nil */
@property (nonatomic, strong) IBInspectable UILabel *label;
/** Corner radius of the Loader background */
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
/** Color of the Loader */
@property (nonatomic, strong) IBInspectable UIColor *loaderColor;
/** Color of the Border of the square Loader */
@property (nonatomic, strong) IBInspectable UIColor *borderColor;
/** Alpha of the loader */
@property (nonatomic, assign) IBInspectable CGFloat loaderAlpha;
/** Diameter of the bouncing balls */
@property (nonatomic, assign) IBInspectable CGFloat side;
/** Duration of a single step */
@property (nonatomic, assign) IBInspectable CGFloat duration;
/** Size of the label text */
@property (nonatomic, assign) IBInspectable CGFloat fontSize;
/** Alpha of the hole view */
@property (nonatomic, assign) IBInspectable CGFloat alpha;
/** Modify animation behaviour. Default = 1 */
@property (nonatomic, assign) CGFloat tensionValue;
@end
