class Food {
  final String id;
  final String name;
  final String categoryId;
  final String description;
  final String emoji;
  final double rating;
  final double price;
  final bool isFavorite;
  final String? image;

  const Food({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.description,
    this.image,
    required this.emoji,
    required this.rating,
    required this.price,
    this.isFavorite = false,
  });
  Food toCopy({bool? isFavorite}) {
    return Food(
      id: id,
      name: name,
      categoryId: categoryId,
      description: description,
      emoji: emoji,
      rating: rating,
      price: price,
      isFavorite: isFavorite ?? this.isFavorite,
      image: image,
    );
  }

  /// Chuyển đổi Food thành Map để lưu vào SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'categoryId': categoryId,
      'description': description,
      'emoji': emoji,
      'rating': rating,
      'price': price,
      'isFavorite': isFavorite ? 1 : 0,
      'image': image,
    };
  }

  /// Khởi tạo Food từ Map lấy từ SQLite
  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      id: map['id'] as String,
      name: map['name'] as String,
      categoryId: map['categoryId'] as String,
      description: map['description'] as String? ?? '',
      emoji: map['emoji'] as String? ?? '',
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      isFavorite: map['isFavorite'] == 1 || map['isFavorite'] == true,
      image: map['image'] as String?,
    );
  }
}
