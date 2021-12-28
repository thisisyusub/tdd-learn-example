import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_example/presentation/widgets/failure_widget.dart';

void main() {
  testWidgets(
    'should return a [Text] contains default message with [Center]',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: FailureWidget(),
        ),
      );

      final centerFinder = find.byType(Center);
      final textFinder = find.text('Something went wrong!');

      expect(centerFinder, findsOneWidget);
      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
    'should return a [Text] contains given message with [Center]',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: FailureWidget(
            message: 'Error!',
          ),
        ),
      );

      final centerFinder = find.byType(Center);
      final textFinder = find.text('Error!');

      expect(centerFinder, findsOneWidget);
      expect(textFinder, findsOneWidget);
    },
  );
}
