//
//  PQFLoader.h
//  PQFCustomLoadersDemo
//
//  Created by Pol Quintana on 6/3/15.
//  Copyright (c) 2015 Pol Quintana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PQFLoader : UIView

//Common Properties
@property (nonatomic, strong) UILabel *label;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat alpha;
@property (nonatomic, strong) UIColor *color;


/**
 *  Shows a loader modally with a background alpha.
 *
 *  User interaction when the loader is showing is disabled by default
 *
 *  @return Even that is not necessary to do anything more, it is important to have a reference to the loader to make the removal easier
 */
+ (instancetype)showModalLoader;

/**
 *  Shows a loader on the view that you choose. Be careful when adding to scrolling views, it is recommendet to add it modally on that case.
 *
 *  @return Even that is not necessary to do anything more, it is important to have a reference to the loader to make the removal easier
 */
+ (instancetype)showLoaderOnView:(UIView *)view;

/**
 *  Creates a loader modally with a background alpha.
 *
 *  User interaction when the loader is showing is disabled by default
 *
 *  @return Even that is not necessary to do anything more, it is important to have a reference to the loader to make the removal easier
 */
+ (instancetype)createModalLoader;

/**
 *  Creates a loader on the view that you choose. Be careful when adding to scrolling views, it is recommendet to add it modally on that case.
 *
 *  @return Even that is not necessary to do anything more, it is important to have a reference to the loader to make the removal easier
 */
+ (instancetype)createLoaderOnView:(UIView *)view;

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
- (void)removeLoader;

#pragma mark Deprecated methods

- (instancetype)initLoaderOnView:(UIView *)view __deprecated_msg("Use '+createLoader:onView:'");
- (void)remove __deprecated_msg("Use 'removeLoader'");
- (void)show __deprecated_msg("User 'showLoader'");
- (void)hide __deprecated_msg("Use 'removeLoader'");

@end
