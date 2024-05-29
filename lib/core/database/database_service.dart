import 'package:coupon_collection/core/database/coupons_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DatabaseService {
  final tableName = "Coupons";
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    String name = "coupon.db";
    final path = await getDatabasesPath();

    return p.join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    final database = await openDatabase(path,
        version: 1, onCreate: create, singleInstance: true);
    return database;
  }

  Future<void> create(Database database, int version) async =>
      await CouponsDB().createTable(database);
}
