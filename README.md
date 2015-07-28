# NPLumen

[![Version](https://img.shields.io/cocoapods/v/NPLumen.svg?style=flat)](http://cocoapods.org/pods/NPLumen)
[![License](https://img.shields.io/cocoapods/l/NPLumen.svg?style=flat)](http://cocoapods.org/pods/NPLumen)
[![Platform](https://img.shields.io/cocoapods/p/NPLumen.svg?style=flat)](http://cocoapods.org/pods/NPLumen)

## About

Lumen is an iOS library for managing sources of light and objects that interact with them.

![GitHub Logo](/demo_shadow.gif)
![GitHub Logo](/demo_debug.gif)

## Example Usage

```objc
  // Create a delegate
  self.lumenGroupDebugger = [[NPLumenGroupDebugger alloc] init];

  // Create a lumen group
  self.lumenGroup = [[NPLumenGroup alloc] init];
  self.lumenGroup.delegate = self.lumenGroupShadowCaster;
  
  // Add some light sources and views
  [self.lumenGroup addSourceView:self.mySourceView];
  [self.lumenGroup addViews:[self.view1, self.view2]];
```

## Overview

The key class in Lumen is `NPLumenGroup`. A lumen group contains light sources and objects (each of which must be UIView objects). The lumen group's job is to calculate light ray vectors for each object based on the light sources. Each object gets assigned an appropriate light vector. When a vector is updated the lumen group tells its delegate.

## Delegation

Any class that conforms to the `NPLumenGroupDelegate` protocol can act as the lumen group's delegate. Here you have the opportunity to customize the behavior for each light vector applied to each view in a group.

For convenience (and demonstration purposes) I've included two delegates in this project: `NPLumenGroupDebugger` and `NPLumenGroupShadowCaster`. As their names suggest, the debugger overlays a line to indicate the vectors and the shadow caster adds a shadow to the view with the offset in the direction of the light vector. You can see an example of both of these in the animated gifs above.

To create your own delegate simply create a class and implement this method:

```objc
- (void)lumenGroup:(NPLumenGroup *)lumenGroup didUpdateLightVector:(CGPoint)lightVector forView:(UIView *)view {
  // Do something with the given view and vector (vectors are normalized).
}
```

## Requirements

Lumen requires iOS 8.0 and above.

## Installation

NPLumen is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "NPLumen"
```

## Author

Nebojsa Petrovic, nebspetrovic@gmail.com

## License

NPLumen is available under the MIT license. See the LICENSE file for more info.
