import 'package:food_app/models/category.dart';
import 'package:food_app/models/food.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataHelper {
  // Singleton Pattern
  static final DataHelper instance = DataHelper._init();
  static Database? _database;

  DataHelper._init();

  // Cho phép gọi constructor DataHelper() hoặc DataHelper.instance
  factory DataHelper() => instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'food_app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // ==========================================
  // 1. TẠO BẢNG (CREATE TABLE)
  // ==========================================
  Future<void> _onCreate(Database db, int version) async {
    // Tạo bảng foods
    await db.execute('''
      CREATE TABLE foods (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        categoryId TEXT NOT NULL,
        description TEXT,
        emoji TEXT,
        rating REAL,
        price REAL,
        isFavorite INTEGER NOT NULL DEFAULT 0,
        image TEXT
      )
    ''');

    // Tạo bảng categories
    await db.execute('''
      CREATE TABLE categories (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        emoji TEXT,
        image TEXT
      )
    ''');
  }

  // ==========================================
  // 2. THÊM DỮ LIỆU (INSERT / CREATE)
  // ==========================================

  /// Thêm 1 món ăn (Dùng hàm có sẵn của sqflite)
  Future<int> insertFood(Food food) async {
    final db = await database;
    return await db.insert(
      'foods',
      food.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Thêm món ăn bằng CÂU LỆNH RAW SQL
  Future<int> rawInsertFood(Food food) async {
    final db = await database;
    return await db.rawInsert(
      '''
      INSERT INTO foods (id, name, categoryId, description, emoji, rating, price, isFavorite, image)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
      ''',
      [
        food.id,
        food.name,
        food.categoryId,
        food.description,
        food.emoji,
        food.rating,
        food.price,
        food.isFavorite ? 1 : 0,
        food.image,
      ],
    );
  }

  /// Thêm nhiều món ăn cùng lúc (dùng Batch để tối ưu hiệu năng)
  Future<void> insertFoods(List<Food> foods) async {
    final db = await database;
    final batch = db.batch();
    for (final food in foods) {
      batch.insert(
        'foods',
        food.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  // ==========================================
  // 3. TRUY VẤN DỮ LIỆU (QUERY / READ)
  // ==========================================

  /// Lấy tất cả món ăn (Dùng query)
  Future<List<Food>> getAllFoods() async {
    final db = await database;
    final result = await db.query('foods');
    return result.map((map) => Food.fromMap(map)).toList();
  }

  /// Lấy tất cả món ăn bằng CÂU LỆNH RAW SQL
  Future<List<Food>> rawGetAllFoods() async {
    final db = await database;
    final result = await db.rawQuery('SELECT * FROM foods');
    return result.map((map) => Food.fromMap(map)).toList();
  }

  /// Lấy món ăn theo ID
  Future<Food?> getFoodById(String id) async {
    final db = await database;
    final maps = await db.query(
      'foods',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Food.fromMap(maps.first);
    }
    return null;
  }

  /// Lấy danh sách món ăn theo danh mục (categoryId)
  Future<List<Food>> getFoodsByCategory(String categoryId) async {
    final db = await database;
    final result = await db.query(
      'foods',
      where: 'categoryId = ?',
      whereArgs: [categoryId],
    );
    return result.map((map) => Food.fromMap(map)).toList();
  }

  /// Lấy danh sách món ăn yêu thích (isFavorite = 1)
  Future<List<Food>> getFavoriteFoods() async {
    final db = await database;
    final result = await db.query(
      'foods',
      where: 'isFavorite = ?',
      whereArgs: [1],
    );
    return result.map((map) => Food.fromMap(map)).toList();
  }

  /// Lấy danh sách món ăn phổ biến (rating >= minRating)
  Future<List<Food>> getPopularFoods({double minRating = 4.5}) async {
    final db = await database;
    final result = await db.query(
      'foods',
      where: 'rating >= ?',
      whereArgs: [minRating],
      orderBy: 'rating DESC',
    );
    return result.map((map) => Food.fromMap(map)).toList();
  }

  /// Tìm kiếm món ăn theo tên và danh mục
  Future<List<Food>> searchFoods(String query, {String? categoryId}) async {
    final db = await database;
    final trimmed = query.trim();

    String whereClause = 'name LIKE ?';
    List<Object?> whereArgs = ['%$trimmed%'];

    if (categoryId != null && categoryId.isNotEmpty) {
      whereClause += ' AND categoryId = ?';
      whereArgs.add(categoryId);
    }

    final result = await db.query(
      'foods',
      where: whereClause,
      whereArgs: whereArgs,
    );
    return result.map((map) => Food.fromMap(map)).toList();
  }

  // ==========================================
  // 4. CẬP NHẬT DỮ LIỆU (UPDATE)
  // ==========================================

  /// Sửa thông tin món ăn (Dùng hàm có sẵn của sqflite)
  Future<int> updateFood(Food food) async {
    final db = await database;
    return await db.update(
      'foods',
      food.toMap(),
      where: 'id = ?',
      whereArgs: [food.id],
    );
  }

  /// Sửa món ăn bằng CÂU LỆNH RAW SQL
  Future<int> rawUpdateFood(Food food) async {
    final db = await database;
    return await db.rawUpdate(
      '''
      UPDATE foods
      SET name = ?, categoryId = ?, description = ?, emoji = ?, rating = ?, price = ?, isFavorite = ?, image = ?
      WHERE id = ?
      ''',
      [
        food.name,
        food.categoryId,
        food.description,
        food.emoji,
        food.rating,
        food.price,
        food.isFavorite ? 1 : 0,
        food.image,
        food.id,
      ],
    );
  }

  /// Cập nhật nhanh trạng thái yêu thích của món ăn
  Future<int> updateFavoriteStatus(String id, bool isFavorite) async {
    final db = await database;
    return await db.update(
      'foods',
      {'isFavorite': isFavorite ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ==========================================
  // 5. XÓA DỮ LIỆU (DELETE)
  // ==========================================

  /// Xóa món ăn theo ID (Dùng hàm có sẵn của sqflite)
  Future<int> deleteFood(String id) async {
    final db = await database;
    return await db.delete(
      'foods',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Xóa món ăn bằng CÂU LỆNH RAW SQL
  Future<int> rawDeleteFood(String id) async {
    final db = await database;
    return await db.rawDelete(
      'DELETE FROM foods WHERE id = ?',
      [id],
    );
  }

  /// Xóa tất cả các món ăn trong bảng
  Future<int> deleteAllFoods() async {
    final db = await database;
    return await db.delete('foods');
  }

  // ==========================================
  // 6. THAO TÁC VỚI CATEGORY
  // ==========================================

  Future<int> insertCategory(Category category) async {
    final db = await database;
    return await db.insert(
      'categories',
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Category>> getAllCategories() async {
    final db = await database;
    final result = await db.query('categories');
    return result.map((map) => Category.fromMap(map)).toList();
  }

  Future<Category?> getCategoryById(String id) async {
    final db = await database;
    final maps = await db.query(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Category.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateCategory(Category category) async {
    final db = await database;
    return await db.update(
      'categories',
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  Future<int> deleteCategory(String id) async {
    final db = await database;
    return await db.delete(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ==========================================
  // 7. ĐÓNG DATABASE
  // ==========================================
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}

/// Alias để tương thích tên gọi Datahelper hoặc DataHelper
typedef Datahelper = DataHelper;