import 'package:calculators/models/financing_type.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FinanceDatabase {
  static final FinanceDatabase instance = FinanceDatabase._init();

  static Database? _database;

  FinanceDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('finance.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const financingType = 'TEXT NON NULL';
    const loanPercentType = 'REAL NON NULL';
    const interestRateType = 'REAL NON NULL';
    const termType = 'INTEGER NON NULL';
    const closingCostsType = 'REAL NON NULL';
    const paymentTypeType = 'TEXT NON NULL';

    await db.execute('''
      CREATE TABLE $tableFinance (
        ${FinanceFields.id} $idType,
        ${FinanceFields.financingType} $financingType,
        ${FinanceFields.loanPercent} $loanPercentType,
        ${FinanceFields.interestRate} $interestRateType,
        ${FinanceFields.term} $termType,
        ${FinanceFields.closingCosts} $closingCostsType,
        ${FinanceFields.paymentTypeType} $paymentTypeType
      )
    ''');
  }

  Future<FinanceOptionData> create(FinanceOptionData financeOptionData) async {
    final db = await instance.database;

    final id = await db.insert(tableFinance, financeOptionData.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    return financeOptionData.copy(id: id);
  }

  Future<FinanceOptionData> readFinanceOption(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableFinance,
      columns: FinanceFields.values,
      where: '${FinanceFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return FinanceOptionData.fromJson(maps.first);
    }
    else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<FinanceOptionData>> readAllFinanceOptions() async {
    final db = await instance.database;

    const orderBy = '${FinanceFields.id} ASC';

    final result = await db.query(tableFinance, orderBy: orderBy);

    return result.map((json) => FinanceOptionData.fromJson(json)).toList();
  }


  Future<int> update(FinanceOptionData financeOptionData) async {
    final db = await instance.database;

    return db.update(
      tableFinance,
      financeOptionData.toJson(),
      where: '${FinanceFields.id} = ?',
      whereArgs: [financeOptionData.id],
    );
  }

  Future<int> delete (int id) async {
    final db = await instance.database;

    return await db.delete(
      tableFinance,
      where: '${FinanceFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

}