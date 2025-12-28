
<img width="3312" height="400" alt="animated_border" src="https://github.com/user-attachments/assets/3ef4c4a3-3770-4397-b597-7d54a8fda1c3" />

[![pub package](https://img.shields.io/pub/v/zo_animated_border.svg)](https://pub.dev/packages/zo_animated_border)
[![pub points](https://img.shields.io/pub/points/zo_animated_border?color=2E8B57&label=pub%20points)](https://pub.dev/packages/zo_animated_border)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

**Zo Animated Border** is a powerful Flutter package that brings modern UI to life with beautifully animated **borders**. Whether you're building a login screen, a button, or a decorative container, this package lets you wrap any widget with stylish, animated **border** effects.

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
  animationCurve: Curves.linear,
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

For MultiColor Border

![multicolor](https://github.com/user-attachments/assets/cb66375f-f9a9-48cc-93fe-45d56854bbd6)

```dart
ZoMultiColorBorder(
  colors: [
    Colors.orange,
    Colors.white,
    Colors.green,
    Colors.indigo,
    Colors.pink,
  ],
  strokeWidth: 3,
  borderRadius: 75,
  child: Padding(
    padding: const EdgeInsets.all(3.0),
    child: Container(
      width: 150,
      height: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: Text(
        "MultiColor Border",
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    ),
  ),
)

```

For Circular Text Border

![circular_text](https://github.com/user-attachments/assets/58ce333c-cbb0-41b8-9709-a7ca61460876)

```dart
ZoCircularTextBorder(
  text: 'The Zerone',
  radius: 60,
  rotationDuration: const Duration(seconds: 12),
  textStyle: const TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
  ),
  child: Container(
    width: 100,
    height: 100,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.red,
    ),
  ),
),

```

For Scribble Border

![scribble_border](https://github.com/user-attachments/assets/36d0df7c-60f6-426f-87cc-4797d38b6742)

```dart
ZoScribbleBorder(
  borderColor: Colors.white,
  padding: const EdgeInsets.all(50),
  borderRadius: 100,
  child: ClipOval(
    child: Image.asset(
      'assets/pnglogo.png', // Replace with your asset
      width: 110,
      height: 110,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          const Icon(
            Icons.face,
            size: 80,
            color: Colors.orange,
          ),
    ),
  ),
),
```

For Ripple Border

![ripple](https://github.com/user-attachments/assets/cfbc07b8-ffdc-440e-8383-99177ae4f305)

```dart
ZoRippleEffect(
  rippleColor: Colors.cyanAccent,
  minCircleSize: 120,
  numberOfCircles: 4,
  animationDuration: const Duration(seconds: 4),
  child: const CircleAvatar(
    radius: 40,
    backgroundColor: Colors.cyanAccent,
    child: Icon(
      Icons.home,
      color: Colors.white,
      size: 30,
    ),
  ),
);

```

For Color Changing Border

![new_border](https://github.com/user-attachments/assets/4edf8b39-87b8-4ed8-a253-27cc35f44429)

```dart
ZoColorChangingBorder(
  borderRadius: 0,
  segmentLength: 0.2,
  colors: [
    Colors.orange,
    Colors.white,
    Colors.green,
  ],
  child: Padding(
    padding: const EdgeInsets.all(3.0),
    child: Container(
      width: 150,
      height: 150,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: const Text(
        "Color Changing Border",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
    ),
  ),
);

```

For Signal Border

![Simulator Screen Recording - iPhone 15 Pro - 2025-08-19 at 11 56 35 (online-video-cutter com)](https://github.com/user-attachments/assets/cdbd5676-34b2-4826-8e2b-e8d317e9c526)

```dart
ZoSignalBorder(
  maxRadius: 120,
  ringColors: [
    Colors.yellow,
    Colors.orange,
    Colors.red,
    Colors.purple,
    Colors.blue,
  ],
  child: Container(
    alignment: Alignment.center,
    width: 130,
    height: 130,
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
    ),
    child: const Text("Signal Border"),
  ),
);

```

For Dual border

![dual](https://github.com/user-attachments/assets/5d4123ec-bc72-47cd-825d-7de16f282e7e)

```dart
ZoDualBorder(
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

For GlowEdge Border

![glowEdge](https://github.com/user-attachments/assets/11950588-e76c-48ca-bbd7-5ca5ec988380)

```dart
ZoGlowingEdgeBorder(
  gradientColors: [
    Colors.orange,
    Colors.white,
    Colors.green,
  ],
  child: Padding(
    padding: const EdgeInsets.all(3.0),
    child: Container(
      width: 150,
      height: 150,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: const Text(
        "Glow Edge Border",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
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

Feel free to post a feature requests or report a bug [issues](https://github.com/Oauth-Celestial/zo_animated_border/issues).

## My Other packages

- [zo_micro_interactions](https://pub.dev/packages/zo_micro_interactions): A curated set of high-quality Flutter micro-interactions designed for modern, polished apps.
- [zo_screenshot](https://pub.dev/packages/zo_screenshot): The zo_screenshot plugin helps restrict screenshots and screen recording in Flutter apps, enhancing security and privacy by preventing unauthorized screen captures.
- [zo_collection_animation](https://pub.dev/packages/zo_collection_animation): A lightweight Flutter package to create smooth collect animations for coins carts
- [connectivity_watcher](https://pub.dev/packages/connectivity_watcher): A Flutter package to monitor internet connectivity with subsecond response times, even on mobile networks.
- [ultimate_extension](https://pub.dev/packages/ultimate_extension): Enhances Dart collections and objects with utilities for advanced data manipulation and simpler coding.
- [theme_manager_plus](https://pub.dev/packages/theme_manager_plus): Allows customization of your app's theme with your own theme class, eliminating the need for traditional
- [date_util_plus](https://pub.dev/packages/date_util_plus): A powerful Dart API designed to augment and simplify date and time handling in your Dart projects.
- [pick_color](https://pub.dev/packages/pick_color): A Flutter package that allows you to extract colors and hex codes from images with a simple touch.
