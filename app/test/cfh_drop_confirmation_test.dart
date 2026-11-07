import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localsend_app/pages/home_page.dart';

void main() {
  for (final entry in {'Cancel drop': false, 'Add folders': true}.entries) {
    testWidgets('Folder drop: ${entry.key}', (tester) async {
      bool? result;
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: Builder(
        builder: (context) => TextButton(
          onPressed: () async { result = await confirmDroppedFolders(context, 2); },
          child: const Text('Open'),
        ),
      ))));
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.textContaining('2 folder(s)'), findsOneWidget);
      expect(find.textContaining('discard all files and folders'), findsOneWidget);
      await tester.tap(find.text(entry.key));
      await tester.pumpAndSettle();
      expect(result, entry.value);
    });
  }
}