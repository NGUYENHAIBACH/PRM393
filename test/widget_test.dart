import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_app/main.dart';

void main() {
  testWidgets('Home -> category -> Foods, search and favorite', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Home: Popular Foods chỉ có rating >= 4.5 (cuộn xuống tới phần Popular)
    final homeList = find.byType(Scrollable).first;
    await tester.scrollUntilVisible(
      find.text('Popular Foods'),
      300,
      scrollable: homeList,
    );
    expect(find.text('Popular Foods'), findsOneWidget);
    expect(find.text('Fish Burger'), findsNothing);
    await tester.drag(homeList, const Offset(0, 3000));   // cuộn lại lên đầu
    await tester.pumpAndSettle();

    // Chọn Category Burger -> sang Foods Page, chỉ có Burger
    await tester.tap(find.text('Burger').first);
    await tester.pumpAndSettle();
    expect(find.text('Fish Burger'), findsOneWidget);
    expect(find.text('Margherita Pizza'), findsNothing);

    // Tìm kiếm trong Category
    await tester.enterText(find.byType(TextField), 'bbq');
    await tester.pump();
    expect(find.text('BBQ Burger'), findsOneWidget);
    expect(find.text('Fish Burger'), findsNothing);

    // Favorite cập nhật biểu tượng
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();
    expect(find.byIcon(Icons.favorite), findsWidgets);
  });
}
