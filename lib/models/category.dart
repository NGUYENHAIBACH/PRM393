class Category {
  final String id;
  final String name;
  final String emoji;
  final String? image;
  const Category({required this.id, required this.name, required this.emoji, this.image});

  /// Chuyển đổi Category thành Map để lưu vào SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'emoji': emoji,
      'image': image,
    };
  }

  /// Khởi tạo Category từ Map lấy từ SQLite
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as String,
      name: map['name'] as String,
      emoji: map['emoji'] as String? ?? '',
      image: map['image'] as String?,
    );
  }
}
