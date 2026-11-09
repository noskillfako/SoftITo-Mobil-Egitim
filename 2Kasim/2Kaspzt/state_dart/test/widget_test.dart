import 'package:flutter_test/flutter_test.dart';
import 'package:state_dart/main.dart';

void main() {
  testWidgets('Uygulama yüklenme testi', (WidgetTester tester) async {
    await tester.pumpWidget(const Uygulama());
    expect(find.text('Sepete Ekle'), findsOneWidget);
  });
}
