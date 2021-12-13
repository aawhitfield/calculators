import 'package:calculators/models/fix_flip_selling_costs.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SellingCostDatabase {
  static final SellingCostDatabase instance = SellingCostDatabase._init();

  static Database? _database;

  SellingCostDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('selling_cost.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const doubleType = 'REAL NON NULL';

    await db.execute('''
      CREATE TABLE $tableClosingCosts (
        ${ClosingCostsFields.id} $idType,
        ${ClosingCostsFields.realtorsFeesPercentage} $doubleType,
        ${ClosingCostsFields.sellersClosingCosts} $doubleType,
        ${ClosingCostsFields.buyersClosingCosts} $doubleType
      )
    ''');
  }

  Future<FixFlipSellingCosts> create(FixFlipSellingCosts financeOptionData) async {
    final db = await instance.database;

    final id = await db.insert(tableClosingCosts, financeOptionData.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    return financeOptionData.copy(id: id);
  }

  Future<FixFlipSellingCosts> readFinanceOption(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableClosingCosts,
      columns: ClosingCostsFields.values,
      where: '${ClosingCostsFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return FixFlipSellingCosts.fromJson(maps.first);
    }
    else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<FixFlipSellingCosts>> readAllFinanceOptions() async {
    final db = await instance.database;

    const orderBy = '${ClosingCostsFields.id} ASC';

    final result = await db.query(tableClosingCosts, orderBy: orderBy);

    return result.map((json) => FixFlipSellingCosts.fromJson(json)).toList();
  }


  Future<int> update(FixFlipSellingCosts financeOptionData) async {
    final db = await instance.database;

    return db.update(
      tableClosingCosts,
      financeOptionData.toJson(),
      where: '${ClosingCostsFields.id} = ?',
      whereArgs: [financeOptionData.id],
    );
  }

  Future<int> delete (int id) async {
    final db = await instance.database;

    return await db.delete(
      tableClosingCosts,
      where: '${ClosingCostsFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

}