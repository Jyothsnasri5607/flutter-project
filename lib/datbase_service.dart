import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  DatabaseService._();

  static final DatabaseService instance = DatabaseService._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(
      databasePath,
      'cell_point.db',
    );

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {

        // PRODUCTS TABLE
        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            category TEXT NOT NULL,
            brand TEXT,
            model TEXT,
            imei TEXT,
            purchasePrice REAL NOT NULL DEFAULT 0,
            sellingPrice REAL NOT NULL DEFAULT 0,
            stock INTEGER NOT NULL DEFAULT 0,
            minStock INTEGER NOT NULL DEFAULT 1,
            supplier TEXT,
            warranty TEXT,
            createdAt TEXT NOT NULL
          )
        ''');

        // SALES TABLE
        await db.execute('''
          CREATE TABLE sales(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            productId INTEGER NOT NULL,
            productName TEXT NOT NULL,
            quantity INTEGER NOT NULL,
            total REAL NOT NULL,
            customerName TEXT,
            paymentMethod TEXT NOT NULL,
            createdAt TEXT NOT NULL
          )
        ''');

        // REPAIRS TABLE
        await db.execute('''
          CREATE TABLE repairs(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            customerName TEXT NOT NULL,
            phone TEXT,
            brand TEXT,
            model TEXT,
            imei TEXT,
            problem TEXT NOT NULL,
            estimatedCost REAL NOT NULL DEFAULT 0,
            advancePaid REAL NOT NULL DEFAULT 0,
            status TEXT NOT NULL,
            expectedDate TEXT,
            createdAt TEXT NOT NULL
          )
        ''');

        // CUSTOMERS TABLE
        await db.execute('''
          CREATE TABLE customers(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            phone TEXT,
            notes TEXT
          )
        ''');

        // PAYMENTS TABLE
        await db.execute('''
          CREATE TABLE payments(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            customerName TEXT NOT NULL,
            referenceType TEXT NOT NULL,
            referenceId INTEGER,
            amount REAL NOT NULL,
            method TEXT NOT NULL,
            status TEXT NOT NULL,
            createdAt TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // ------------------------------------------------
  // PRODUCTS
  // ------------------------------------------------

  Future<List<Map<String, dynamic>>> getProducts({
    String search = '',
  }) async {
    final db = await database;

    if (search.trim().isEmpty) {
      return db.query(
        'products',
        orderBy: 'name ASC',
      );
    }

    return db.query(
      'products',
      where:
          'name LIKE ? OR brand LIKE ? OR model LIKE ? OR category LIKE ?',
      whereArgs: [
        '%$search%',
        '%$search%',
        '%$search%',
        '%$search%',
      ],
      orderBy: 'name ASC',
    );
  }

  Future<int> addProduct(
    Map<String, dynamic> product,
  ) async {
    final db = await database;

    return db.insert(
      'products',
      product,
    );
  }

  Future<int> updateProduct(
    int id,
    Map<String, dynamic> product,
  ) async {
    final db = await database;

    return db.update(
      'products',
      product,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ------------------------------------------------
  // RESTOCK
  // ------------------------------------------------

  Future<void> restockProduct(
    int id,
    int quantity,
  ) async {
    final db = await database;

    await db.rawUpdate(
      '''
      UPDATE products
      SET stock = stock + ?
      WHERE id = ?
      ''',
      [
        quantity,
        id,
      ],
    );
  }

  // ------------------------------------------------
  // SALES
  // ------------------------------------------------

  Future<void> recordSale({
    required int productId,
    required String productName,
    required int quantity,
    required double total,
    required String customerName,
    required String paymentMethod,
  }) async {
    final db = await database;

    await db.transaction(
      (transaction) async {

        final product = await transaction.query(
          'products',
          columns: ['stock'],
          where: 'id = ?',
          whereArgs: [productId],
        );

        if (product.isEmpty) {
          throw Exception('Product not found');
        }

        final currentStock =
            product.first['stock'] as int;

        if (currentStock < quantity) {
          throw Exception('Not enough stock available');
        }

        // AUTOMATICALLY REDUCE STOCK
        await transaction.rawUpdate(
          '''
          UPDATE products
          SET stock = stock - ?
          WHERE id = ?
          ''',
          [
            quantity,
            productId,
          ],
        );

        // ADD SALE RECORD
        await transaction.insert(
          'sales',
          {
            'productId': productId,
            'productName': productName,
            'quantity': quantity,
            'total': total,
            'customerName': customerName,
            'paymentMethod': paymentMethod,
            'createdAt':
                DateTime.now().toIso8601String(),
          },
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> getSales({
    DateTime? from,
    DateTime? to,
  }) async {
    final db = await database;

    if (from == null || to == null) {
      return db.query(
        'sales',
        orderBy: 'createdAt DESC',
      );
    }

    return db.query(
      'sales',
      where:
          'createdAt >= ? AND createdAt < ?',
      whereArgs: [
        from.toIso8601String(),
        to.toIso8601String(),
      ],
      orderBy: 'createdAt DESC',
    );
  }

  // ------------------------------------------------
  // REPAIRS
  // ------------------------------------------------

  Future<int> addRepair(
    Map<String, dynamic> repair,
  ) async {
    final db = await database;

    return db.insert(
      'repairs',
      repair,
    );
  }

  Future<List<Map<String, dynamic>>> getRepairs() async {
    final db = await database;

    return db.query(
      'repairs',
      orderBy: 'createdAt DESC',
    );
  }

  Future<void> updateRepairStatus(
    int id,
    String status,
  ) async {
    final db = await database;

    await db.update(
      'repairs',
      {
        'status': status,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ------------------------------------------------
  // CUSTOMERS
  // ------------------------------------------------

  Future<int> addCustomer(
    Map<String, dynamic> customer,
  ) async {
    final db = await database;

    return db.insert(
      'customers',
      customer,
    );
  }

  Future<List<Map<String, dynamic>>> getCustomers() async {
    final db = await database;

    return db.query(
      'customers',
      orderBy: 'name ASC',
    );
  }

  // ------------------------------------------------
  // DASHBOARD
  // ------------------------------------------------

  Future<Map<String, double>> getDashboardData() async {
    final db = await database;

    final now = DateTime.now();

    final todayStart = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final monthStart = DateTime(
      now.year,
      now.month,
      1,
    );

    final today = await db.rawQuery(
      '''
      SELECT COALESCE(SUM(total), 0) AS total
      FROM sales
      WHERE createdAt >= ?
      ''',
      [
        todayStart.toIso8601String(),
      ],
    );

    final month = await db.rawQuery(
      '''
      SELECT COALESCE(SUM(total), 0) AS total
      FROM sales
      WHERE createdAt >= ?
      ''',
      [
        monthStart.toIso8601String(),
      ],
    );

    final stock = await db.rawQuery(
      '''
      SELECT COALESCE(SUM(stock), 0) AS total
      FROM products
      ''',
    );

    final lowStock = await db.rawQuery(
      '''
      SELECT COUNT(*) AS total
      FROM products
      WHERE stock > 0
      AND stock <= minStock
      ''',
    );

    final outOfStock = await db.rawQuery(
      '''
      SELECT COUNT(*) AS total
      FROM products
      WHERE stock = 0
      ''',
    );

    final repairs = await db.rawQuery(
      '''
      SELECT COUNT(*) AS total
      FROM repairs
      WHERE status != 'Delivered'
      ''',
    );

    return {
      'todaySales':
          (today.first['total'] as num).toDouble(),

      'monthlySales':
          (month.first['total'] as num).toDouble(),

      'totalStock':
          (stock.first['total'] as num).toDouble(),

      'lowStock':
          (lowStock.first['total'] as num).toDouble(),

      'outOfStock':
          (outOfStock.first['total'] as num).toDouble(),

      'activeRepairs':
          (repairs.first['total'] as num).toDouble(),
    };
  }
}