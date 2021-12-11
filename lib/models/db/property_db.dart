import 'package:calculators/models/property.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PropertyDatabase {
  static final PropertyDatabase instance = PropertyDatabase._init();

  static Database? _database;

  PropertyDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('address.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const calculatorType = 'TEXT NON NULL';
    const addressType = 'TEXT NON NULL';
    const sqftType = 'INTEGER NON NULL';
    const listPriceType = 'REAL NON NULL';
    const afterRepairValueType = 'REAL NON NULL';
    const purchasePriceType = 'REAL NON NULL';
    const monthsToRehabRentType = 'INTEGER NON NULL';
    const unitsType = 'INTEGER NON NULL';
    const investorsType = 'INTEGER NON NULL';

    await db.execute('''
      CREATE TABLE $tableProperty (
        ${PropertyFields.id} $idType,
        ${PropertyFields.calculator} $calculatorType,
        ${PropertyFields.address} $addressType,
        ${PropertyFields.sqft} $sqftType,
        ${PropertyFields.listPrice} $listPriceType,
        ${PropertyFields.afterRepairValue} $afterRepairValueType,
        ${PropertyFields.purchasePrice} $purchasePriceType,
        ${PropertyFields.monthsToRehabRent} $monthsToRehabRentType,
        ${PropertyFields.units} $unitsType,
        ${PropertyFields.investors} $investorsType
      )
    ''');
  }

  Future<Property> create(Property property) async {
    final db = await instance.database;

    final id = await db.insert(tableProperty, property.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    return property.copy(id: id);
  }

  Future<Property> readProperty(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableProperty,
      columns: PropertyFields.values,
      where: '${PropertyFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Property.fromJson(maps.first);
    }
    else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Property>> readAllProperties() async {
    final db = await instance.database;

    const orderBy = '${PropertyFields.id} ASC';

    final result = await db.query(tableProperty, orderBy: orderBy);

    return result.map((json) => Property.fromJson(json)).toList();
  }


  Future<int> update(Property property) async {
    final db = await instance.database;

    return db.update(
      tableProperty,
      property.toJson(),
      where: '${PropertyFields.id} = ?',
      whereArgs: [property.id],
    );
  }

  Future<int> delete (int id) async {
    final db = await instance.database;

    return await db.delete(
      tableProperty,
      where: '${PropertyFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

}