import 'package:calculators/models/options.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class OptionsDatabase {
  static final OptionsDatabase instance = OptionsDatabase._init();

  static Database? _database;

  OptionsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('options.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const booleanType = 'BOOLEAN NON NULL';

    await db.execute('''
      CREATE TABLE $tableOptions (
        ${OptionsFields.id} $idType,
        ${OptionsFields.isSellerFinanced} $booleanType,
        ${OptionsFields.wantsToRefinance} $booleanType
      )
    ''');
  }

  Future<Options> create(Options options) async {
    final db = await instance.database;

    final id = await db.insert(tableOptions, options.toJson());
    return options.copy(id: id);
  }

  Future<Options> readOptions(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableOptions,
      columns: OptionsFields.values,
      where: '${OptionsFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Options.fromJson(maps.first);
    }
    else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Options>> readAllProperties() async {
    final db = await instance.database;

    const orderBy = '${OptionsFields.id} ASC';

    final result = await db.query(tableOptions, orderBy: orderBy);

    return result.map((json) => Options.fromJson(json)).toList();
  }


  Future<int> update(Options options) async {
    final db = await instance.database;

    return db.update(
      tableOptions,
      options.toJson(),
      where: '${OptionsFields.id} = ?',
      whereArgs: [options.id],
    );
  }

  Future<int> delete (int id) async {
    final db = await instance.database;

    return await db.delete(
      tableOptions,
      where: '${OptionsFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

}