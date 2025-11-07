import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/food_item.dart';
import '../utils/constants.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, AppConstants.databaseName);

    return await openDatabase(
      path,
      version: AppConstants.databaseVersion,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${AppConstants.tableFoods} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        category TEXT NOT NULL,
        storage_location TEXT NOT NULL,
        purchase_date TEXT NOT NULL,
        expiry_date TEXT NOT NULL,
        image_path TEXT,
        barcode TEXT,
        quantity REAL NOT NULL,
        unit TEXT NOT NULL,
        notes TEXT
      )
    ''');
  }

  // CREATE - Thêm thực phẩm mới
  Future<int> insertFood(FoodItem food) async {
    final db = await database;
    return await db.insert(
      AppConstants.tableFoods,
      food.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // READ - Lấy tất cả thực phẩm
  Future<List<FoodItem>> getAllFoods() async {
    final db = await database;
    final maps = await db.query(
      AppConstants.tableFoods,
      orderBy: 'expiry_date ASC',
    );

    return List.generate(maps.length, (i) {
      return FoodItem.fromMap(maps[i]);
    });
  }

  // READ - Lấy thực phẩm theo ID
  Future<FoodItem?> getFoodById(int id) async {
    final db = await database;
    final maps = await db.query(
      AppConstants.tableFoods,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) return null;
    return FoodItem.fromMap(maps.first);
  }

  // READ - Lấy thực phẩm theo danh mục
  Future<List<FoodItem>> getFoodsByCategory(String category) async {
    final db = await database;
    final maps = await db.query(
      AppConstants.tableFoods,
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'expiry_date ASC',
    );

    return List.generate(maps.length, (i) {
      return FoodItem.fromMap(maps[i]);
    });
  }

  // READ - Lấy thực phẩm theo vị trí lưu trữ
  Future<List<FoodItem>> getFoodsByStorageLocation(String location) async {
    final db = await database;
    final maps = await db.query(
      AppConstants.tableFoods,
      where: 'storage_location = ?',
      whereArgs: [location],
      orderBy: 'expiry_date ASC',
    );

    return List.generate(maps.length, (i) {
      return FoodItem.fromMap(maps[i]);
    });
  }

  // READ - Tìm kiếm thực phẩm theo tên
  Future<List<FoodItem>> searchFoodsByName(String query) async {
    final db = await database;
    final maps = await db.query(
      AppConstants.tableFoods,
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
      orderBy: 'expiry_date ASC',
    );

    return List.generate(maps.length, (i) {
      return FoodItem.fromMap(maps[i]);
    });
  }

  // READ - Lấy thực phẩm sắp hết hạn (trong vòng X ngày)
  Future<List<FoodItem>> getExpiringSoonFoods(int daysThreshold) async {
    final db = await database;
    final now = DateTime.now();
    final threshold = now.add(Duration(days: daysThreshold));

    final maps = await db.query(
      AppConstants.tableFoods,
      where: 'expiry_date <= ? AND expiry_date >= ?',
      whereArgs: [
        threshold.toIso8601String(),
        now.toIso8601String(),
      ],
      orderBy: 'expiry_date ASC',
    );

    return List.generate(maps.length, (i) {
      return FoodItem.fromMap(maps[i]);
    });
  }

  // READ - Lấy thực phẩm đã hết hạn
  Future<List<FoodItem>> getExpiredFoods() async {
    final db = await database;
    final now = DateTime.now();

    final maps = await db.query(
      AppConstants.tableFoods,
      where: 'expiry_date < ?',
      whereArgs: [now.toIso8601String()],
      orderBy: 'expiry_date DESC',
    );

    return List.generate(maps.length, (i) {
      return FoodItem.fromMap(maps[i]);
    });
  }

  // UPDATE - Cập nhật thực phẩm
  Future<int> updateFood(FoodItem food) async {
    final db = await database;
    return await db.update(
      AppConstants.tableFoods,
      food.toMap(),
      where: 'id = ?',
      whereArgs: [food.id],
    );
  }

  // DELETE - Xóa thực phẩm
  Future<int> deleteFood(int id) async {
    final db = await database;
    return await db.delete(
      AppConstants.tableFoods,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // DELETE - Xóa tất cả thực phẩm đã hết hạn
  Future<int> deleteExpiredFoods() async {
    final db = await database;
    final now = DateTime.now();

    return await db.delete(
      AppConstants.tableFoods,
      where: 'expiry_date < ?',
      whereArgs: [now.toIso8601String()],
    );
  }

  // Thống kê - Đếm số lượng thực phẩm
  Future<int> getFoodCount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM ${AppConstants.tableFoods}');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  // Thống kê - Đếm số lượng thực phẩm theo danh mục
  Future<Map<String, int>> getFoodCountByCategory() async {
    final db = await database;
    final result = await db.rawQuery('''
      SELECT category, COUNT(*) as count
      FROM ${AppConstants.tableFoods}
      GROUP BY category
    ''');

    final Map<String, int> categoryCount = {};
    for (var row in result) {
      categoryCount[row['category'] as String] = row['count'] as int;
    }
    return categoryCount;
  }

  // Đóng database
  Future<void> close() async {
    final db = await database;
    await db.close();
  }

  // Xóa database (cho mục đích testing)
  Future<void> deleteDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, AppConstants.databaseName);
    await databaseFactory.deleteDatabase(path);
    _database = null;
  }
}
