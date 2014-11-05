PQFCustomLoaders
========
Current version: 0.0.1

Collection of highly customizable loaders for your iOS projects. Feel free to use them.

Demo App
--------
___

<img src="https://cloud.githubusercontent.com/assets/7887319/4922649/eb6aa62c-6513-11e4-96a6-b4768d670a29.gif" height="400px" />

Installation
--------
___

###CocoaPods

The easiest way to get started is to use [CocoaPods](http://cocoapods.org/). Just add the following line to your Podfile:

``` pod 'PQFCustomLoaders', '~> 0.0.1' ```

###Import the project
If you don't want to use (you should) ``CocoaPods``,  you can download this project, and add the files in the ``/PQFCustomLoaders`` folder to your existing project.

Quick Start
--------
___

####1. Import

The first thing is to import the main file. This file contain all the requiered imports that you are going to need (``PQFBarsInCircles.h PQFBouncingBalls.h PQFCirclesInTriangles.h``). If you are planning to use only one loader, you can import only the required one, it is up to you.

```
#import <PQFCustomLoaders/PQFCustomLoaders.h>
```

####2. Init a loader in a view
For example, if you are going to add the ``PQFBouncingBalls`` Loader, you have to initialize it like this.
I recommend you to make a property in order to have a pointer to the loader for when you want to remove it.

```
@interface ViewController ()
...

@property (nonatomic, strong) PQFBouncingBalls *bouncingBalls;

...
@end

@implementation ViewController
...

self.loader = [[PQFBouncingBalls alloc] initLoaderOnView:self.view];

...
@end
```
In this example I am adding the loader to the main view, but you can add it to any UIView (or subclass)

####3. Customize it a little bit
You can customize this loaders a lot, in the following section (``Loader Styles``) you can see all the custom properties that you can change.

```
self.loader.jumpAmount = 50;
self.loader.zoomAmount = 20;
self.loader.separation = 20;
```
__It is very important to change all the properties before showing it (Except for the label ones).__

####4. Show it!
When the loader is initialized, it is going to be added to the subviews of the view that you choose. But it is going to be with alpha 0.0 and with no animations activated (so no memory problems ;) ). 

```
[self.loader show];
```
When you use the ``show`` method, you are making it visible and activating the animations

####5. Hide it or Remove it
If you are planning to reuse it, just ``hide``it like this:

```
[self.loader hide]
```
Now you can change the properties that you want before reshowing it.
This method makes it invisible and stop all the animations.

If you are not going to use it anymore, just remove it

```
[self.loader remove]
```
This method is going to remove it from it superview.

____

#####Methods you can use:

```
- (instancetype)initLoaderOnView:(UIView *)view;

- (void)remove;
- (void)show;
- (void)hide;

```


Loader Styles
--------
___

###PQFBarsInCircles

<img src="https://cloud.githubusercontent.com/assets/7887319/4924136/6fa9da50-6520-11e4-87ca-c637e0d8908d.gif" height="120px" />

####__Properties:__
```
@property (nonatomic, strong) UIColor *loaderColor;
@property (nonatomic, strong) UIColor *backgroundColor; //TRANSPARENT BY DEFAULT
@property (nonatomic) CGFloat loaderAlpha;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) NSInteger numberOfBars;  //OF THE HOLE LOADER FRAME
@property (nonatomic) CGFloat barWidthMax;	
@property (nonatomic) CGFloat barHeightMax;
@property (nonatomic) CGFloat barWidthMin;
@property (nonatomic) CGFloat barHeightMin;
@property (nonatomic) CGFloat barsSpeed;		//IN SECONDS (LESS AMOUNT, MORE SPEED)
@property (nonatomic) CGFloat rotationSpeed;	//IN SECONDS (LESS AMOUNT, MORE SPEED)
@property (nonatomic, strong) UILabel *label;	//IF YOU DON'T WANT IT, JUST DON'T CHANGE IT AND IT IS NOT GOING TO APPEAR
```

###PQFBouncingBalls

<img src="https://cloud.githubusercontent.com/assets/7887319/4924135/6fa82a0c-6520-11e4-91fa-0fc000d5ecca.gif" height="120px" />

####__Properties:__
```
@property (nonatomic) CGFloat cornerRadius;		//OF THE HOLE LOADER FRAME
@property (nonatomic, strong) UIColor *backgroundColor; //TRANSPARENT BY DEFAULT
@property (nonatomic) CGFloat loaderAlpha;
@property (nonatomic, strong) UIColor *loaderColor;
@property (nonatomic) CGFloat diameter;			//OF THE BALLS
@property (nonatomic) CGFloat jumpAmount;		//X MOVEMENT
@property (nonatomic) CGFloat separation;		//BETWEEN THE BALLS
@property (nonatomic) CGFloat zoomAmount;		//SIZE = SIZE + ZOOMAMOUNT
@property (nonatomic) CGFloat duration;
@property (nonatomic, strong) UILabel *label;	//IF YOU DON'T WANT IT, JUST DON'T CHANGE IT AND IT IS NOT GOING TO APPEAR

```

###PQFCirclesInTriangle

<img src="https://cloud.githubusercontent.com/assets/7887319/4924134/6f6484fa-6520-11e4-9b7d-4b308ef5b53c.gif" height="120px" />

####__Properties:__
```
@property (nonatomic) NSUInteger numberOfCircles;	//YOU CAN ONLY CHOOSE 3 OR 6 AT THE MOMENT
@property (nonatomic, strong) UIColor *backgroundColor; //TRANSPARENT BY DEFAULT
@property (nonatomic) CGFloat cornerRadius;			//OF THE HOLE LOADER FRAME
@property (nonatomic) CGFloat loaderAlpha;
@property (nonatomic, strong) UIColor *loaderColor;
@property (nonatomic) CGFloat maxDiam;				//MAXIMUM DIAMETER OF ALL THE CIRCLES
@property (nonatomic) CGFloat separation; //DEFAULT VALUE = 8.0
@property (nonatomic) CGFloat borderWidth; //WIDTH OF THE CIRCLES
@property (nonatomic) CGFloat delay;		//ONLY IF YOU USE 6 CIRCLES, DELAY BETWEEN THE FIRST 3 CIRCLES AND THE OTHERS
@property (nonatomic) CGFloat duration;
@property (nonatomic, strong) UILabel *label;	//IF YOU DON'T WANT IT, JUST DON'T CHANGE IT AND IT IS NOT GOING TO APPEAR

```


Licenses
--------
___

All source code is licensed under the MIT License.![id](http://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/License_icon-mit-2.svg/256px-License_icon-mit-2.svg.png =40x)

If you use it, i'll be happy to know about it.

___

##__[Follow me on Twitter - poolqf](https://twitter.com/poolqf)__