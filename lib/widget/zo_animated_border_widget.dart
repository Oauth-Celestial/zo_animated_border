import 'package:flutter/material.dart';
import 'package:zo_animated_border/util/zo_border_radius_resolver.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

/// The type of animated border to render in [ZoAnimatedBorder].
enum ZoBorderType {
  snake,
  dual,
  gradient,
  glowEdge,
  pulsating,
  breathing,
  dotted,
  multiColor,
  colorChange,
  segment,
  fire,
  psycho,
  sequentialGlow,
  signal,
  ripple,
  scribble,
  text,
  monochrome,
}

/// Unified widget to apply any animated border effect to [child].
class ZoAnimatedBorder extends StatelessWidget {
  /// The child widget to surround with the animated border.
  final Widget child;

  /// The type of animated border. Defaults to [ZoBorderType.snake].
  final ZoBorderType type;

  /// The duration of the border animation.
  final Duration? duration;

  /// The thickness / stroke width of the border.
  final double borderWidth;

  /// The border radius. If null, automatically detected from [child].
  final BorderRadius? borderRadius;

  /// Colors used for the border animation.
  final List<Color>? colors;

  /// The opacity of the glow effect (0.0 to 1.0).
  final double glowOpacity;

  /// The spread distance of the glow effect.
  final double glowSpread;

  /// The padding space between the border and the child.
  final EdgeInsetsGeometry padding;

  /// The animation curve.
  final Curve animationCurve;

  /// Text for [ZoBorderType.text].
  final String text;

  /// TextStyle for [ZoBorderType.text].
  final TextStyle textStyle;

  /// Background / static track border color.
  final Color trackColor;

  /// Creates a [ZoAnimatedBorder] instance.
  const ZoAnimatedBorder({
    super.key,
    required this.child,
    this.type = ZoBorderType.snake,
    this.duration,
    this.borderWidth = 3.0,
    this.borderRadius,
    this.colors,
    this.glowOpacity = 0.6,
    this.glowSpread = 6.0,
    this.padding = EdgeInsets.zero,
    this.animationCurve = Curves.linear,
    this.text = "ZO ANIMATED BORDER • ",
    this.textStyle = const TextStyle(color: Colors.white, fontSize: 12),
    this.trackColor = const Color(0xFF334155),
  });

  @override
  Widget build(BuildContext context) {
    final resolvedRadius = borderRadius ??
        ZoBorderRadiusResolver.autoDetect(child) ??
        BorderRadius.zero;
    final defaultColors = colors ??
        const [
          Colors.cyanAccent,
          Colors.purpleAccent,
          Colors.pinkAccent,
        ];

    switch (type) {
      case ZoBorderType.snake:
        return ZoSnakeBorder(
          animationDuration: duration ?? const Duration(seconds: 4),
          borderWidth: borderWidth,
          glowOpacity: glowOpacity.clamp(0.0, 1.0),
          glowSpread: glowSpread,
          snakeHeadColor: defaultColors.first,
          snakeTailColor: defaultColors.length > 1
              ? defaultColors[1]
              : defaultColors.first,
          snakeTrackColor: trackColor,
          borderRadius: resolvedRadius,
          padding: padding,
          animationCurve: animationCurve,
          child: child,
        );

      case ZoBorderType.dual:
        return ZoDualBorder(
          animationDuration: duration ?? const Duration(seconds: 2),
          borderWidth: borderWidth,
          glowOpacity: glowOpacity.clamp(0.0, 1.0),
          glowSpread: glowSpread,
          firstBorderColor: defaultColors.first,
          secondBorderColor: defaultColors.length > 1
              ? defaultColors[1]
              : defaultColors.first,
          trackBorderColor: trackColor,
          borderRadius: resolvedRadius,
          padding: padding,
          animationCurve: animationCurve,
          child: child,
        );

      case ZoBorderType.glowEdge:
        return ZoGlowingEdgeBorder(
          gradientColors: defaultColors,
          borderWidth: borderWidth,
          borderRadius: resolvedRadius.topLeft.x,
          animationDuration: duration ?? const Duration(seconds: 3),
          animationCurve: animationCurve,
          child: child,
        );

      case ZoBorderType.gradient:
        return ZoAnimatedGradientBorder(
          gradientColor: defaultColors,
          borderThickness: borderWidth,
          borderRadius: resolvedRadius.topLeft.x,
          glowOpacity: glowOpacity.clamp(0.0, 1.0),
          glowSpread: glowSpread,
          animationDuration: duration ?? const Duration(seconds: 3),
          animationCurve: animationCurve,
          child: child,
        );

      case ZoBorderType.pulsating:
        return ZoPulsatingBorder(
          pulseColor: defaultColors.first,
          borderRadius: resolvedRadius,
          animationDuration: duration ?? const Duration(seconds: 2),
          animationCurve: animationCurve,
          child: child,
        );

      case ZoBorderType.breathing:
        return ZoBreathingBorder(
          colors: defaultColors,
          borderWidth: borderWidth,
          borderRadius: resolvedRadius,
          animationDuration: duration ?? const Duration(seconds: 3),
          animationCurve: animationCurve,
          child: child,
        );

      case ZoBorderType.dotted:
        return ZoDottedBorder(
          color: defaultColors.first,
          strokeWidth: borderWidth,
          borderRadius: resolvedRadius.topLeft.x,
          animationDuration: duration ?? const Duration(seconds: 6),
          animationCurve: animationCurve,
          padding: padding,
          child: child,
        );

      case ZoBorderType.multiColor:
        return ZoMultiColorBorder(
          colors: defaultColors,
          strokeWidth: borderWidth,
          borderRadius: resolvedRadius.topLeft.x,
          animationDuration: duration ?? const Duration(seconds: 3),
          animationCurve: animationCurve,
          padding: padding,
          child: child,
        );

      case ZoBorderType.colorChange:
        return ZoColorChangingBorder(
          colors: defaultColors,
          borderWidth: borderWidth,
          borderRadius: resolvedRadius.topLeft.x,
          animationDuration: duration ?? const Duration(seconds: 3),
          staticBorderColor: trackColor,
          animationCurve: animationCurve,
          child: child,
        );

      case ZoBorderType.segment:
        return ZoSegmentBorder(
          colors: defaultColors,
          borderRadius: resolvedRadius.topLeft.x,
          glowOpacity: glowOpacity.clamp(0.0, 1.0),
          glowSpread: glowSpread,
          child: child,
        );

      case ZoBorderType.fire:
        return ZoFireBorder(
          duration: duration ?? const Duration(seconds: 3),
          borderWidth: borderWidth,
          borderRadius: resolvedRadius,
          gradient: SweepGradient(colors: defaultColors),
          particleColors: defaultColors,
          child: child,
        );

      case ZoBorderType.psycho:
        return ZoPsychoBorder(
          colors: defaultColors,
          duration: duration ?? const Duration(seconds: 3),
          borderRadius: resolvedRadius,
          child: child,
        );

      case ZoBorderType.sequentialGlow:
        return ZoSequentialGlowBorder(
          borderWidth: borderWidth,
          glowRadius: glowSpread,
          duration: duration ?? const Duration(seconds: 4),
          borderRadius: resolvedRadius,
          padding: padding,
          child: child,
        );

      case ZoBorderType.signal:
        return ZoSignalBorder(
          ringColors: defaultColors,
          borderRadius: resolvedRadius.topLeft.x,
          animationDuration: duration ?? const Duration(seconds: 3),
          animationCurve: animationCurve,
          child: child,
        );

      case ZoBorderType.ripple:
        return ZoRippleBorder(
          rippleColor: defaultColors.first,
          borderRadius: resolvedRadius,
          animationDuration: duration ?? const Duration(seconds: 3),
          child: child,
        );

      case ZoBorderType.scribble:
        return ZoScribbleBorder(
          borderColor: defaultColors.first,
          borderWidth: borderWidth,
          borderRadius: resolvedRadius.topLeft.x,
          glowOpacity: glowOpacity.clamp(0.0, 1.0),
          glowSpread: glowSpread,
          animationDuration: duration ?? const Duration(seconds: 4),
          padding: padding,
          child: child,
        );

      case ZoBorderType.text:
        return ZoTextBorder(
          text: text,
          textStyle: textStyle,
          borderRadius: resolvedRadius,
          duration: duration ?? const Duration(seconds: 10),
          child: child,
        );

      case ZoBorderType.monochrome:
        return ZoMonoCromeBorder(
          trackBorderColor: defaultColors.first,
          borderWidth: borderWidth,
          cornerRadius: resolvedRadius.topLeft.x,
          animationDuration: duration ?? const Duration(seconds: 4),
          animationCurve: animationCurve,
          padding: padding is EdgeInsets ? padding as EdgeInsets : EdgeInsets.zero,
          child: child,
        );
    }
  }
}
