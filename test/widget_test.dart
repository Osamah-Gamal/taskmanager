import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskmanager/main.dart'; // تأكد من المسار الصحيح للـ main.dart

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // بناء التطبيق وتجهيزه
    await tester.pumpWidget(TaskManagerApp());

    // تحقق من أن العداد يبدأ من 0
    expect(find.text('0'), findsOneWidget); // يجب أن تجد النص "0"
    expect(find.text('1'), findsNothing); // يجب ألا تجد النص "1"

    // الضغط على أيقونة الـ '+' لزيادة العداد
    await tester.tap(find.byIcon(Icons.add)); // النقر على الأيقونة
    await tester.pumpAndSettle(); // انتظار استقرار الواجهة وتحديث التطبيق

    // تحقق من أن العداد قد تم زيادته
    expect(find.text('0'), findsNothing); // يجب ألا تجد النص "0"
    expect(find.text('1'), findsOneWidget); // يجب أن تجد النص "1"
  });
}
