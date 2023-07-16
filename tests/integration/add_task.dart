import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:intl/intl.dart';
import 'package:to_do/domain/models/task.dart';
import 'package:to_do/main_debug.dart' as app;
import 'package:to_do/presentation/common/task.dart';
import 'package:to_do/presentation/home_screen/home_screen.dart';
import 'package:to_do/presentation/home_screen/todo_list.dart';
import 'package:uuid/uuid.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Test of adding task', () {
    testWidgets('Press FAB to add task', (widgetTester) async {
      app.main();

      final id = const Uuid().v4();
      final Task task = Task(
        id: id,
        title: 'Task to test',
        importance: Priority.low,
        isCompleted: false,
      );

      final Finder targetFinder = find.byWidgetPredicate(
          (widget) => widget is TaskTile && widget.task.id == task.id);
      await widgetTester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(targetFinder, findsNothing);

      await widgetTester.tap(find.byType(FloatingActionButton));
      await widgetTester.pumpAndSettle();

      expect(find.byType(Title), findsOneWidget);
      expect(find.byType(Importance), findsOneWidget);
      expect(find.byType(Widget), findsOneWidget);

      await widgetTester.enterText(
        find.byType(TextFormField),
        task.title,
      );
      await widgetTester.pumpAndSettle();
      expect(find.text(task.title), findsOneWidget);

      await widgetTester.tap(
        find.text('Нет', findRichText: true),
      );
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Низкий', findRichText: true));
      await widgetTester.pumpAndSettle();
      expect(find.text('Низкий', findRichText: true), findsOneWidget);

      await widgetTester.tap(find.byType(Switch));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.widgetWithText(TextButton, 'Ок'));
      await widgetTester.pumpAndSettle();
      expect(
          find.text(DateFormat.yMMMMd().format(DateTime.now())), findsNothing);

      await widgetTester.tap(find.byType(TextButton));
      await widgetTester.pumpAndSettle();

      await widgetTester.dragUntilVisible(
        targetFinder,
        find.byType(ToDoList),
        const Offset(-3000, 0),
      );
      await widgetTester.pump(const Duration(seconds: 1));

      expect(targetFinder, findsOneWidget);
    });
  });
}
