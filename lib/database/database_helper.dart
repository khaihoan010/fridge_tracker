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
      await _seedReferenceData(db);
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

  /// Seed reference data for vitamins and minerals
  Future<void> _seedReferenceData(Database db) async {
    print('🌱 Seeding vitamin & mineral reference data...');

    // Seed Vitamins
    await _seedVitamins(db);

    // Seed Minerals
    await _seedMinerals(db);

    print('✅ Reference data seeded successfully!');
  }

  Future<void> _seedVitamins(Database db) async {
    final vitamins = [
      {
        'code': 'A',
        'name': 'Vitamin A',
        'name_vi': 'Vitamin A',
        'benefits': 'Essential for vision, immune function, reproduction',
        'benefits_vi': 'Cần thiết cho thị lực, miễn dịch, sinh sản',
        'rda_male': 900.0,
        'rda_female': 700.0,
        'rda_pregnant': 770.0,
        'rda_lactating': 1300.0,
        'unit': 'mcg',
        'icon': '🥕',
        'color': '#FF9500',
      },
      {
        'code': 'B1',
        'name': 'Thiamin (B1)',
        'name_vi': 'Thiamin (B1)',
        'benefits': 'Helps convert nutrients into energy',
        'benefits_vi': 'Giúp chuyển đổi chất dinh dưỡng thành năng lượng',
        'rda_male': 1.2,
        'rda_female': 1.1,
        'rda_pregnant': 1.4,
        'rda_lactating': 1.4,
        'unit': 'mg',
        'icon': '🌾',
        'color': '#F0E68C',
      },
      {
        'code': 'B2',
        'name': 'Riboflavin (B2)',
        'name_vi': 'Riboflavin (B2)',
        'benefits': 'Helps convert food into energy, important for skin',
        'benefits_vi': 'Chuyển hóa thức ăn thành năng lượng, tốt cho da',
        'rda_male': 1.3,
        'rda_female': 1.1,
        'rda_pregnant': 1.4,
        'rda_lactating': 1.6,
        'unit': 'mg',
        'icon': '🥛',
        'color': '#FFE4B5',
      },
      {
        'code': 'B3',
        'name': 'Niacin (B3)',
        'name_vi': 'Niacin (B3)',
        'benefits': 'Supports digestive system, skin, and nerves',
        'benefits_vi': 'Hỗ trợ tiêu hóa, da và thần kinh',
        'rda_male': 16.0,
        'rda_female': 14.0,
        'rda_pregnant': 18.0,
        'rda_lactating': 17.0,
        'unit': 'mg',
        'icon': '🍗',
        'color': '#D2691E',
      },
      {
        'code': 'B6',
        'name': 'Vitamin B6',
        'name_vi': 'Vitamin B6',
        'benefits': 'Important for protein metabolism and cognitive development',
        'benefits_vi': 'Quan trọng cho chuyển hóa protein và phát triển nhận thức',
        'rda_male': 1.3,
        'rda_female': 1.3,
        'rda_pregnant': 1.9,
        'rda_lactating': 2.0,
        'unit': 'mg',
        'icon': '🥔',
        'color': '#CD853F',
      },
      {
        'code': 'B12',
        'name': 'Vitamin B12',
        'name_vi': 'Vitamin B12',
        'benefits': 'Necessary for red blood cell formation and neurological function',
        'benefits_vi': 'Cần thiết cho hình thành hồng cầu và thần kinh',
        'rda_male': 2.4,
        'rda_female': 2.4,
        'rda_pregnant': 2.6,
        'rda_lactating': 2.8,
        'unit': 'mcg',
        'icon': '🥩',
        'color': '#DC143C',
      },
      {
        'code': 'C',
        'name': 'Vitamin C',
        'name_vi': 'Vitamin C',
        'benefits': 'Antioxidant, supports immune system, helps iron absorption',
        'benefits_vi': 'Chống oxy hóa, tăng cường miễn dịch, hấp thụ sắt',
        'rda_male': 90.0,
        'rda_female': 75.0,
        'rda_pregnant': 85.0,
        'rda_lactating': 120.0,
        'unit': 'mg',
        'icon': '🍊',
        'color': '#FF6B35',
      },
      {
        'code': 'D',
        'name': 'Vitamin D',
        'name_vi': 'Vitamin D',
        'benefits': 'Essential for bone health, calcium absorption',
        'benefits_vi': 'Cần thiết cho xương, hấp thụ canxi',
        'rda_male': 15.0,
        'rda_female': 15.0,
        'rda_pregnant': 15.0,
        'rda_lactating': 15.0,
        'unit': 'mcg',
        'icon': '☀️',
        'color': '#FFD700',
      },
      {
        'code': 'E',
        'name': 'Vitamin E',
        'name_vi': 'Vitamin E',
        'benefits': 'Antioxidant, protects cells from damage',
        'benefits_vi': 'Chống oxy hóa, bảo vệ tế bào',
        'rda_male': 15.0,
        'rda_female': 15.0,
        'rda_pregnant': 15.0,
        'rda_lactating': 19.0,
        'unit': 'mg',
        'icon': '🥜',
        'color': '#DEB887',
      },
      {
        'code': 'K',
        'name': 'Vitamin K',
        'name_vi': 'Vitamin K',
        'benefits': 'Important for blood clotting and bone health',
        'benefits_vi': 'Quan trọng cho đông máu và xương',
        'rda_male': 120.0,
        'rda_female': 90.0,
        'rda_pregnant': 90.0,
        'rda_lactating': 90.0,
        'unit': 'mcg',
        'icon': '🥬',
        'color': '#228B22',
      },
    ];

    for (var vitamin in vitamins) {
      await db.insert(
        AppConstants.tableVitaminInfo,
        vitamin,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    print('✅ Seeded ${vitamins.length} vitamins');
  }

  Future<void> _seedMinerals(Database db) async {
    final minerals = [
      {
        'code': 'Ca',
        'name': 'Calcium',
        'name_vi': 'Canxi',
        'benefits': 'Builds and maintains strong bones and teeth',
        'benefits_vi': 'Xây dựng và duy trì xương răng chắc khỏe',
        'rda_male': 1000.0,
        'rda_female': 1000.0,
        'rda_pregnant': 1000.0,
        'rda_lactating': 1000.0,
        'unit': 'mg',
        'icon': '🥛',
        'color': '#FFFFFF',
      },
      {
        'code': 'Fe',
        'name': 'Iron',
        'name_vi': 'Sắt',
        'benefits': 'Essential for blood production, oxygen transport',
        'benefits_vi': 'Cần thiết cho sản xuất máu, vận chuyển oxy',
        'rda_male': 8.0,
        'rda_female': 18.0,
        'rda_pregnant': 27.0,
        'rda_lactating': 9.0,
        'unit': 'mg',
        'icon': '🥩',
        'color': '#DC143C',
      },
      {
        'code': 'Mg',
        'name': 'Magnesium',
        'name_vi': 'Magiê',
        'benefits': 'Supports muscle and nerve function, energy production',
        'benefits_vi': 'Hỗ trợ cơ bắp và thần kinh, sản xuất năng lượng',
        'rda_male': 400.0,
        'rda_female': 310.0,
        'rda_pregnant': 350.0,
        'rda_lactating': 310.0,
        'unit': 'mg',
        'icon': '🌰',
        'color': '#8B4513',
      },
      {
        'code': 'Zn',
        'name': 'Zinc',
        'name_vi': 'Kẽm',
        'benefits': 'Supports immune system, wound healing, DNA synthesis',
        'benefits_vi': 'Tăng cường miễn dịch, lành vết thương, tổng hợp DNA',
        'rda_male': 11.0,
        'rda_female': 8.0,
        'rda_pregnant': 11.0,
        'rda_lactating': 12.0,
        'unit': 'mg',
        'icon': '🦪',
        'color': '#708090',
      },
      {
        'code': 'K',
        'name': 'Potassium',
        'name_vi': 'Kali',
        'benefits': 'Regulates fluid balance, muscle contractions, nerve signals',
        'benefits_vi': 'Điều hòa cân bằng nước, co cơ, tín hiệu thần kinh',
        'rda_male': 3400.0,
        'rda_female': 2600.0,
        'rda_pregnant': 2900.0,
        'rda_lactating': 2800.0,
        'unit': 'mg',
        'icon': '🍌',
        'color': '#FFE135',
      },
      {
        'code': 'P',
        'name': 'Phosphorus',
        'name_vi': 'Photpho',
        'benefits': 'Builds strong bones and teeth, helps produce energy',
        'benefits_vi': 'Xây dựng xương răng, giúp sản xuất năng lượng',
        'rda_male': 700.0,
        'rda_female': 700.0,
        'rda_pregnant': 700.0,
        'rda_lactating': 700.0,
        'unit': 'mg',
        'icon': '🥚',
        'color': '#FFDEAD',
      },
    ];

    for (var mineral in minerals) {
      await db.insert(
        AppConstants.tableMineralInfo,
        mineral,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    print('✅ Seeded ${minerals.length} minerals');
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
