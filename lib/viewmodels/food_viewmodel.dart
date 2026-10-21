import 'package:food_app/models/category.dart';
import 'package:food_app/models/food.dart';
import 'package:food_app/repositories/category_repository.dart';
import 'package:food_app/repositories/food_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'food_viewmodel.g.dart';

/// Bộ lọc của Foods Page: Category đang chọn (null = All) và từ khóa tìm kiếm.
class FoodFilter {
  final String? categoryId;
  final String query;

  const FoodFilter({this.categoryId, this.query = ''});
}

@riverpod
class FoodViewModel extends _$FoodViewModel {
  @override
  FoodFilter build() => const FoodFilter();

  /// Chọn Category (null = All). Đổi Category thì xóa từ khóa tìm kiếm.
  void selectCategory(String? categoryId) {
    state = FoodFilter(categoryId: categoryId);
  }

  void setQuery(String query) {
    state = FoodFilter(categoryId: state.categoryId, query: query);
  }

  void toggleFavorite(String foodId) {
    ref.read(foodRepositoryProvider.notifier).toggleFavorite(foodId);
  }
}

/// Danh sách Category (hiển thị ngang ở Home).
@riverpod
List<Category> categories(Ref ref) {
  return ref.watch(categoryRepositoryProvider).getAll();
}

/// Category đang chọn (null nếu là All).
@riverpod
Category? selectedCategory(Ref ref) {
  final id = ref.watch(foodViewModelProvider).categoryId;
  return ref.watch(categoryRepositoryProvider).getById(id);
}

/// Popular Foods: rating >= 4.5.
@riverpod
List<Food> popularFoods(Ref ref) {
  ref.watch(foodRepositoryProvider);
  return ref.read(foodRepositoryProvider.notifier).getPopular();
}

/// Food hiển thị ở Foods Page theo Category + từ khóa.
@riverpod
List<Food> filteredFoods(Ref ref) {
  final filter = ref.watch(foodViewModelProvider);
  ref.watch(foodRepositoryProvider);
  return ref
      .read(foodRepositoryProvider.notifier)
      .search(categoryId: filter.categoryId, query: filter.query);
}

/// Tab đang chọn của BottomNavigationBar: 0 Home, 1 Foods, 2 Favorite, 3 Profile.
@riverpod
class MainNav extends _$MainNav {
  @override
  int build() => 0;

  void select(int index) => state = index;
}
