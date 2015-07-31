#PQFCustomLoaders 1.1.0

####Collection of highly customizable loaders for your iOS projects.

<p align="center">
<img src="Images/bouncing.gif" height="120px"/>
</p>

<p align="center">
PQFBouncingBalls
</p>

<p align="center">
<img src="Images/bars.gif" height="120px"/>
</p>

<p align="center">
PQFBarsInCircles
</p>

<p align="center">
<img src="Images/circles.gif" height="120px"/>
</p>

<p align="center">
PQFCirclesInTriangle
</p>

<p align="center">
<img src="Images/drop.gif" height="120px"/>
</p>

<p align="center">
PQFBallDrop
</p>

###Changelog
* __1.1.0__ (24 May 2015)
	- __IB Designable properties__- Thanks __[@dfreniche](https://github.com/dfreniche)__!
	- New __Inspectable Demo__ with IBDesignable properties examples (See Interface Builder section)
	- Improvements
* __1.0.1__ (9 May 2015)
	- __New Modal presentation__	
	- __New Loader__(PQFBallDrop)
	- New demo
	- New methods to create the loaders
	- All the properties are now with description
			<img src="Images/properties.png" height="60px" />
	- Fixed layout problems in some rare cases
	- Improvements
* __0.0.1__ Initial version


Demo Apps
--------

<p align="center">
PQFCustomLoaders Demo:
</p>

<p align="center">
<img src="Images/demo.png" height="400px"/>
</p>

<p align="center">
Inspectable Demo:
</p>

<p align="center">
<img src="Images/InspectableDemo.png" height="400px"/>
</p>

Installation
--------
___

###CocoaPods

The easiest way to get started is to use [CocoaPods](http://cocoapods.org/). Just add the following line to your Podfile:

``` pod 'PQFCustomLoaders', '~> 1.1.0' ```

###Import the project
If you don't want to use (you should) ``CocoaPods``,  you can download this project, and add the files in the ``/PQFCustomLoaders`` folder to your existing project.

Quick Start
--------
___

####1. Import

The first thing is to import the main file. This file contain all the requiered imports that you are going to need. If you are planning to use only one loader, you can import only the required one, it is up to you.

```
#import <PQFCustomLoaders/PQFCustomLoaders.h>
```

####2. Create a loader:

For example, if you are going to add the ``PQFBouncingBalls`` Loader, you have to initialize it like this.
I recommend you to make a property in order to have a pointer to the loader for when you want to remove it.

```
@interface MyClass ()
...

@property (nonatomic, strong) PQFBouncingBalls *bouncingBalls;

...
@end
```
#####2.	1 In a view

```
@implementation MyClass
...

self.loader = [PQFBouncingBalls createLoaderOnView:self.view];

...
@end
```
In this example I am adding the loader to the main view, but you can add it to any UIView (or subclass)

#####2.	2 As a modal

```
@implementation MyClass
...

self.loader = [PQFBouncingBalls createModalLoader];

...
@end
```

####3. Customize it
You can customize this loaders a lot, in the following section (``Loader Styles``) you can see all the custom properties that you can change.

```
self.loader.jumpAmount = 50;
self.loader.zoomAmount = 20;
self.loader.separation = 20;
```
__The only properties that can be changes once the loader is on screen are:__ 

* cornerRadius
* loaderColor
* loaderAlpha
* backgroundColor

But it is __highly recommended__ to change them before showing


####4. Show it!
When the loader is initialized, it is going to be added to the subviews of the view that you choose. But it is going to be with alpha 0.0 and with no animations activated (so no memory problems ;) ). 

```
[self.loader showLoader];
```
When you use the ``show`` method, you are making it visible and activating the animations

####5. Remove it
If you are not going to use it anymore, just remove it

```
[self.loader removeLoader]
```
This method is going to remove it from it superview.


###Methods you can use:

```
+ (instancetype)showModalLoader;
+ (instancetype)showLoaderOnView:(UIView *)view;
+ (instancetype)createModalLoader;
+ (instancetype)createLoaderOnView:(UIView *)view;
+ (void)removeAllLoadersOnView:(UIView *)view;

- (void)showLoader;
- (void)removeLoader;

DEPRECATED METHODS:

- (instancetype)initLoaderOnView:(UIView *)view  ("Use '+createLoader:onView:'");
- (void)remove 	                                 ("Use 'removeLoader'");
- (void)show                                     ("Use 'showLoader'");
- (void)hide                                     ("Use 'removeLoader'");


```


Loader Styles
--------

###PQFBouncingBalls

<img src="Images/bouncing.gif" height="120px" />

####__Properties:__ 
__Text label of the Loader (Hidden if text is nil):__ label;

__Corner radius of the Loader background:__ cornerRadius;

__Color of the Loader:__ loaderColor;

__Alpha of the loader:__ loaderAlpha;

__Diameter of the bouncing balls:__ diameter;

__Movement amount on the X axis:__ jumpAmount;

__Separation between the bouncing balls:__ separation;

__Ball added size when jumping:__ zoomAmount;

__Duration of each animation:__ duration;

__Size of the label text:__ fontSize;

__Alpha of the hole view:__ alpha;


###PQFBarsInCircles

<img src="Images/bars.gif" height="120px" />

####__Properties:__ 
__Text label of the Loader (Hidden if text is nil):__ label;

__Corner radius of the Loader background:__ cornerRadius;

__Color of the Loader:__ loaderColor;

__Alpha of the loader:__ loaderAlpha;

__Duration of each animation:__ duration;

__Size of the label text:__ fontSize;

__Number of rotating bars:__ numberOfBars;

__Minimum height of the bars:__ barHeightMin;

__Maximum height of the bars:__ barHeightMax;

__Minimum width of the bars:__ barWidthMin;

__Maximum width of the bars:__ barWidthMax;

__Rotation speed in seconds (Less amount, more speed):__ rotationSpeed;

__Bar size speed in seconds (Less amount, more speed):__ barsSpeed;

__Alpha of the hole view:__ alpha;

###PQFCirclesInTriangle

<img src="Images/circles.gif" height="120px" />

####__Properties:__ 
__Text label of the Loader (Hidden if text is nil):__ label;

__Corner radius of the Loader background:__ cornerRadius;

__Color of the Loader:__ loaderColor;

__Alpha of the loader:__ loaderAlpha;

__Duration of each animation:__ duration;

__Size of the label text:__ fontSize;

__Number of circles to animate. 3 or 6 are the recommended values:__ numberOfCircles;

__Maximum diameter of the circles:__ maxDiam;

__Separation between the circles:__ separation;

__Border width of the circles:__ borderWidth;

__Delay between the animations:__ delay;

__Alpha of the hole view:__ alpha;

###PQFBallDrop

<img src="Images/drop.gif" height="120px" />

####__Properties:__ 
__Text label of the Loader (Hidden if text is nil):__ label;

__Corner radius of the Loader background:__ cornerRadius;

__Color of the Loader:__ loaderColor;

__Alpha of the loader:__ loaderAlpha;

__Duration of each animation:__ duration;

__Size of the label text:__ fontSize;

__Maximum diameter of the circles:__ maxDiam;

__Delay between the animations:__ delay;

__Ball added size when droping:__ amountZoom;

__Alpha of the hole view:__ alpha;

Interface builder
-------

PQFCustomLoaders is `Interface Builder` friendly, you can easily customize any loader within the `Storyboard`

<img src="Images/IBDesignable.png" height="400px" />




Licenses
--------

All source code is licensed under the MIT License.

If you use it, i'll be happy to know about it.


###Pol Quintana - [@poolqf](https://twitter.com/poolqf)
