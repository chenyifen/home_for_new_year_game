import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_for_new_year_game/screens/initial_screen.dart';

void main() {
  testWidgets('InitialScreen has title and board view', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: InitialScreen()));

    expect(find.text('回家过年'), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
  });
}