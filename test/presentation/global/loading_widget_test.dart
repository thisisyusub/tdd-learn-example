import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_example/presentation/widgets/loading_widget.dart';

void main() {
  testWidgets(
    'should return a [CircularProgressIndicator] with '
    '[Center]',
    (WidgetTester tester) async {
      await tester.pumpWidget(const LoadingWidget());

      final centerFinder = find.byType(Center);
      final progressFinder = find.byType(CircularProgressIndicator);

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    },
  );
}
