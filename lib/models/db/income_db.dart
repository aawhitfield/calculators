import 'package:calculators/models/income.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class IncomeDatabase {
  static final IncomeDatabase instance = IncomeDatabase._init();

  static Database? _database;

  IncomeDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('income.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const rentType = 'REAL NON NULL';
    const otherType = 'REAL NON NULL';

    await db.execute('''
      CREATE TABLE $tableIncome (
        ${IncomeFields.id} $idType,
        ${IncomeFields.rent} $rentType,
        ${IncomeFields.other} $otherType
      )
    ''');
  }

  Future<Income> create(Income income) async {
    final db = await instance.database;

    final id = await db.insert(tableIncome, income.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    return income.copy(id: id);
  }

  Future<Income> readIncome(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableIncome,
      columns: IncomeFields.values,
      where: '${IncomeFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Income.fromJson(maps.first);
    }
    else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Income>> readAllProperties() async {
    final db = await instance.database;

    const orderBy = '${IncomeFields.id} ASC';

    final result = await db.query(tableIncome, orderBy: orderBy);

    return result.map((json) => Income.fromJson(json)).toList();
  }


  Future<int> update(Income income) async {
    final db = await instance.database;

    return db.update(
      tableIncome,
      income.toJson(),
      where: '${IncomeFields.id} = ?',
      whereArgs: [income.id],
    );
  }

  Future<int> delete (int id) async {
    final db = await instance.database;

    return await db.delete(
      tableIncome,
      where: '${IncomeFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

}