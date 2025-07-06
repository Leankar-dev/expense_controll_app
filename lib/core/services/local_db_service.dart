import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/transaction_model.dart';
import '../models/category_model.dart';

class LocalDbService {
  Database? _db;

  Future<void> init() async {
    final path = join(await getDatabasesPath(), 'expensecontroll.db');
    _db = await openDatabase(
      path,
      version: 2, // Versão atualizada
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        value REAL NOT NULL CHECK (value >= 0),
        category TEXT,
        description TEXT,
        date TEXT,
        paymentMethod TEXT,
        receiptMethod TEXT,
        type TEXT DEFAULT 'expense'
      );
    ''');

    await db.execute('''
      CREATE TABLE categories(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      );
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
        'ALTER TABLE transactions ADD COLUMN type TEXT DEFAULT "expense"',
      );
    }
  }

  Future<void> resetAndRecreateDatabase() async {
    final path = join(await getDatabasesPath(), 'expensecontroll.db');
    await deleteDatabase(path);
    await init();
  }

  Future<Database> get _database async {
    if (_db != null) return _db!;
    await init();
    return _db!;
  }

  // ===================== TRANSACTIONS =====================

  Future<int> insertTransaction(TransactionModel transaction) async {
    final db = await _database;
    return await db.insert('transactions', transaction.toMap());
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await _database;
    final maps = await db.query('transactions', orderBy: 'date DESC');
    return maps.map((e) => TransactionModel.fromMap(e)).toList();
  }

  Future<int> updateTransaction(TransactionModel transaction) async {
    final db = await _database;
    return await db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  Future<int> deleteTransaction(int id) async {
    final db = await _database;
    return await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }

  // ===================== CATEGORIES =====================

  Future<int> insertCategory(CategoryModel category) async {
    final db = await _database;
    return await db.insert('categories', category.toMap());
  }

  Future<List<CategoryModel>> getAllCategories() async {
    final db = await _database;
    final maps = await db.query('categories', orderBy: 'name');
    return maps.map((e) => CategoryModel.fromMap(e)).toList();
  }

  Future<int> deleteCategory(int id) async {
    final db = await _database;
    return await db.delete('categories', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateCategory(CategoryModel category) async {
    final db = await _database;
    return await db.update(
      'categories',
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  // ===================== EXTRA =====================

  Future<void> clearAllData() async {
    final db = await _database;
    await db.delete('transactions');
    await db.delete('categories');
  }
}
