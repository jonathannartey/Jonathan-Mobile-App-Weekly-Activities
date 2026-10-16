// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:week1_project/main.dart';

void main() {
  testWidgets('Home page displays app content', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('INFT 425 - Jonathan Nartey'), findsOneWidget);
    expect(find.text('Hello World'), findsOneWidget);
    expect(
      find.text(
        'Department of Computing Sciences and Information Technology',
      ),
      findsOneWidget,
    );
  });
}
