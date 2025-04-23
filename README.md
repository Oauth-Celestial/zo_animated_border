# zo_animated_border

[![pub package](https://img.shields.io/pub/v/zo_animated_border.svg)](https://pub.dev/packages/zo_animated_border)
[![pub points](https://img.shields.io/pub/points/zo_animated_border?color=2E8B57&label=pub%20points)](https://pub.dev/packages/zo_animated_border)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

A package that provides a modern way to create gradient borders with animation in Flutter

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

For Gradient border

![gradient_border (online-video-cutter com)](https://github.com/user-attachments/assets/785905a3-8836-4529-8d0b-50f5afbda666)

```dart
ZoAnimatedGradientBorder(
  borderRadius: 100,
  borderThickness: 4,
  gradientColor: [
    Colors.yellow,
    Colors.orange,
  ],
  duration: Duration(seconds: 4),
  child: Container(
    width: 100,
    height: 100,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
    ),
    child: Text(
      "Circle",
      style: TextStyle(color: Colors.white),
    ),
  ),
);
```

For Dual border

![dual](https://github.com/user-attachments/assets/5d4123ec-bc72-47cd-825d-7de16f282e7e)

```dart
ZoDualBorder(
  duration: Duration(seconds: 3),
  glowOpacity: 0.4,
  firstBorderColor: Colors.yellow,
  secondBorderColor: Colors.orange,
  trackBorderColor: Colors.transparent,
  borderWidth: 8,
  borderRadius: BorderRadius.circular(10),
  child: Container(
    width: 150,
    height: 150,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      "Dual Border",
      style: TextStyle(
        color: Colors.black,
      ),
    ),
  ),
);

```

For Dotted border

![dotted](https://github.com/user-attachments/assets/c1027326-76e4-4f4b-b31d-21303fcb8055)

```dart
ZoDottedBorder(
  child: Container(
    height: 100,
    width: 100,
    color: Colors.red,
    alignment: Alignment.center,
    child: Text(
      "MonoChrome",
      style: TextStyle(fontSize: 14, color: Colors.white),
    ),
  ),
  animate: true,
  borderRadius: 10,
  dashLength: 10,
  gapLength: 5,
  strokeWidth: 3,
  color: Colors.blue,
  animationDuration: Duration(seconds: 4),
  borderStyle: BorderStyleType.monochrome,
);
```

For Breathing border

![breathing](https://github.com/user-attachments/assets/2aeb8693-8689-4a17-81b8-16d8aea74dae)

```dart
ZoBreathingBorder(
  borderWidth: 3.0,
  borderRadius: BorderRadius.circular(75),
  colors: [
    Colors.blue,
    Colors.purple,
    Colors.red,
    Colors.orange,
  ],
  duration: const Duration(seconds: 4),
  child: Container(
    width: 150,
    height: 150,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(75),
    ),
    alignment: Alignment.center,
    child: const Text(
      'Breathing Border',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
);
```

For Snake Border

![snake_border](https://github.com/user-attachments/assets/7e234c6a-dedc-44c7-a03f-0aa052e8a028)

```dart
ZoSnakeBorder(
  duration: 3,
  glowOpacity: 0,
  snakeHeadColor: Colors.red,
  snakeTailColor: Colors.blue,
  snakeTrackColor: Colors.blueGrey,
  borderWidth: 5,
  borderRadius: BorderRadius.circular(10),
  child: Container(
    width: 150,
    height: 45,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      "Snake Border",
      style: TextStyle(color: Colors.black),
    ),
  ),
);

```

For Pulsating border

![pulse (online-video-cutter com)](https://github.com/user-attachments/assets/98c2d962-b38d-4d0c-8865-b3641db69e97)

```dart
ZoPulsatingBorder(
  type: ZoPulsatingBorderType.pulse,
  borderRadius: BorderRadius.circular(100),
  pulseColor: Colors.blue,
  child: Container(
    alignment: Alignment.center,
    width: 100,
    height: 100,
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(50),
    ),
    child: Text(
      "Radar Pulse",
      style: TextStyle(color: Colors.white),
    ),
  ),
);
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
    decoration: BoxDecoration(
      color: Colors.red,
      shape: BoxShape.circle,
    ),
    child: Text(
      "Mirror",
      style: TextStyle(color: Colors.white),
    ),
  ),
);
```

Feel free to post a feature requests or report a bug [here](https://github.com/Oauth-Celestial/zo_animated_border/issues).

## My Other packages

- [zo_screenshot](https://pub.dev/packages/zo_screenshot): The zo_screenshot plugin helps restrict screenshots and screen recording in Flutter apps, enhancing security and privacy by preventing unauthorized screen captures.
- [connectivity_watcher](https://pub.dev/packages/connectivity_watcher): A Flutter package to monitor internet connectivity with subsecond response times, even on mobile networks.
- [ultimate_extension](https://pub.dev/packages/ultimate_extension): Enhances Dart collections and objects with utilities for advanced data manipulation and simpler coding.
- [theme_manager_plus](https://pub.dev/packages/theme_manager_plus): Allows customization of your app's theme with your own theme class, eliminating the need for traditional
- [date_util_plus](https://pub.dev/packages/date_util_plus): A powerful Dart API designed to augment and simplify date and time handling in your Dart projects.
- [pick_color](https://pub.dev/packages/pick_color): A Flutter package that allows you to extract colors and hex codes from images with a simple touch.
