import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/Widgets/food/category_item.dart';
import 'package:food_app/Widgets/food/food_card.dart';
import 'package:food_app/viewmodels/food_viewmodel.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  void _openFoods(WidgetRef ref, String? categoryId) {
    ref.read(foodViewModelProvider.notifier).selectCategory(categoryId);
    ref.read(mainNavProvider.notifier).select(1);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final categories = ref.watch(categoriesProvider);
    final popular = ref.watch(popularFoodsProvider);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, Guest! 👋',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('What would you like to eat today?'),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.notifications_none),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            readOnly: true,
            onTap: () => _openFoods(ref, null),
            decoration: InputDecoration(
              hintText: 'Search food',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: scheme.surfaceContainerHighest,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _SectionHeader(
            title: 'Categories',
            onSeeAll: () => _openFoods(ref, null),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 92,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, i) => CategoryItem(
                category: categories[i],
                onTap: () => _openFoods(ref, categories[i].id),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: scheme.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Delicious\nFood For You',
                        style: TextStyle(
                          color: scheme.onPrimary,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Fresh ingredients, fast delivery',
                        style: TextStyle(color: scheme.onPrimary),
                      ),
                      const SizedBox(height: 12),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: scheme.onPrimary,
                          foregroundColor: scheme.primary,
                        ),
                        onPressed: () => _openFoods(ref, null),
                        child: const Text('Order Now'),
                      ),
                    ],
                  ),
                ),
                const Text('🍔 Nheng', style: TextStyle(fontSize: 72)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _SectionHeader(
            title: 'Popular Foods',
            onSeeAll: () => _openFoods(ref, null),
          ),
          const SizedBox(height: 12),
          for (final food in popular) ...[
            FoodCard(food: food),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;

  const _SectionHeader({required this.title, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(onPressed: onSeeAll, child: const Text('See All')),
      ],
    );
  }
}
