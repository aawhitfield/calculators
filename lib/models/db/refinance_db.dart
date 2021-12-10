import 'package:calculators/models/refinance.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class RefinanceDatabase {
  static final RefinanceDatabase instance = RefinanceDatabase._init();

  static Database? _database;

  RefinanceDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('refinance.db');
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

    await db.execute('''
      CREATE TABLE $tableRefinance (
        ${RefinanceFields.id} $idType,
        ${RefinanceFields.financingType} $financingType,
        ${RefinanceFields.loanPercent} $loanPercentType,
        ${RefinanceFields.interestRate} $interestRateType,
        ${RefinanceFields.term} $termType,
        ${RefinanceFields.closingCosts} $closingCostsType
      )
    ''');
  }

  Future<RefinanceOptions> create(RefinanceOptions financeOptionData) async {
    final db = await instance.database;

    final id = await db.insert(tableRefinance, financeOptionData.toJson());
    return financeOptionData.copy(id: id);
  }

  Future<RefinanceOptions> readFinanceOption(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableRefinance,
      columns: RefinanceFields.values,
      where: '${RefinanceFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return RefinanceOptions.fromJson(maps.first);
    }
    else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<RefinanceOptions>> readAllFinanceOptions() async {
    final db = await instance.database;

    const orderBy = '${RefinanceFields.id} ASC';

    final result = await db.query(tableRefinance, orderBy: orderBy);

    return result.map((json) => RefinanceOptions.fromJson(json)).toList();
  }


  Future<int> update(RefinanceOptions financeOptionData) async {
    final db = await instance.database;

    return db.update(
      tableRefinance,
      financeOptionData.toJson(),
      where: '${RefinanceFields.id} = ?',
      whereArgs: [financeOptionData.id],
    );
  }

  Future<int> delete (int id) async {
    final db = await instance.database;

    return await db.delete(
      tableRefinance,
      where: '${RefinanceFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

}