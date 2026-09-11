import 'dart:ui';
import 'package:flutter/material.dart';

/// Helper utility for extracting and manipulating [Path] and [PathMetric] objects
/// for animated borders.
class ZoPathHelper {
  ZoPathHelper._();

  /// Creates a closed [Path] for a given [Size] and [BorderRadius], optionally deflating by [inset].
  static Path createRRectPath(
    Size size,
    BorderRadius borderRadius, {
    double inset = 0.0,
  }) {
    if (size.isEmpty) return Path();
    final rect = Offset.zero & size;
    final targetRect = inset > 0 ? rect.deflate(inset) : rect;
    final rrect = borderRadius.toRRect(targetRect);
    return Path()..addRRect(rrect);
  }

  /// Extracts a sub-path from [metric] between [start] and [end] distances along the path.
  ///
  /// If [end] is less than [start] (indicating a wrap-around along a closed loop),
  /// it seamlessly extracts from [start] to [metric.length] and adds the segment
  /// from 0.0 to [end].
  static Path extractLoopedSubPath(
    PathMetric metric,
    double start,
    double end,
  ) {
    final length = metric.length;
    if (length <= 0) return Path();

    // Normalize start and end to [0, length)
    final normStart = start % length;
    final normEnd = end % length;

    if (normEnd > normStart) {
      return metric.extractPath(normStart, normEnd);
    } else if (normEnd < normStart) {
      final path = Path();
      path.addPath(metric.extractPath(normStart, length), Offset.zero);
      path.addPath(metric.extractPath(0.0, normEnd), Offset.zero);
      return path;
    } else {
      // If start and end are equal, extract nothing (or full path if intentional)
      return Path();
    }
  }

  /// Extracts a sub-path using normalized values:
  /// - [progress]: 0.0 to 1.0 (starting position ratio)
  /// - [span]: length ratio of the segment (e.g. 0.25 for 25% of total path)
  static Path extractLoopedNormalized(
    PathMetric metric,
    double progress,
    double span,
  ) {
    final length = metric.length;
    if (length <= 0) return Path();

    final normProgress = progress % 1.0;
    final start = normProgress * length;
    final end = (start + span * length) % length;

    return extractLoopedSubPath(metric, start, end);
  }

  /// Computes tangent position at a given offset along the [metric].
  static Offset getTangentPosition(PathMetric metric, double offset) {
    if (metric.length <= 0) return Offset.zero;
    final normOffset = offset % metric.length;
    return metric.getTangentForOffset(normOffset)?.position ?? Offset.zero;
  }
}
