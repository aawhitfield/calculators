import 'package:calculators/models/expenses.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ExpensesDatabase {
  static final ExpensesDatabase instance = ExpensesDatabase._init();

  static Database? _database;

  ExpensesDatabase._init();

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
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const taxesType = 'REAL NON NULL';
    const propertyManagementType = 'REAL NON NULL';
    const vacancyManagementType = 'REAL NON NULL';
    const maintenanceManagementType = 'REAL NON NULL';
    const otherManagementType = 'REAL NON NULL';

    await db.execute('''
      CREATE TABLE $tableExpenses (
        ${ExpensesFields.id} $idType,
        ${ExpensesFields.taxes} $taxesType,
        ${ExpensesFields.propertyManagement} $propertyManagementType,
        ${ExpensesFields.vacancy} $vacancyManagementType,
        ${ExpensesFields.maintenance} $maintenanceManagementType,
        ${ExpensesFields.other} $otherManagementType
      )
    ''');
  }

  Future<Expenses> create(Expenses expenses) async {
    final db = await instance.database;

    final id = await db.insert(tableExpenses, expenses.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    return expenses.copy(id: id);
  }

  Future<Expenses> readExpenses(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableExpenses,
      columns: ExpensesFields.values,
      where: '${ExpensesFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Expenses.fromJson(maps.first);
    }
    else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Expenses>> readAllProperties() async {
    final db = await instance.database;

    const orderBy = '${ExpensesFields.id} ASC';

    final result = await db.query(tableExpenses, orderBy: orderBy);

    return result.map((json) => Expenses.fromJson(json)).toList();
  }


  Future<int> update(Expenses expenses) async {
    final db = await instance.database;

    return db.update(
      tableExpenses,
      expenses.toJson(),
      where: '${ExpensesFields.id} = ?',
      whereArgs: [expenses.id],
    );
  }

  Future<int> delete (int id) async {
    final db = await instance.database;

    return await db.delete(
      tableExpenses,
      where: '${ExpensesFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

}