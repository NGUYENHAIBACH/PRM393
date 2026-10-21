import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/Screens/foods_page.dart';
import 'package:food_app/Screens/home_page.dart';
import 'package:food_app/viewmodels/food_viewmodel.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(mainNavProvider);

    final pages = <Widget>[
      const HomePage(),
      const FoodsPage(),
      const _PlaceholderPage(title: 'Favorite'),
      const _PlaceholderPage(title: 'Profile'),
    ];

    return Scaffold(
      body: IndexedStack(index: currentTab, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          // Bấm tab Foods từ thanh điều hướng thì hiển thị tất cả Food.
          if (index == 1 && currentTab != 1) {
            ref.read(foodViewModelProvider.notifier).selectCategory(null);
          }
          ref.read(mainNavProvider.notifier).select(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Foods',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  final String title;

  const _PlaceholderPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}
