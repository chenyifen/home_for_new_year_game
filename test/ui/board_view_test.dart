import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_for_new_year_game/widgets/board_view.dart';

void main() {
  testWidgets('BoardView displays 6x6 grid', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: BoardView())));

    expect(find.byType(GridView), findsOneWidget);
    expect(find.byType(Container), findsNWidgets(36));
  });
}