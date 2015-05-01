ESBlur
========================

[![Build Status](https://api.travis-ci.org/ezescaruli/ESBlur.svg?branch=master)](https://travis-ci.org/ezescaruli/ESBlur)

`ESBlur` is a simple category to create a blurred view from any `UIView`. It is based on `UIImageEffects` class, and it is compatible with iOS 7 and later.


<img src="./Readme/Demo.gif" alt="Demo" width="300"/>


### Usage

Import `UIView+ESBlur.h` in the class where you want to apply the blur:
```objc
#import <ESBlur/UIView+ESBlur.h>
```

Blur can be applied to any `UIView` or subclass:
```objc
UIView *blurredView = [someView viewByApplyingBlur];
```

To use a custom tint color color instead of the default one, call:
```objc
UIColor *tintColor = [UIColor greenColor]; // Just any UIColor.
UIView *blurredView = [someView viewByApplyingBlurWithTintColor:tintColor];
```


### License

This library is available under the [MIT license](http://www.opensource.org/licenses/mit-license.php).
