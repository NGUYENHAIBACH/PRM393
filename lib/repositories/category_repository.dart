import 'package:food_app/models/category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_repository.g.dart';

class CategoryRepository {
  final List<Category> _categories = const [
    Category(id: 'burger', name: 'Burger', emoji: '🍔'),
    Category(id: 'pizza', name: 'Pizza', emoji: '🍕'),
    Category(id: 'noodle', name: 'Noodle', emoji: '🍜'),
    Category(id: 'pasta', name: 'Pasta', emoji: '🍝'),
    Category(id: 'dessert', name: 'Dessert', emoji: '🍰'),
    Category(id: 'drink', name: 'Drink', emoji: '🥤'),
  ];

  List<Category> getAll() => _categories;

  Category? getById(String? id) {
    for (final c in _categories) {
      if (c.id == id) return c;
    }
    return null;
  }
}

@Riverpod(keepAlive: true)
CategoryRepository categoryRepository(Ref ref) => CategoryRepository();
