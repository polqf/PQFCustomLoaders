//
//  PQFCustomLoaders.h
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 6/2/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PQFLoaderTypeBouncingBalls = 0,
    PQFLoaderTypeBarsInCircle = 1,
    PQFLoaderTypeCirclesInTriangle = 2,
    PQFLoaderTypeBallDrop = 3
} PQFLoaderType;

@interface PQFCustomLoaders : UIView

//Common Properties
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat alpha;
@property (nonatomic, strong) UIColor *color;


/**
 *  Shows a loader modally with a background alpha.
 *
 *  User interaction when the loader is showing is disabled by default
 *
 *  @param loaderType Choose the type of loader you want
 *
 *  @return Even that is not necessary to do anything more, it is important to have a reference to the loader to make the removal easier
 */
+ (id)showModalLoader:(PQFLoaderType)loaderType;

/**
 *  Shows a loader on the view that you choose. Be careful when adding to scrolling views, it is recommendet to add it modally on that case.
 *
 *  @param loaderType Choose the type of loader you want
 *
 *  @return Even that is not necessary to do anything more, it is important to have a reference to the loader to make the removal easier
 */
+ (id)showLoader:(PQFLoaderType)loaderType onView:(UIView *)view;

+ (id)createModalLoader:(PQFLoaderType)loaderType;
+ (id)createLoader:(PQFLoaderType)loaderType onView:(UIView *)view;

/**
 *  If for some reason yo do not have a reference to the loader, and you know where did you add it, you can use this method in order to remove from the
 *  subview of the UIView passed as parameter.
 *
 *  Try to avoid using this method, it is more expensive than having a reference to it an call the "removeLoader" method.
 *
 *  @param view View where you know that is you loader as a subview.
 */
+ (void)removeAllLoadersOnView:(UIView *)view;

- (void)showLoader;
- (void)hideLoader;
/**
 *  This method is going to remove the sender(loader) from its superview.
 */
- (void)removeLoader;

@end
