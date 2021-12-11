import 'package:calculators/models/financing_option_construction_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FinanceConstructionDatabase {
  static final FinanceConstructionDatabase instance = FinanceConstructionDatabase._init();

  static Database? _database;

  FinanceConstructionDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('finance_construction.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const loanPercentType = 'REAL NON NULL';
    const interestRateType = 'REAL NON NULL';
    const termType = 'INTEGER NON NULL';

    await db.execute('''
      CREATE TABLE $tableFinanceConstruction (
        ${FinanceConstructionFields.id} $idType,
        ${FinanceConstructionFields.loanPercent} $loanPercentType,
        ${FinanceConstructionFields.interestRate} $interestRateType,
        ${FinanceConstructionFields.term} $termType
      )
    ''');
  }

  Future<FinanceOptionConstructionProvider> create(FinanceOptionConstructionProvider financeOptionConstruction) async {
    final db = await instance.database;

    final id = await db.insert(tableFinanceConstruction, financeOptionConstruction.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    return financeOptionConstruction.copy(id: id);
  }

  Future<FinanceOptionConstructionProvider> readFinanceOption(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableFinanceConstruction,
      columns: FinanceConstructionFields.values,
      where: '${FinanceConstructionFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return FinanceOptionConstructionProvider.fromJson(maps.first);
    }
    else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<FinanceOptionConstructionProvider>> readAllFinanceOptions() async {
    final db = await instance.database;

    const orderBy = '${FinanceConstructionFields.id} ASC';

    final result = await db.query(tableFinanceConstruction, orderBy: orderBy);

    return result.map((json) => FinanceOptionConstructionProvider.fromJson(json)).toList();
  }


  Future<int> update(FinanceOptionConstructionProvider financeOptionData) async {
    final db = await instance.database;

    return db.update(
      tableFinanceConstruction,
      financeOptionData.toJson(),
      where: '${FinanceConstructionFields.id} = ?',
      whereArgs: [financeOptionData.id],
    );
  }

  Future<int> delete (int id) async {
    final db = await instance.database;

    return await db.delete(
      tableFinanceConstruction,
      where: '${FinanceConstructionFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

}