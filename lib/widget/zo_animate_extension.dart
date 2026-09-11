import 'package:flutter/material.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

/// Fluent extension to easily apply animated borders to any Flutter [Widget].
extension ZoAnimatedBorderWidgetExtension on Widget {
  /// Entry point for fluent animated border chaining:
  /// ```dart
  /// Container(
  ///   decoration: BoxDecoration(
  ///     borderRadius: BorderRadius.circular(16),
  ///     color: Colors.blue,
  ///   ),
  ///   child: Text("Hello"),
  /// ).zoAnimate().snake(
  ///   snakeHeadColor: Colors.amber,
  ///   borderWidth: 3,
  /// );
  /// ```
  ZoAnimate zoAnimate({Key? key}) => ZoAnimate(key: key, child: this);

  /// Directly wraps the widget in a configurable [ZoAnimatedBorder].
  Widget zoAnimatedBorder({
    Key? key,
    ZoBorderType type = ZoBorderType.snake,
    Duration? duration,
    double borderWidth = 3.0,
    BorderRadius? borderRadius,
    List<Color>? colors,
    double glowOpacity = 0.6,
    double glowSpread = 6.0,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    Curve animationCurve = Curves.linear,
    String text = "ZO ANIMATED BORDER • ",
    TextStyle textStyle = const TextStyle(color: Colors.white, fontSize: 12),
    Color trackColor = const Color(0xFF334155),
  }) {
    return ZoAnimatedBorder(
      key: key,
      type: type,
      duration: duration,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      colors: colors,
      glowOpacity: glowOpacity,
      glowSpread: glowSpread,
      padding: padding,
      animationCurve: animationCurve,
      text: text,
      textStyle: textStyle,
      trackColor: trackColor,
      child: this,
    );
  }

  /// Directly wraps the widget in a [ZoSnakeBorder].
  Widget zoSnakeBorder({
    Key? key,
    Duration animationDuration = const Duration(seconds: 10),
    double borderWidth = 3,
    double glowOpacity = 0.1,
    double glowSpread = 6.0,
    Color snakeHeadColor = Colors.deepOrange,
    Color snakeTailColor = Colors.lightGreen,
    Color snakeTrackColor = const Color(0xFFCCCCCC),
    BorderRadius? borderRadius,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    Curve animationCurve = Curves.linear,
  }) {
    final resolvedRadius = borderRadius ??
        ZoBorderRadiusResolver.autoDetect(this) ??
        BorderRadius.zero;
    return ZoSnakeBorder(
      key: key,
      animationDuration: animationDuration,
      borderWidth: borderWidth,
      glowOpacity: glowOpacity,
      glowSpread: glowSpread,
      snakeHeadColor: snakeHeadColor,
      snakeTailColor: snakeTailColor,
      snakeTrackColor: snakeTrackColor,
      borderRadius: resolvedRadius,
      padding: padding,
      animationCurve: animationCurve,
      child: this,
    );
  }

  /// Directly wraps the widget in a [ZoDualBorder].
  Widget zoDualBorder({
    Key? key,
    Duration animationDuration = const Duration(seconds: 1),
    double borderWidth = 3,
    double glowOpacity = 0.3,
    double glowSpread = 6.0,
    Color firstBorderColor = Colors.deepOrange,
    Color secondBorderColor = Colors.lightGreen,
    Color trackBorderColor = const Color(0xFFCCCCCC),
    BorderRadius? borderRadius,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    Curve animationCurve = Curves.linear,
  }) {
    final resolvedRadius = borderRadius ??
        ZoBorderRadiusResolver.autoDetect(this) ??
        BorderRadius.zero;
    return ZoDualBorder(
      key: key,
      animationDuration: animationDuration,
      borderWidth: borderWidth,
      glowOpacity: glowOpacity,
      glowSpread: glowSpread,
      firstBorderColor: firstBorderColor,
      secondBorderColor: secondBorderColor,
      trackBorderColor: trackBorderColor,
      borderRadius: resolvedRadius,
      padding: padding,
      animationCurve: animationCurve,
      child: this,
    );
  }

  /// Directly wraps the widget in a [ZoPulsatingBorder].
  Widget zoPulsatingBorder({
    Key? key,
    double layerCount = 2,
    BorderRadius? borderRadius,
    Color pulseColor = Colors.black,
    Duration animationDuration = const Duration(seconds: 2),
    ZoPulsatingBorderType? type = ZoPulsatingBorderType.pulse,
    Curve animationCurve = Curves.easeOut,
  }) {
    final resolvedRadius =
        borderRadius ?? ZoBorderRadiusResolver.autoDetect(this);
    return ZoPulsatingBorder(
      key: key,
      layerCount: layerCount,
      borderRadius: resolvedRadius,
      pulseColor: pulseColor,
      animationDuration: animationDuration,
      type: type,
      animationCurve: animationCurve,
      child: this,
    );
  }

  /// Directly wraps the widget in a [ZoBreathingBorder].
  Widget zoBreathingBorder({
    Key? key,
    double borderWidth = 2.0,
    BorderRadius? borderRadius,
    required List<Color> colors,
    Curve animationCurve = Curves.linear,
    Duration animationDuration = const Duration(seconds: 3),
  }) {
    final resolvedRadius = borderRadius ??
        ZoBorderRadiusResolver.autoDetect(this) ??
        BorderRadius.zero;
    return ZoBreathingBorder(
      key: key,
      borderWidth: borderWidth,
      borderRadius: resolvedRadius,
      colors: colors,
      animationCurve: animationCurve,
      animationDuration: animationDuration,
      child: this,
    );
  }

  /// Directly wraps the widget in a [ZoDottedBorder].
  Widget zoDottedBorder({
    Key? key,
    double? borderRadius,
    bool animate = true,
    double dashLength = 10,
    double gapLength = 5,
    double animationSpeed = 0.4,
    double strokeWidth = 3,
    Color color = Colors.blue,
    Duration animationDuration = const Duration(seconds: 10),
    Gradient gradient = const LinearGradient(colors: [Colors.red, Colors.blue]),
    BorderStyleType borderStyle = BorderStyleType.monochrome,
    EdgeInsetsGeometry? padding,
    Curve animationCurve = Curves.linear,
  }) {
    final resolvedRadius = borderRadius ??
        ZoBorderRadiusResolver.autoDetect(this)?.topLeft.x ??
        0.0;
    return ZoDottedBorder(
      key: key,
      borderRadius: resolvedRadius,
      animate: animate,
      dashLength: dashLength,
      gapLength: gapLength,
      animationSpeed: animationSpeed,
      strokeWidth: strokeWidth,
      color: color,
      animationDuration: animationDuration,
      gradient: gradient,
      borderStyle: borderStyle,
      padding: padding,
      animationCurve: animationCurve,
      child: this,
    );
  }

  /// Directly wraps the widget in a [ZoAnimatedGradientBorder].
  Widget zoGradientBorder({
    Key? key,
    double? borderRadius,
    double glowOpacity = 0.5,
    double glowSpread = 5.0,
    Duration animationDuration = const Duration(seconds: 1),
    double borderThickness = 1,
    Curve animationCurve = Curves.linear,
    required List<Color> gradientColor,
    bool shouldAnimate = true,
  }) {
    final resolvedRadius = borderRadius ??
        ZoBorderRadiusResolver.autoDetect(this)?.topLeft.x ??
        0.0;
    return ZoAnimatedGradientBorder(
      key: key,
      borderRadius: resolvedRadius,
      glowOpacity: glowOpacity,
      glowSpread: glowSpread,
      animationDuration: animationDuration,
      borderThickness: borderThickness,
      animationCurve: animationCurve,
      gradientColor: gradientColor,
      shouldAnimate: shouldAnimate,
      child: this,
    );
  }

  /// Directly wraps the widget in a [ZoMultiColorBorder].
  Widget zoMultiColorBorder({
    Key? key,
    double? borderRadius,
    double gapLength = 0,
    Duration animationDuration = const Duration(seconds: 2),
    double strokeWidth = 3,
    bool animate = true,
    EdgeInsetsGeometry? padding,
    Curve animationCurve = Curves.linear,
    List<Color> colors = const [Colors.blue, Colors.black],
  }) {
    final resolvedRadius = borderRadius ??
        ZoBorderRadiusResolver.autoDetect(this)?.topLeft.x ??
        0.0;
    return ZoMultiColorBorder(
      key: key,
      borderRadius: resolvedRadius,
      gapLength: gapLength,
      animationDuration: animationDuration,
      strokeWidth: strokeWidth,
      animate: animate,
      padding: padding,
      animationCurve: animationCurve,
      colors: colors,
      child: this,
    );
  }

  /// Directly wraps the widget in a [ZoColorChangingBorder].
  Widget zoColorChangeBorder({
    Key? key,
    double borderWidth = 4,
    double? borderRadius,
    double segmentLength = 0.1,
    required List<Color> colors,
    Duration animationDuration = const Duration(seconds: 3),
    List<double>? colorStops,
    Color staticBorderColor = Colors.transparent,
    Curve animationCurve = Curves.linear,
  }) {
    final resolvedRadius = borderRadius ??
        ZoBorderRadiusResolver.autoDetect(this)?.topLeft.x ??
        12.0;
    return ZoColorChangingBorder(
      key: key,
      borderWidth: borderWidth,
      borderRadius: resolvedRadius,
      segmentLength: segmentLength,
      colors: colors,
      animationDuration: animationDuration,
      colorStops: colorStops,
      staticBorderColor: staticBorderColor,
      animationCurve: animationCurve,
      child: this,
    );
  }

  /// Directly wraps the widget in a [ZoGlowingEdgeBorder].
  Widget zoGlowEdgeBorder({
    Key? key,
    required List<Color> gradientColors,
    double borderWidth = 4.0,
    Duration animationDuration = const Duration(seconds: 3),
    double? borderRadius,
    double edgeLength = 120.0,
    Curve animationCurve = Curves.linear,
  }) {
    final resolvedRadius = borderRadius ??
        ZoBorderRadiusResolver.autoDetect(this)?.topLeft.x ??
        5.0;
    return ZoGlowingEdgeBorder(
      key: key,
      gradientColors: gradientColors,
      borderWidth: borderWidth,
      animationDuration: animationDuration,
      borderRadius: resolvedRadius,
      edgeLength: edgeLength,
      animationCurve: animationCurve,
      child: this,
    );
  }

  /// Directly wraps the widget in a [ZoSignalBorder].
  Widget zoSignalBorder({
    Key? key,
    required List<Color> ringColors,
    double? minRadius,
    double spaceBetween = 20,
    Curve animationCurve = Curves.linear,
    Duration animationDuration = const Duration(seconds: 3),
    double? borderRadius,
  }) {
    final resolvedRadius = borderRadius ??
        ZoBorderRadiusResolver.autoDetect(this)?.topLeft.x ??
        0.0;
    return ZoSignalBorder(
      key: key,
      ringColors: ringColors,
      minRadius: minRadius,
      spaceBetween: spaceBetween,
      animationCurve: animationCurve,
      animationDuration: animationDuration,
      borderRadius: resolvedRadius,
      child: this,
    );
  }

  /// Directly wraps the widget in a [ZoRippleBorder].
  Widget zoRippleBorder({
    Key? key,
    int numberOfCircles = 3,
    Color rippleColor = Colors.amber,
    double minCircleSize = 80,
    Duration animationDuration = const Duration(seconds: 3),
    BorderRadius? borderRadius,
  }) {
    final resolvedRadius =
        borderRadius ?? ZoBorderRadiusResolver.autoDetect(this);
    return ZoRippleBorder(
      key: key,
      numberOfCircles: numberOfCircles,
      rippleColor: rippleColor,
      minCircleSize: minCircleSize,
      animationDuration: animationDuration,
      borderRadius: resolvedRadius,
      child: this,
    );
  }

  /// Directly wraps the widget in a [ZoScribbleBorder].
  Widget zoScribbleBorder({
    Key? key,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    Color borderColor = Colors.green,
    double borderWidth = 8,
    double glowOpacity = 0.6,
    double glowSpread = 5.0,
    Duration animationDuration = const Duration(seconds: 4),
  }) {
    final resolvedRadius = borderRadius ??
        ZoBorderRadiusResolver.autoDetect(this)?.topLeft.x ??
        0.0;
    return ZoScribbleBorder(
      key: key,
      borderRadius: resolvedRadius,
      padding: padding,
      borderColor: borderColor,
      borderWidth: borderWidth,
      glowOpacity: glowOpacity,
      glowSpread: glowSpread,
      animationDuration: animationDuration,
      child: this,
    );
  }

  /// Directly wraps the widget in a [ZoTextBorder].
  Widget zoTextBorder({
    Key? key,
    required String text,
    BorderRadius? borderRadius,
    double padding = 10.0,
    Duration duration = const Duration(seconds: 10),
    TextStyle textStyle = const TextStyle(color: Colors.white, fontSize: 12),
  }) {
    final resolvedRadius = borderRadius ??
        ZoBorderRadiusResolver.autoDetect(this) ??
        BorderRadius.zero;
    return ZoTextBorder(
      key: key,
      text: text,
      borderRadius: resolvedRadius,
      padding: padding,
      duration: duration,
      textStyle: textStyle,
      child: this,
    );
  }

  /// Directly wraps the widget in a [ZoSegmentBorder].
  Widget zoSegmentBorder({
    Key? key,
    double? borderRadius,
    List<Color>? colors,
    List<double>? stops,
    Gradient? gradient,
    double segmentLength = 0.15,
    double glowOpacity = 1.0,
    double glowSpread = 8.0,
  }) {
    final resolvedRadius = borderRadius ??
        ZoBorderRadiusResolver.autoDetect(this)?.topLeft.x ??
        0.0;
    return ZoSegmentBorder(
      key: key,
      borderRadius: resolvedRadius,
      colors: colors,
      stops: stops,
      gradient: gradient,
      segmentLength: segmentLength,
      glowOpacity: glowOpacity,
      glowSpread: glowSpread,
      child: this,
    );
  }

  /// Directly wraps the widget in a [ZoFireBorder].
  Widget zoFireBorder({
    Key? key,
    Duration duration = const Duration(seconds: 3),
    double borderWidth = 3,
    double snakeLength = 0.1,
    BorderRadius? borderRadius,
    Gradient gradient = const SweepGradient(
      colors: [Colors.orange, Colors.red, Colors.yellow],
    ),
    List<Color>? particleColors,
  }) {
    final resolvedRadius = borderRadius ??
        ZoBorderRadiusResolver.autoDetect(this) ??
        BorderRadius.zero;
    return ZoFireBorder(
      key: key,
      duration: duration,
      borderWidth: borderWidth,
      snakeLength: snakeLength,
      borderRadius: resolvedRadius,
      gradient: gradient,
      particleColors: particleColors,
      child: this,
    );
  }

  /// Directly wraps the widget in a [ZoPsychoBorder].
  Widget zoPsychoBorder({
    Key? key,
    int ringCount = 3,
    double maxSpread = 8.0,
    List<Color> colors = const [
      Color(0xFFFF2A85),
      Color(0xFFFF992A),
      Color(0xFF00E5FF),
    ],
    Duration duration = const Duration(seconds: 3),
    BorderRadius? borderRadius,
  }) {
    final resolvedRadius = borderRadius ??
        ZoBorderRadiusResolver.autoDetect(this) ??
        BorderRadius.zero;
    return ZoPsychoBorder(
      key: key,
      ringCount: ringCount,
      maxSpread: maxSpread,
      colors: colors,
      duration: duration,
      borderRadius: resolvedRadius,
      child: this,
    );
  }

  /// Directly wraps the widget in a [ZoSequentialGlowBorder].
  Widget zoSequentialGlowBorder({
    Key? key,
    List<List<Color>> gradientPalettes = const [
      [Color(0xFF6B2AFF), Color(0xFF00E5FF)],
      [Color(0xFFFF2A85), Color(0xFFFF992A)],
      [Color(0xFF00FF87), Color(0xFF60EFFF)],
    ],
    double glowRadius = 8.0,
    double borderWidth = 4.0,
    Duration duration = const Duration(seconds: 4),
    BorderRadius? borderRadius,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
  }) {
    final resolvedRadius = borderRadius ??
        ZoBorderRadiusResolver.autoDetect(this) ??
        BorderRadius.zero;
    return ZoSequentialGlowBorder(
      key: key,
      gradientPalettes: gradientPalettes,
      glowRadius: glowRadius,
      borderWidth: borderWidth,
      duration: duration,
      borderRadius: resolvedRadius,
      padding: padding,
      child: this,
    );
  }

  /// Directly wraps the widget in a [ZoMonoCromeBorder].
  Widget zoMonoChromeBorder({
    Key? key,
    ValueChanged<AnimationController>? controller,
    Duration animationDuration = const Duration(seconds: 4),
    double? cornerRadius,
    double borderWidth = 1,
    Curve animationCurve = Curves.linear,
    Color trackBorderColor = Colors.red,
    EdgeInsets padding = EdgeInsets.zero,
    ZoMonoCromeBorderStyle borderStyle = ZoMonoCromeBorderStyle.stroke,
  }) {
    final resolvedRadius = cornerRadius ??
        ZoBorderRadiusResolver.autoDetect(this)?.topLeft.x ??
        0.0;
    return ZoMonoCromeBorder(
      key: key,
      controller: controller,
      animationDuration: animationDuration,
      cornerRadius: resolvedRadius,
      borderWidth: borderWidth,
      animationCurve: animationCurve,
      trackBorderColor: trackBorderColor,
      padding: padding,
      borderStyle: borderStyle,
      child: this,
    );
  }
}

/// Fluent builder for chaining animated borders on a widget.
class ZoAnimate extends StatelessWidget {
  /// The underlying target widget.
  final Widget child;

  /// Creates a [ZoAnimate] instance.
  const ZoAnimate({super.key, required this.child});

  @override
  Widget build(BuildContext context) => child;

  /// Applies a [ZoAnimatedBorder] with configurable [type].
  ZoAnimate border({
    Key? key,
    ZoBorderType type = ZoBorderType.snake,
    Duration? duration,
    double borderWidth = 3.0,
    BorderRadius? borderRadius,
    List<Color>? colors,
    double glowOpacity = 0.6,
    double glowSpread = 6.0,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    Curve animationCurve = Curves.linear,
    String text = "ZO ANIMATED BORDER • ",
    TextStyle textStyle = const TextStyle(color: Colors.white, fontSize: 12),
    Color trackColor = const Color(0xFF334155),
  }) {
    return ZoAnimate(
      key: key,
      child: child.zoAnimatedBorder(
        type: type,
        duration: duration,
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        colors: colors,
        glowOpacity: glowOpacity,
        glowSpread: glowSpread,
        padding: padding,
        animationCurve: animationCurve,
        text: text,
        textStyle: textStyle,
        trackColor: trackColor,
      ),
    );
  }

  /// Applies a [ZoSnakeBorder].
  ZoAnimate snake({
    Key? key,
    Duration animationDuration = const Duration(seconds: 10),
    double borderWidth = 3,
    double glowOpacity = 0.1,
    double glowSpread = 6.0,
    Color snakeHeadColor = Colors.deepOrange,
    Color snakeTailColor = Colors.lightGreen,
    Color snakeTrackColor = const Color(0xFFCCCCCC),
    BorderRadius? borderRadius,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    Curve animationCurve = Curves.linear,
  }) {
    return ZoAnimate(
      key: key,
      child: child.zoSnakeBorder(
        animationDuration: animationDuration,
        borderWidth: borderWidth,
        glowOpacity: glowOpacity,
        glowSpread: glowSpread,
        snakeHeadColor: snakeHeadColor,
        snakeTailColor: snakeTailColor,
        snakeTrackColor: snakeTrackColor,
        borderRadius: borderRadius,
        padding: padding,
        animationCurve: animationCurve,
      ),
    );
  }

  /// Applies a [ZoDualBorder].
  ZoAnimate dual({
    Key? key,
    Duration animationDuration = const Duration(seconds: 1),
    double borderWidth = 3,
    double glowOpacity = 0.3,
    double glowSpread = 6.0,
    Color firstBorderColor = Colors.deepOrange,
    Color secondBorderColor = Colors.lightGreen,
    Color trackBorderColor = const Color(0xFFCCCCCC),
    BorderRadius? borderRadius,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    Curve animationCurve = Curves.linear,
  }) {
    return ZoAnimate(
      key: key,
      child: child.zoDualBorder(
        animationDuration: animationDuration,
        borderWidth: borderWidth,
        glowOpacity: glowOpacity,
        glowSpread: glowSpread,
        firstBorderColor: firstBorderColor,
        secondBorderColor: secondBorderColor,
        trackBorderColor: trackBorderColor,
        borderRadius: borderRadius,
        padding: padding,
        animationCurve: animationCurve,
      ),
    );
  }

  /// Applies a [ZoPulsatingBorder].
  ZoAnimate pulsating({
    Key? key,
    double layerCount = 2,
    BorderRadius? borderRadius,
    Color pulseColor = Colors.black,
    Duration animationDuration = const Duration(seconds: 2),
    ZoPulsatingBorderType? type = ZoPulsatingBorderType.pulse,
    Curve animationCurve = Curves.easeOut,
  }) {
    return ZoAnimate(
      key: key,
      child: child.zoPulsatingBorder(
        layerCount: layerCount,
        borderRadius: borderRadius,
        pulseColor: pulseColor,
        animationDuration: animationDuration,
        type: type,
        animationCurve: animationCurve,
      ),
    );
  }

  /// Applies a [ZoBreathingBorder].
  ZoAnimate breathing({
    Key? key,
    double borderWidth = 2.0,
    BorderRadius? borderRadius,
    required List<Color> colors,
    Curve animationCurve = Curves.linear,
    Duration animationDuration = const Duration(seconds: 3),
  }) {
    return ZoAnimate(
      key: key,
      child: child.zoBreathingBorder(
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        colors: colors,
        animationCurve: animationCurve,
        animationDuration: animationDuration,
      ),
    );
  }

  /// Applies a [ZoDottedBorder].
  ZoAnimate dotted({
    Key? key,
    double? borderRadius,
    bool animate = true,
    double dashLength = 10,
    double gapLength = 5,
    double animationSpeed = 0.4,
    double strokeWidth = 3,
    Color color = Colors.blue,
    Duration animationDuration = const Duration(seconds: 10),
    Gradient gradient = const LinearGradient(colors: [Colors.red, Colors.blue]),
    BorderStyleType borderStyle = BorderStyleType.monochrome,
    EdgeInsetsGeometry? padding,
    Curve animationCurve = Curves.linear,
  }) {
    return ZoAnimate(
      key: key,
      child: child.zoDottedBorder(
        borderRadius: borderRadius,
        animate: animate,
        dashLength: dashLength,
        gapLength: gapLength,
        animationSpeed: animationSpeed,
        strokeWidth: strokeWidth,
        color: color,
        animationDuration: animationDuration,
        gradient: gradient,
        borderStyle: borderStyle,
        padding: padding,
        animationCurve: animationCurve,
      ),
    );
  }

  /// Applies a [ZoAnimatedGradientBorder].
  ZoAnimate gradient({
    Key? key,
    double? borderRadius,
    double glowOpacity = 0.5,
    double glowSpread = 5.0,
    Duration animationDuration = const Duration(seconds: 1),
    double borderThickness = 1,
    Curve animationCurve = Curves.linear,
    required List<Color> gradientColor,
    bool shouldAnimate = true,
  }) {
    return ZoAnimate(
      key: key,
      child: child.zoGradientBorder(
        borderRadius: borderRadius,
        glowOpacity: glowOpacity,
        glowSpread: glowSpread,
        animationDuration: animationDuration,
        borderThickness: borderThickness,
        animationCurve: animationCurve,
        gradientColor: gradientColor,
        shouldAnimate: shouldAnimate,
      ),
    );
  }

  /// Applies a [ZoMultiColorBorder].
  ZoAnimate multiColor({
    Key? key,
    double? borderRadius,
    double gapLength = 0,
    Duration animationDuration = const Duration(seconds: 2),
    double strokeWidth = 3,
    bool animate = true,
    EdgeInsetsGeometry? padding,
    Curve animationCurve = Curves.linear,
    List<Color> colors = const [Colors.blue, Colors.black],
  }) {
    return ZoAnimate(
      key: key,
      child: child.zoMultiColorBorder(
        borderRadius: borderRadius,
        gapLength: gapLength,
        animationDuration: animationDuration,
        strokeWidth: strokeWidth,
        animate: animate,
        padding: padding,
        animationCurve: animationCurve,
        colors: colors,
      ),
    );
  }

  /// Applies a [ZoColorChangingBorder].
  ZoAnimate colorChange({
    Key? key,
    double borderWidth = 4,
    double? borderRadius,
    double segmentLength = 0.1,
    required List<Color> colors,
    Duration animationDuration = const Duration(seconds: 3),
    List<double>? colorStops,
    Color staticBorderColor = Colors.transparent,
    Curve animationCurve = Curves.linear,
  }) {
    return ZoAnimate(
      key: key,
      child: child.zoColorChangeBorder(
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        segmentLength: segmentLength,
        colors: colors,
        animationDuration: animationDuration,
        colorStops: colorStops,
        staticBorderColor: staticBorderColor,
        animationCurve: animationCurve,
      ),
    );
  }

  /// Applies a [ZoGlowingEdgeBorder].
  ZoAnimate glowEdge({
    Key? key,
    required List<Color> gradientColors,
    double borderWidth = 4.0,
    Duration animationDuration = const Duration(seconds: 3),
    double? borderRadius,
    double edgeLength = 120.0,
    Curve animationCurve = Curves.linear,
  }) {
    return ZoAnimate(
      key: key,
      child: child.zoGlowEdgeBorder(
        gradientColors: gradientColors,
        borderWidth: borderWidth,
        animationDuration: animationDuration,
        borderRadius: borderRadius,
        edgeLength: edgeLength,
        animationCurve: animationCurve,
      ),
    );
  }

  /// Applies a [ZoSignalBorder].
  ZoAnimate signal({
    Key? key,
    required List<Color> ringColors,
    double? minRadius,
    double spaceBetween = 20,
    Curve animationCurve = Curves.linear,
    Duration animationDuration = const Duration(seconds: 3),
    double? borderRadius,
  }) {
    return ZoAnimate(
      key: key,
      child: child.zoSignalBorder(
        ringColors: ringColors,
        minRadius: minRadius,
        spaceBetween: spaceBetween,
        animationCurve: animationCurve,
        animationDuration: animationDuration,
        borderRadius: borderRadius,
      ),
    );
  }

  /// Applies a [ZoRippleBorder].
  ZoAnimate ripple({
    Key? key,
    int numberOfCircles = 3,
    Color rippleColor = Colors.amber,
    double minCircleSize = 80,
    Duration animationDuration = const Duration(seconds: 3),
    BorderRadius? borderRadius,
  }) {
    return ZoAnimate(
      key: key,
      child: child.zoRippleBorder(
        numberOfCircles: numberOfCircles,
        rippleColor: rippleColor,
        minCircleSize: minCircleSize,
        animationDuration: animationDuration,
        borderRadius: borderRadius,
      ),
    );
  }

  /// Applies a [ZoScribbleBorder].
  ZoAnimate scribble({
    Key? key,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    Color borderColor = Colors.green,
    double borderWidth = 8,
    double glowOpacity = 0.6,
    double glowSpread = 5.0,
    Duration animationDuration = const Duration(seconds: 4),
  }) {
    return ZoAnimate(
      key: key,
      child: child.zoScribbleBorder(
        borderRadius: borderRadius,
        padding: padding,
        borderColor: borderColor,
        borderWidth: borderWidth,
        glowOpacity: glowOpacity,
        glowSpread: glowSpread,
        animationDuration: animationDuration,
      ),
    );
  }

  /// Applies a [ZoTextBorder].
  ZoAnimate textBorder({
    Key? key,
    required String text,
    BorderRadius? borderRadius,
    double padding = 10.0,
    Duration duration = const Duration(seconds: 10),
    TextStyle textStyle = const TextStyle(color: Colors.white, fontSize: 12),
  }) {
    return ZoAnimate(
      key: key,
      child: child.zoTextBorder(
        text: text,
        borderRadius: borderRadius,
        padding: padding,
        duration: duration,
        textStyle: textStyle,
      ),
    );
  }

  /// Applies a [ZoSegmentBorder].
  ZoAnimate segment({
    Key? key,
    double? borderRadius,
    List<Color>? colors,
    List<double>? stops,
    Gradient? gradient,
    double segmentLength = 0.15,
    double glowOpacity = 1.0,
    double glowSpread = 8.0,
  }) {
    return ZoAnimate(
      key: key,
      child: child.zoSegmentBorder(
        borderRadius: borderRadius,
        colors: colors,
        stops: stops,
        gradient: gradient,
        segmentLength: segmentLength,
        glowOpacity: glowOpacity,
        glowSpread: glowSpread,
      ),
    );
  }

  /// Applies a [ZoFireBorder].
  ZoAnimate fire({
    Key? key,
    Duration duration = const Duration(seconds: 3),
    double borderWidth = 3,
    double snakeLength = 0.1,
    BorderRadius? borderRadius,
    Gradient gradient = const SweepGradient(
      colors: [Colors.orange, Colors.red, Colors.yellow],
    ),
    List<Color>? particleColors,
  }) {
    return ZoAnimate(
      key: key,
      child: child.zoFireBorder(
        duration: duration,
        borderWidth: borderWidth,
        snakeLength: snakeLength,
        borderRadius: borderRadius,
        gradient: gradient,
        particleColors: particleColors,
      ),
    );
  }

  /// Applies a [ZoPsychoBorder].
  ZoAnimate psycho({
    Key? key,
    int ringCount = 3,
    double maxSpread = 8.0,
    List<Color> colors = const [
      Color(0xFFFF2A85),
      Color(0xFFFF992A),
      Color(0xFF00E5FF),
    ],
    Duration duration = const Duration(seconds: 3),
    BorderRadius? borderRadius,
  }) {
    return ZoAnimate(
      key: key,
      child: child.zoPsychoBorder(
        ringCount: ringCount,
        maxSpread: maxSpread,
        colors: colors,
        duration: duration,
        borderRadius: borderRadius,
      ),
    );
  }

  /// Applies a [ZoSequentialGlowBorder].
  ZoAnimate sequentialGlow({
    Key? key,
    List<List<Color>> gradientPalettes = const [
      [Color(0xFF6B2AFF), Color(0xFF00E5FF)],
      [Color(0xFFFF2A85), Color(0xFFFF992A)],
      [Color(0xFF00FF87), Color(0xFF60EFFF)],
    ],
    double glowRadius = 8.0,
    double borderWidth = 4.0,
    Duration duration = const Duration(seconds: 4),
    BorderRadius? borderRadius,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
  }) {
    return ZoAnimate(
      key: key,
      child: child.zoSequentialGlowBorder(
        gradientPalettes: gradientPalettes,
        glowRadius: glowRadius,
        borderWidth: borderWidth,
        duration: duration,
        borderRadius: borderRadius,
        padding: padding,
      ),
    );
  }

  /// Applies a [ZoMonoCromeBorder].
  ZoAnimate monochrome({
    Key? key,
    ValueChanged<AnimationController>? controller,
    Duration animationDuration = const Duration(seconds: 4),
    double? cornerRadius,
    double borderWidth = 1,
    Curve animationCurve = Curves.linear,
    Color trackBorderColor = Colors.red,
    EdgeInsets padding = EdgeInsets.zero,
    ZoMonoCromeBorderStyle borderStyle = ZoMonoCromeBorderStyle.stroke,
  }) {
    return ZoAnimate(
      key: key,
      child: child.zoMonoChromeBorder(
        controller: controller,
        animationDuration: animationDuration,
        cornerRadius: cornerRadius,
        borderWidth: borderWidth,
        animationCurve: animationCurve,
        trackBorderColor: trackBorderColor,
        padding: padding,
        borderStyle: borderStyle,
      ),
    );
  }
}
