import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/Widgets/food/food_card.dart';
import 'package:food_app/viewmodels/food_viewmodel.dart';

class FoodsPage extends ConsumerStatefulWidget {
  const FoodsPage({super.key});

  @override
  ConsumerState<FoodsPage> createState() => _FoodsPageState();
}

class _FoodsPageState extends ConsumerState<FoodsPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final filter = ref.watch(foodViewModelProvider);
    final category = ref.watch(selectedCategoryProvider);
    final foods = ref.watch(filteredFoodsProvider);

    // Giữ ô tìm kiếm đồng bộ khi bộ lọc bị đổi từ nơi khác (vd: chọn Category).
    ref.listen(foodViewModelProvider, (_, next) {
      if (_searchController.text != next.query) {
        _searchController.text = next.query;
      }
    });

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => ref.read(mainNavProvider.notifier).select(0),
                ),
                const Expanded(
                  child: Text(
                    'Foods',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (v) =>
                  ref.read(foodViewModelProvider.notifier).setQuery(v),
              decoration: InputDecoration(
                hintText: category == null
                    ? 'Search food'
                    : 'Search in ${category.name}',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: filter.query.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () =>
                            ref.read(foodViewModelProvider.notifier).setQuery(''),
                      ),
                filled: true,
                fillColor: scheme.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.tune, size: 20),
                const SizedBox(width: 8),
                Text(
                  category == null ? 'All Foods' : category.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                if (category != null)
                  TextButton(
                    onPressed: () => ref
                        .read(foodViewModelProvider.notifier)
                        .selectCategory(null),
                    child: const Text('All'),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: foods.isEmpty
                ? const Center(child: Text('No food found'))
                : LayoutBuilder(
                    builder: (context, constraints) {
                      // < 700: 1 cột (List), >= 700: 2 cột (Grid).
                      if (constraints.maxWidth < 700) {
                        return ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: foods.length,
                          separatorBuilder: (_, _) => const SizedBox(height: 10),
                          itemBuilder: (_, i) => FoodCard(food: foods[i]),
                        );
                      }
                      return GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              mainAxisExtent: 110,
                            ),
                        itemCount: foods.length,
                        itemBuilder: (_, i) => FoodCard(food: foods[i]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
