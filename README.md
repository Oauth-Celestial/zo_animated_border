# zo_animated_border

[![pub package](https://img.shields.io/pub/v/zo_animated_border.svg)](https://pub.dev/packages/zo_animated_border)
[![pub points](https://img.shields.io/pub/points/zo_animated_border?color=2E8B57&label=pub%20points)](https://pub.dev/packages/zo_animated_border)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)



A package that gives us a modern way to show gradient border and animate it

## Getting started

First, add zo_animated_border as a dependency in your pubspec.yaml file

```yaml
dependencies:
  flutter:
    sdk: flutter
  zo_animated_border : ^[version]
```

## Import the package

```dart
import 'package:zo_animated_border/zo_animated_border.dart';
```

# Usage
![gradient_border (online-video-cutter com)](https://github.com/user-attachments/assets/785905a3-8836-4529-8d0b-50f5afbda666)

```dart
ZoAnimatedGradientBorder(
    width: 200,
    height: 200,
    borderRadius: 100,
    borderThickness: 4,
    gradientColor: [Colors.yellow,Colors.orange],
    duration: Duration(seconds: 4),
    child: Container(
            alignment: Alignment.center,
            color: Colors.black,
            child: Text(
                    "Color",
                    style:TextStyle(color:Colors.black),
                  ),
               ),
            )
```

For MonoChrome border

![mono_chrome (online-video-cutter com)](https://github.com/user-attachments/assets/d798997d-a68c-447e-90e1-5e8fc8dd56bf)

```dart
ZoMonoCromeBorder(
  trackBorderColor: Colors.white,
  cornerRadius: 50.0,
  borderStyle: ZoMonoCromeBorderStyle.mirror,
  borderWidth: 5.5,
  child: Container(
          width: 100,
          height: 100,
          alignment: Alignment.center,
          child: Text("Mirror", 
          style:  TextStyle(color: Colors.white)),
          decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
           ),
        ),
      ),
```


For MonoChrome border

![pulse (online-video-cutter com)](https://github.com/user-attachments/assets/98c2d962-b38d-4d0c-8865-b3641db69e97)

```dart
ZoMonoCromeBorder(
  trackBorderColor: Colors.white,
  cornerRadius: 50.0,
  borderStyle: ZoMonoCromeBorderStyle.mirror,
  borderWidth: 5.5,
  child: Container(
          width: 100,
          height: 100,
          alignment: Alignment.center,
          child: Text("Mirror", 
          style:  TextStyle(color: Colors.white)),
          decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
           ),
        ),
      ),
```

Feel free to post a feature requests or report a bug [here](https://github.com/Oauth-Celestial/zo_animated_border/issues).
