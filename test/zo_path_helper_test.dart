import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zo_animated_border/util/zo_path_helper.dart';

void main() {
  group('ZoPathHelper', () {
    test('createRRectPath creates valid path for given size and radius', () {
      final path = ZoPathHelper.createRRectPath(
        const Size(100, 100),
        BorderRadius.circular(10),
      );
      expect(path, isNotNull);
      final metrics = path.computeMetrics().toList();
      expect(metrics.isNotEmpty, isTrue);
      expect(metrics.first.length, greaterThan(0));
    });

    test('extractLoopedSubPath handles standard non-wrapping range', () {
      final path = Path()..addRect(const Rect.fromLTWH(0, 0, 100, 100));
      final metric = path.computeMetrics().first;

      final subPath = ZoPathHelper.extractLoopedSubPath(
        metric,
        10,
        50,
      );

      final subMetrics = subPath.computeMetrics().toList();
      expect(subMetrics.isNotEmpty, isTrue);
      expect(subMetrics.first.length, closeTo(40, 0.5));
    });

    test('extractLoopedSubPath handles wrap-around range across loop boundary', () {
      final path = Path()..addRect(const Rect.fromLTWH(0, 0, 100, 100));
      final metric = path.computeMetrics().first;
      final totalLength = metric.length;

      // start near end, end near start
      final start = totalLength - 20;
      const end = 30.0;

      final subPath = ZoPathHelper.extractLoopedSubPath(
        metric,
        start,
        end,
      );

      final subMetrics = subPath.computeMetrics().toList();
      expect(subMetrics.isNotEmpty, isTrue);
      // Total extracted length should be (20 + 30) = 50
      final extractedLength = subMetrics.fold<double>(0, (sum, m) => sum + m.length);
      expect(extractedLength, closeTo(50, 0.5));
    });

    test('extractLoopedNormalized extracts subpath based on progress and span', () {
      final path = Path()..addRect(const Rect.fromLTWH(0, 0, 100, 100));
      final metric = path.computeMetrics().first;
      final totalLength = metric.length;

      final subPath = ZoPathHelper.extractLoopedNormalized(
        metric,
        0.9, // starts at 90%
        0.2, // spans 20% (wraps around to 10%)
      );

      final subMetrics = subPath.computeMetrics().toList();
      expect(subMetrics.isNotEmpty, isTrue);
      final extractedLength = subMetrics.fold<double>(0, (sum, m) => sum + m.length);
      expect(extractedLength, closeTo(totalLength * 0.2, 0.5));
    });

    test('getTangentPosition returns correct position', () {
      final path = Path()..addRect(const Rect.fromLTWH(0, 0, 100, 100));
      final metric = path.computeMetrics().first;

      final pos = ZoPathHelper.getTangentPosition(metric, 0);
      expect(pos, const Offset(0, 0));
    });
  });
}
