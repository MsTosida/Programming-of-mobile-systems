import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab010/auth/home.dart';

void main() {

  testWidgets('Drag bakery card', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: MyHomePage()));


    final textFieldFinder = find.byKey(Key("addField"));
    await tester.enterText(textFieldFinder, 'Test Bakery');
    await tester.tap(find.byKey(Key("addButton")));
    await tester.pumpAndSettle();

    final draggableFinder = find.byType(Draggable);
    await tester.drag(draggableFinder, Offset(0, 100));
    await tester.pumpAndSettle();


    expect(find.text('Test Bakery'), findsOneWidget);
  });

}