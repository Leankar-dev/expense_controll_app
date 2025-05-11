import 'package:expense_controll_app/data/models/expense_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseDao {
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'expenses.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE expenses (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            amount REAL,
            category TEXT,
            description TEXT,
            date TEXT,
            paymentMethod TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertExpense(ExpenseModel expense) async {
    final db = await database;
    return await db.insert('expenses', expense.toMap());
  }

  Future<List<ExpenseModel>> getAllExpenses() async {
    final db = await database;
    final result = await db.query('expenses', orderBy: 'date DESC');
    return result.map((e) => ExpenseModel.fromMap(e)).toList();
  }

  Future<int> updateExpense(ExpenseModel expense) async {
    final db = await database;
    return await db.update(
      'expenses',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  Future<int> deleteExpense(int id) async {
    final db = await database;
    return await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearAllExpenses() async {
    final db = await database;
    await db.delete('expenses');
  }
}
