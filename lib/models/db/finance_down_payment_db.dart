import 'package:calculators/models/seller_financing_type.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SellerFinanceDatabase {
  static final SellerFinanceDatabase instance = SellerFinanceDatabase._init();

  static Database? _database;

  SellerFinanceDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('finance_down_payment.db');
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

    await db.execute('''
      CREATE TABLE $tableSellerFinance (
        ${SellerFinanceFields.id} $idType,
        ${SellerFinanceFields.financingType} $financingType,
        ${SellerFinanceFields.loanPercent} $loanPercentType,
        ${SellerFinanceFields.interestRate} $interestRateType,
        ${SellerFinanceFields.term} $termType
      )
    ''');
  }

  Future<SellerFinanceOptionData> create(SellerFinanceOptionData sellerFinanceOptionData) async {
    final db = await instance.database;

    final id = await db.insert(tableSellerFinance, sellerFinanceOptionData.toJson());
    return sellerFinanceOptionData.copy(id: id);
  }

  Future<SellerFinanceOptionData> readFinanceOption(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableSellerFinance,
      columns: SellerFinanceFields.values,
      where: '${SellerFinanceFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return SellerFinanceOptionData.fromJson(maps.first);
    }
    else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<SellerFinanceOptionData>> readAllFinanceOptions() async {
    final db = await instance.database;

    const orderBy = '${SellerFinanceFields.id} ASC';

    final result = await db.query(tableSellerFinance, orderBy: orderBy);

    return result.map((json) => SellerFinanceOptionData.fromJson(json)).toList();
  }


  Future<int> update(SellerFinanceOptionData financeOptionData) async {
    final db = await instance.database;

    return db.update(
      tableSellerFinance,
      financeOptionData.toJson(),
      where: '${SellerFinanceFields.id} = ?',
      whereArgs: [financeOptionData.id],
    );
  }

  Future<int> delete (int id) async {
    final db = await instance.database;

    return await db.delete(
      tableSellerFinance,
      where: '${SellerFinanceFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

}