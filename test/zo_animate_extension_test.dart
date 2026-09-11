import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

void main() {
  group('ZoAnimatedBorderExtension Tests', () {
    testWidgets('Fluent .zoAnimate().snake() builds correctly with auto-detected radius', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.blue,
              ),
              child: const Text('Test Child'),
            ).zoAnimate().snake(
              snakeHeadColor: Colors.amber,
              snakeTailColor: Colors.purple,
            ),
          ),
        ),
      );

      expect(find.byType(ZoSnakeBorder), findsOneWidget);
      expect(find.text('Test Child'), findsOneWidget);

      final snakeWidget = tester.widget<ZoSnakeBorder>(find.byType(ZoSnakeBorder));
      expect(snakeWidget.borderRadius, BorderRadius.circular(16));
      expect(snakeWidget.snakeHeadColor, Colors.amber);
      expect(snakeWidget.snakeTailColor, Colors.purple);
    });

    testWidgets('Direct widget extension .zoSnakeBorder() works', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text('Direct Snake'),
            ).zoSnakeBorder(
              snakeHeadColor: Colors.red,
            ),
          ),
        ),
      );

      expect(find.byType(ZoSnakeBorder), findsOneWidget);
      expect(find.text('Direct Snake'), findsOneWidget);

      final snakeWidget = tester.widget<ZoSnakeBorder>(find.byType(ZoSnakeBorder));
      expect(snakeWidget.borderRadius, BorderRadius.circular(20));
      expect(snakeWidget.snakeHeadColor, Colors.red);
    });

    testWidgets('Fluent .zoAnimate().dual() builds correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Text('Dual Border'),
            ).zoAnimate().dual(
              firstBorderColor: Colors.red,
              secondBorderColor: Colors.blue,
            ),
          ),
        ),
      );

      expect(find.byType(ZoDualBorder), findsOneWidget);
      expect(find.text('Dual Border'), findsOneWidget);

      final dualWidget = tester.widget<ZoDualBorder>(find.byType(ZoDualBorder));
      expect(dualWidget.borderRadius, BorderRadius.circular(14));
      expect(dualWidget.firstBorderColor, Colors.red);
      expect(dualWidget.secondBorderColor, Colors.blue);
    });

    testWidgets('Fluent .zoAnimate().glowEdge() builds correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('Glow Edge'),
            ).zoAnimate().glowEdge(
              gradientColors: [Colors.cyan, Colors.purple],
            ),
          ),
        ),
      );

      expect(find.byType(ZoGlowingEdgeBorder), findsOneWidget);
      expect(find.text('Glow Edge'), findsOneWidget);

      final glowWidget = tester.widget<ZoGlowingEdgeBorder>(find.byType(ZoGlowingEdgeBorder));
      expect(glowWidget.borderRadius, 8.0);
    });

    testWidgets('Chaining multiple borders works seamlessly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('Chained'),
            )
                .zoAnimate()
                .snake(snakeHeadColor: Colors.cyan)
                .dual(firstBorderColor: Colors.purple),
          ),
        ),
      );

      expect(find.byType(ZoSnakeBorder), findsOneWidget);
      expect(find.byType(ZoDualBorder), findsOneWidget);
      expect(find.text('Chained'), findsOneWidget);
    });

    testWidgets('ZoAnimatedBorder widget and .border() method work', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ZoAnimatedBorder(
                  type: ZoBorderType.snake,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text('Widget Way'),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text('Fluent Border'),
                ).zoAnimate().border(type: ZoBorderType.dual),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(ZoSnakeBorder), findsOneWidget);
      expect(find.byType(ZoDualBorder), findsOneWidget);
      expect(find.text('Widget Way'), findsOneWidget);
      expect(find.text('Fluent Border'), findsOneWidget);
    });
  });
}
