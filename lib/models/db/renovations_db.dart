import 'package:calculators/models/renovations.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class RenovationsDatabase {
  static final RenovationsDatabase instance = RenovationsDatabase._init();

  static Database? _database;

  RenovationsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('renovations.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const foundationType = 'REAL NON NULL';
    const roofType = 'REAL NON NULL';
    const airConditionerType = 'REAL NON NULL';
    const paintingType = 'REAL NON NULL';
    const kitchenType = 'REAL NON NULL';
    const windowsType = 'REAL NON NULL';
    const plumbingType = 'REAL NON NULL';
    const flooringType = 'REAL NON NULL';
    const bathroomsType = 'REAL NON NULL';
    const appliancesType = 'REAL NON NULL';
    const electricalType = 'REAL NON NULL';
    const yardType = 'REAL NON NULL';
    const cleaningType = 'REAL NON NULL';
    const baseboardsType = 'REAL NON NULL';
    const exteriorType = 'REAL NON NULL';
    const demoType = 'REAL NON NULL';
    const elevatorsType = 'REAL NON NULL';
    const build28Type = 'REAL NON NULL';
    const otherType = 'REAL NON NULL';
    const tenPercentExtraType = 'REAL NON NULL';
    const totalType = 'REAL NON NULL';


    await db.execute('''
      CREATE TABLE $tableRenovations (
        ${RenovationFields.id} $idType,
        ${RenovationFields.foundation} $foundationType,
        ${RenovationFields.roof} $roofType,
        ${RenovationFields.airConditioner} $airConditionerType,
        ${RenovationFields.painting} $paintingType,
        ${RenovationFields.kitchen} $kitchenType,
        ${RenovationFields.windows} $windowsType,
        ${RenovationFields.plumbing} $plumbingType,
        ${RenovationFields.flooring} $flooringType,
        ${RenovationFields.bathrooms} $bathroomsType,
        ${RenovationFields.appliances} $appliancesType,
        ${RenovationFields.electrical} $electricalType,
        ${RenovationFields.yard} $yardType,
        ${RenovationFields.cleaning} $cleaningType,
        ${RenovationFields.baseboards} $baseboardsType,
        ${RenovationFields.exterior} $exteriorType,
        ${RenovationFields.demo} $demoType,
        ${RenovationFields.elevators} $elevatorsType,
        ${RenovationFields.build28} $build28Type,
        ${RenovationFields.other} $otherType,
        ${RenovationFields.tenPercent} $tenPercentExtraType,
        ${RenovationFields.total} $totalType,
      )
    ''');
  }

  Future<Renovation> create(Renovation renovation) async {
    final db = await instance.database;

    final id = await db.insert(tableRenovations, renovation.toJson());
    return renovation.copy(id: id);
  }

  Future<Renovation> readRenovation(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableRenovations,
      columns: RenovationFields.values,
      where: '${RenovationFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Renovation.fromJson(maps.first);
    }
    else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Renovation>> readAllRenovations() async {
    final db = await instance.database;

    const orderBy = '${RenovationFields.id} ASC';

    final result = await db.query(tableRenovations, orderBy: orderBy);

    return result.map((json) => Renovation.fromJson(json)).toList();
  }


  Future<int> update(Renovation renovation) async {
    final db = await instance.database;

    return db.update(
      tableRenovations,
      renovation.toJson(),
      where: '${RenovationFields.id} = ?',
      whereArgs: [renovation.id],
    );
  }

  Future<int> delete (int id) async {
    final db = await instance.database;

    return await db.delete(
      tableRenovations,
      where: '${RenovationFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

}