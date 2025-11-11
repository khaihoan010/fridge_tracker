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
      onUpgrade: _upgradeDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // Create foods table
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

    // If version 2+, create nutrition tables
    if (version >= 2) {
      await _createNutritionTables(db);
    }
  }

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    // Upgrade from version 1 to 2 (add nutrition features)
    if (oldVersion < 2) {
      await _createNutritionTables(db);
    }
  }

  Future<void> _createNutritionTables(Database db) async {
    // Nutrition facts table
    await db.execute('''
      CREATE TABLE ${AppConstants.tableNutritionFacts} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        food_id INTEGER NOT NULL,

        -- Macros (per 100g)
        calories REAL DEFAULT 0,
        protein REAL DEFAULT 0,
        fat REAL DEFAULT 0,
        saturated_fat REAL DEFAULT 0,
        trans_fat REAL DEFAULT 0,
        carbohydrates REAL DEFAULT 0,
        fiber REAL DEFAULT 0,
        sugar REAL DEFAULT 0,
        sodium REAL DEFAULT 0,
        cholesterol REAL DEFAULT 0,

        -- Vitamins (per 100g)
        vitamin_a REAL DEFAULT 0,
        vitamin_b1 REAL DEFAULT 0,
        vitamin_b2 REAL DEFAULT 0,
        vitamin_b3 REAL DEFAULT 0,
        vitamin_b6 REAL DEFAULT 0,
        vitamin_b12 REAL DEFAULT 0,
        vitamin_c REAL DEFAULT 0,
        vitamin_d REAL DEFAULT 0,
        vitamin_e REAL DEFAULT 0,
        vitamin_k REAL DEFAULT 0,
        folate REAL DEFAULT 0,

        -- Minerals (per 100g)
        calcium REAL DEFAULT 0,
        iron REAL DEFAULT 0,
        magnesium REAL DEFAULT 0,
        phosphorus REAL DEFAULT 0,
        potassium REAL DEFAULT 0,
        zinc REAL DEFAULT 0,

        -- Metadata
        serving_size REAL DEFAULT 100,
        serving_unit TEXT DEFAULT 'g',
        health_score INTEGER DEFAULT 50,
        allergens TEXT,
        diet_tags TEXT,
        data_source TEXT,
        source_id TEXT,
        last_updated INTEGER,

        FOREIGN KEY (food_id) REFERENCES ${AppConstants.tableFoods}(id) ON DELETE CASCADE
      )
    ''');

    // Vitamin reference info
    await db.execute('''
      CREATE TABLE ${AppConstants.tableVitaminInfo} (
        code TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        name_vi TEXT,
        benefits TEXT,
        benefits_vi TEXT,
        rda_male REAL,
        rda_female REAL,
        rda_pregnant REAL,
        rda_lactating REAL,
        unit TEXT NOT NULL,
        icon TEXT,
        color TEXT
      )
    ''');

    // Mineral reference info
    await db.execute('''
      CREATE TABLE ${AppConstants.tableMineralInfo} (
        code TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        name_vi TEXT,
        benefits TEXT,
        benefits_vi TEXT,
        rda_male REAL,
        rda_female REAL,
        rda_pregnant REAL,
        rda_lactating REAL,
        unit TEXT NOT NULL,
        icon TEXT,
        color TEXT
      )
    ''');

    // Daily nutrition tracking
    await db.execute('''
      CREATE TABLE ${AppConstants.tableDailyNutrition} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL UNIQUE,
        total_calories REAL DEFAULT 0,
        total_protein REAL DEFAULT 0,
        total_fat REAL DEFAULT 0,
        total_carbs REAL DEFAULT 0,
        total_fiber REAL DEFAULT 0,
        foods_consumed TEXT,
        created_at INTEGER,
        updated_at INTEGER
      )
    ''');

    // User profile
    await db.execute('''
      CREATE TABLE ${AppConstants.tableUserProfile} (
        id INTEGER PRIMARY KEY CHECK (id = 1),
        gender TEXT DEFAULT 'female',
        age INTEGER,
        weight REAL,
        height REAL,
        activity_level TEXT,
        diet_type TEXT,
        allergies TEXT,
        health_goal TEXT,
        calorie_goal REAL,
        protein_goal REAL,
        carb_goal REAL,
        fat_goal REAL,
        created_at INTEGER,
        updated_at INTEGER
      )
    ''');

    // Create indexes for performance
    await db.execute('CREATE INDEX idx_nutrition_facts_food_id ON ${AppConstants.tableNutritionFacts}(food_id)');
    await db.execute('CREATE INDEX idx_daily_nutrition_date ON ${AppConstants.tableDailyNutrition}(date)');
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
