import 'package:flutter/material.dart';

/// Utility to automatically inspect and detect [BorderRadius] from a given widget tree.
class ZoBorderRadiusResolver {
  ZoBorderRadiusResolver._();

  /// Recursively inspects [widget] up to [maxDepth] levels to detect its [BorderRadius].
  ///
  /// If no border radius is explicitly found, returns `null`.
  static BorderRadius? autoDetect(Widget? widget, {int maxDepth = 5}) {
    if (widget == null || maxDepth <= 0) return null;

    // Direct inspect
    final direct = _inspectDirect(widget);
    if (direct != null) return direct;

    // Unpack child if wrapper widget
    final child = _unwrapChild(widget);
    if (child != null) {
      return autoDetect(child, maxDepth: maxDepth - 1);
    }

    return null;
  }

  /// Resolves [BorderRadius] from [widget], falling back to [fallback] or [BorderRadius.zero].
  static BorderRadius resolve(Widget? widget, {BorderRadius? explicit, BorderRadius fallback = BorderRadius.zero}) {
    if (explicit != null) return explicit;
    return autoDetect(widget) ?? fallback;
  }

  static BorderRadius? _inspectDirect(Widget widget) {
    if (widget is Container) {
      if (widget.decoration is BoxDecoration) {
        final boxDec = widget.decoration as BoxDecoration;
        if (boxDec.shape == BoxShape.circle) {
          return BorderRadius.circular(9999);
        }
        if (boxDec.borderRadius != null) {
          return boxDec.borderRadius!.resolve(TextDirection.ltr);
        }
      }
      if (widget.foregroundDecoration is BoxDecoration) {
        final boxDec = widget.foregroundDecoration as BoxDecoration;
        if (boxDec.shape == BoxShape.circle) {
          return BorderRadius.circular(9999);
        }
        if (boxDec.borderRadius != null) {
          return boxDec.borderRadius!.resolve(TextDirection.ltr);
        }
      }
    }

    if (widget is DecoratedBox) {
      if (widget.decoration is BoxDecoration) {
        final boxDec = widget.decoration as BoxDecoration;
        if (boxDec.shape == BoxShape.circle) {
          return BorderRadius.circular(9999);
        }
        if (boxDec.borderRadius != null) {
          return boxDec.borderRadius!.resolve(TextDirection.ltr);
        }
      }
    }

    if (widget is ClipRRect) {
      return widget.borderRadius.resolve(TextDirection.ltr);
    }

    if (widget is Card) {
      final shape = widget.shape;
      if (shape is RoundedRectangleBorder) {
        return shape.borderRadius.resolve(TextDirection.ltr);
      } else if (shape is CircleBorder) {
        return BorderRadius.circular(9999);
      }
    }

    if (widget is Material) {
      if (widget.borderRadius != null) {
        return widget.borderRadius!.resolve(TextDirection.ltr);
      }
      final shape = widget.shape;
      if (shape is RoundedRectangleBorder) {
        return shape.borderRadius.resolve(TextDirection.ltr);
      } else if (shape is CircleBorder) {
        return BorderRadius.circular(9999);
      }
    }

    if (widget is PhysicalModel) {
      if (widget.borderRadius != null) {
        return widget.borderRadius;
      }
      if (widget.shape == BoxShape.circle) {
        return BorderRadius.circular(9999);
      }
    }

    if (widget is InkWell) {
      if (widget.borderRadius != null) {
        return widget.borderRadius;
      }
    }

    if (widget is InkResponse) {
      if (widget.borderRadius != null) {
        return widget.borderRadius;
      }
    }

    if (widget is CircleAvatar) {
      return BorderRadius.circular(9999);
    }

    if (widget is ButtonStyleButton) {
      final shape = widget.style?.shape?.resolve({});
      if (shape is RoundedRectangleBorder) {
        return shape.borderRadius.resolve(TextDirection.ltr);
      } else if (shape is CircleBorder) {
        return BorderRadius.circular(9999);
      }
    }

    return null;
  }

  static Widget? _unwrapChild(Widget widget) {
    if (widget is Padding) return widget.child;
    if (widget is Center) return widget.child;
    if (widget is Align) return widget.child;
    if (widget is SizedBox) return widget.child;
    if (widget is RepaintBoundary) return widget.child;
    if (widget is ConstrainedBox) return widget.child;
    if (widget is FittedBox) return widget.child;
    if (widget is Transform) return widget.child;
    if (widget is Opacity) return widget.child;
    if (widget is AnimatedOpacity) return widget.child;
    if (widget is DefaultTextStyle) return widget.child;
    if (widget is AnimatedContainer) return widget.child;
    if (widget is IntrinsicWidth) return widget.child;
    if (widget is IntrinsicHeight) return widget.child;
    if (widget is Material) return widget.child;
    if (widget is Card) return widget.child;
    if (widget is DecoratedBox) return widget.child;
    if (widget is Container) return widget.child;
    return null;
  }
}
