import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/expense_model.dart';

class ExpenseDao {
  static final ExpenseDao instance = ExpenseDao._init();
  static Database? _database;

  ExpenseDao._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('expenses.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE expenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL NOT NULL,
        category TEXT NOT NULL,
        description TEXT,
        date TEXT NOT NULL,
        paymentMethod TEXT NOT NULL
      )
    ''');
  }

  Future<List<ExpenseModel>> getAllExpenses() async {
    final db = await instance.database;
    final result = await db.query('expenses');
    return result.map((json) => ExpenseModel.fromMap(json)).toList();
  }

  Future<void> insertExpense(ExpenseModel expense) async {
    final db = await instance.database;
    await db.insert('expenses', expense.toMap());
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
