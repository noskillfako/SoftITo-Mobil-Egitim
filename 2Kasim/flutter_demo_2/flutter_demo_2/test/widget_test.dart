import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_demo_2/main.dart';

void main() {
  testWidgets('Uygulama yüklenme testi', (WidgetTester tester) async {
    await tester.pumpWidget(const Uygulama());
    expect(find.text('Ürün Listesi'), findsOneWidget);
  });
}
