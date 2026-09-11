import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zo_animated_border/util/zo_border_radius_resolver.dart';

void main() {
  group('ZoBorderRadiusResolver', () {
    test('detects borderRadius from Container with BoxDecoration', () {
      final widget = Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
      );
      final radius = ZoBorderRadiusResolver.autoDetect(widget);
      expect(radius, BorderRadius.circular(16));
    });

    test('detects circular borderRadius from Container with BoxShape.circle', () {
      final widget = Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
      );
      final radius = ZoBorderRadiusResolver.autoDetect(widget);
      expect(radius, BorderRadius.circular(9999));
    });

    test('detects borderRadius from ClipRRect', () {
      final widget = ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: const SizedBox(),
      );
      final radius = ZoBorderRadiusResolver.autoDetect(widget);
      expect(radius, BorderRadius.circular(24));
    });

    test('detects borderRadius from Card with RoundedRectangleBorder', () {
      final widget = Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: const SizedBox(),
      );
      final radius = ZoBorderRadiusResolver.autoDetect(widget);
      expect(radius, BorderRadius.circular(12));
    });

    test('detects borderRadius from Material', () {
      final widget = Material(
        borderRadius: BorderRadius.circular(8),
        child: const SizedBox(),
      );
      final radius = ZoBorderRadiusResolver.autoDetect(widget);
      expect(radius, BorderRadius.circular(8));
    });

    test('detects nested borderRadius through wrappers', () {
      final widget = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SizedBox(
            width: 100,
            height: 100,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      );
      final radius = ZoBorderRadiusResolver.autoDetect(widget);
      expect(radius, BorderRadius.circular(20));
    });

    test('returns null when no radius is present', () {
      const widget = Text('Hello World');
      final radius = ZoBorderRadiusResolver.autoDetect(widget);
      expect(radius, isNull);
    });

    test('resolve uses fallback when no radius detected', () {
      const widget = Text('Hello World');
      final radius = ZoBorderRadiusResolver.resolve(widget, fallback: BorderRadius.circular(4));
      expect(radius, BorderRadius.circular(4));
    });

    test('resolve honors explicit radius when provided', () {
      final widget = Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
      );
      final radius = ZoBorderRadiusResolver.resolve(widget, explicit: BorderRadius.circular(30));
      expect(radius, BorderRadius.circular(30));
    });
  });
}
