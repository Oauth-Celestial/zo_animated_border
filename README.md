[![pub package](https://img.shields.io/pub/v/zo_animated_border.svg)](https://pub.dev/packages/zo_animated_border)
[![pub points](https://img.shields.io/pub/points/zo_animated_border?color=2E8B57&label=pub%20points)](https://pub.dev/packages/zo_animated_border)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

# zo_animated_border

![SimulatorScreenRecording-iPhone15-2024-08-24at22 13 17-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/b662b146-addf-46f0-b003-4a51249e7193)

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

Feel free to post a feature requests or report a bug [here](https://github.com/Oauth-Celestial/zo_animated_border/issues).
