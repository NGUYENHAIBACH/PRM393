import 'package:food_app/models/food.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'food_repository.g.dart';

const double popularRating = 4.5;

/// Nguồn dữ liệu Food (in-memory). State là danh sách Food hiện tại,
/// khi đổi favorite thì state đổi và mọi nơi đang watch sẽ tự cập nhật.
@Riverpod(keepAlive: true)
class FoodRepository extends _$FoodRepository {
  @override
  List<Food> build() => _seed;

  List<Food> getAll() => state;

  List<Food> getByCategory(String? categoryId) {
    if (categoryId == null) return state;
    return state.where((f) => f.categoryId == categoryId).toList();
  }

  List<Food> getPopular() =>
      state.where((f) => f.rating >= popularRating).toList();

  List<Food> getFavorites() => state.where((f) => f.isFavorite).toList();

  /// Tìm theo tên trong Category đang chọn (null = tất cả).
  List<Food> search({String? categoryId, String query = ''}) {
    final q = query.trim().toLowerCase();
    return getByCategory(
      categoryId,
    ).where((f) => f.name.toLowerCase().contains(q)).toList();
  }

  void toggleFavorite(String id) {
    state = [
      for (final f in state)
        if (f.id == id) f.toCopy(isFavorite: !f.isFavorite) else f,
    ];
  }
}

const List<Food> _seed = [
  Food(
    id: 'f1',
    image: 'assets/images/beef_burger.jpg',
    name: 'Beef Burger',
    categoryId: 'burger',
    description: 'Juicy beef patty, cheese, lettuce',
    emoji: '🍔',
    rating: 4.8,
    price: 8.50,
  ),
  Food(
    id: 'f2',
    image: 'assets/images/chicken_burger.jpg',
    name: 'Chicken Burger',
    categoryId: 'burger',
    description: 'Crispy chicken, mayo, pickles',
    emoji: '🍔',
    rating: 4.6,
    price: 7.50,
  ),
  Food(
    id: 'f3',
    image: 'assets/images/bbq_burger.jpg',
    name: 'BBQ Burger',
    categoryId: 'burger',
    description: 'Smoky BBQ sauce, onion rings',
    emoji: '🍔',
    rating: 4.3,
    price: 9.00,
  ),
  Food(
    id: 'f4',
    image: 'assets/images/fish_burger.jpg',
    name: 'Fish Burger',
    categoryId: 'burger',
    description: 'Fried fish fillet, tartar sauce',
    emoji: '🍔',
    rating: 4.1,
    price: 7.00,
  ),
  Food(
    id: 'f5',
    image: 'assets/images/margherita_pizza.jpg',
    name: 'Margherita Pizza',
    categoryId: 'pizza',
    description: 'Tomato, mozzarella, fresh basil',
    emoji: '🍕',
    rating: 4.7,
    price: 10.00,
  ),
  Food(
    id: 'f6',
    image: 'assets/images/pepperoni_pizza.jpg',
    name: 'Pepperoni Pizza',
    categoryId: 'pizza',
    description: 'Spicy pepperoni, extra cheese',
    emoji: '🍕',
    rating: 4.4,
    price: 11.50,
  ),
  Food(
    id: 'f7',
    image: 'assets/images/beef_noodle_soup.jpg',
    name: 'Beef Noodle Soup',
    categoryId: 'noodle',
    description: 'Rice noodles, beef broth, herbs',
    emoji: '🍜',
    rating: 4.9,
    price: 6.50,
  ),
  Food(
    id: 'f8',
    image: 'assets/images/fried_noodles.jpg',
    name: 'Fried Noodles',
    categoryId: 'noodle',
    description: 'Stir-fried noodles with vegetables',
    emoji: '🍜',
    rating: 4.2,
    price: 5.50,
  ),
  Food(
    id: 'f9',
    image: 'assets/images/spaghetti_bolognese.jpg',
    name: 'Spaghetti Bolognese',
    categoryId: 'pasta',
    description: 'Rich beef and tomato sauce',
    emoji: '🍝',
    rating: 4.5,
    price: 9.00,
  ),
  Food(
    id: 'f10',
    image: 'assets/images/carbonara.jpg',
    name: 'Carbonara',
    categoryId: 'pasta',
    description: 'Creamy egg sauce with bacon',
    emoji: '🍝',
    rating: 4.0,
    price: 9.50,
  ),
  Food(
    id: 'f11',
    image: 'assets/images/chocolate_cake.jpg',
    name: 'Chocolate Cake',
    categoryId: 'dessert',
    description: 'Moist chocolate layers, ganache',
    emoji: '🍰',
    rating: 4.6,
    price: 4.50,
  ),
  Food(
    id: 'f12',
    image: 'assets/images/iced_lemon_tea.jpg',
    name: 'Iced Lemon Tea',
    categoryId: 'drink',
    description: 'Fresh lemon, black tea, ice',
    emoji: '🥤',
    rating: 3.9,
    price: 2.50,
  ),
];
