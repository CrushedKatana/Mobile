// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:master_plan/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  // Build the MasterPlan app and trigger a frame.
  await tester.pumpWidget(const MasterPlanApp());

  // There should be an add button (FloatingActionButton).
  expect(find.byIcon(Icons.add), findsOneWidget);

  // Tap the add button to create a new empty task and rebuild.
  await tester.tap(find.byIcon(Icons.add));
  await tester.pump();

  // After adding, a TextFormField (for task description) should be present.
  expect(find.byType(TextFormField), findsWidgets);
  });
}
