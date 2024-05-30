import 'package:coupon_collection/core/database/database_service.dart';
import 'package:coupon_collection/core/entities/coupon_model.dart';
import 'package:coupon_collection/core/entities/delete_result.dart';
import 'package:coupon_collection/core/entities/insert_result.dart';
import 'package:coupon_collection/core/entities/update_result.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class CouponsDB {
  final tableName = "Coupons";

  Future<void> createTable(Database database) async {
    try {
      await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "id"  INTEGER NOT NULL,
      "store_name" VARCHAR(255) NOT NULL,
      "category" VARCHAR(255) NOT NULL
      "start_time" INTEGER NOT NULL,
      "end_time" INTEGER NOT NULL,
      "create_time" INTEGER NOT NULL,
      "content" TEXT,
      "image_path" TEXT,
      PRIMARY KEY("id"  AUTOINCREMENT)
    );""");
    } catch (err, s) {
      throw Error.throwWithStackTrace(err, s);
    }
  }

  //* 建立一筆資料
  Future<InsertResult> insert({
    required String store_name,
    required String category,
    required int start_time,
    required int end_time,
    required int create_time,
    String? content,
    String? imagepath,
  }) async {
    try {
      final database = await GetIt.I.get<DatabaseService>().database;
      await database.rawInsert(
          '''INSERT INTO $tableName (store_name,category,start_time,end_time,create_time,content,image_path) VALUES (?,?,?,?,?,?,?)''',
          [
            store_name,
            category,
            start_time,
            end_time,
            create_time,
            content,
            imagepath
          ]);
      return InsertResult(isSuccess: true);
    } catch (err) {
      return InsertResult(isSuccess: false, errorMessage: "$err");
    }
  }

  //* 回傳所有優惠券資料（以list方式呈現
  Future<List<CouponModel>> fetchAll() async {
    try {
      final database = await GetIt.I.get<DatabaseService>().database;
      final coupons = await database
          .rawQuery('''SELECT * from $tableName ORDER BY end_time DESC''');
      return coupons
          .map((record) => CouponModel.fromSqfliteDatabase(record))
          .toList();
    } catch (err, s) {
      throw Error.throwWithStackTrace(err, s);
    }
  }

  //* 回傳id
  Future<int?> getId(String store_name) async {
    try {
      final db = await GetIt.I.get<DatabaseService>().database;
      List<Map<String, dynamic>> result = await db.query(
        tableName,
        where: "store_name = ?",
        whereArgs: [store_name],
        columns: ["id"],
      );
      if (result.isNotEmpty) {
        return result.first["id"] as int?;
      } else {
        return null;
      }
    } catch (err, s) {
      throw Error.throwWithStackTrace(err, s);
    }
  }

  Future<UpdateResult> update({
    required int id,
    required String? store_name,
    required String? category,
    required int? start_time,
    required int? end_time,
    required int? create_time,
    String? content,
    String? image_path,
  }) async {
    try {
      final database = await GetIt.I.get<DatabaseService>().database;
      final Map<String, dynamic> updatedData = {};

      if (store_name != null) updatedData["store_name"] = store_name;
      if (category != null) updatedData["category"] = category;
      if (start_time != null) updatedData["start_time"] = start_time;
      if (end_time != null) updatedData["end_time"] = end_time;
      if (create_time != null) updatedData["create_time"] = create_time;
      if (content != null) updatedData["content"] = content;
      if (image_path != null) updatedData["image_path"] = image_path;

      await database.rawUpdate(
          '''UPDATE $tableName SET store_name = ?, category = ?,start_time = ?,end_time = ?,create_time = ?,content = ?,image_path = ? where id = ?''',
          [
            store_name,
            category,
            start_time,
            end_time,
            create_time,
            content,
            image_path,
            id
          ]);
      return UpdateResult(isUpdated: true);
    } catch (err) {
      return UpdateResult(isUpdated: false, errorMessage: "$err");
    }
  }

  Future<DeleteResult> delete(int id) async {
    try {
      final database = await GetIt.I.get<DatabaseService>().database;
      await database.rawDelete('''DELETE FROM $tableName WHERE id = ?''', [id]);
      return DeleteResult(isDeleted: true);
    } catch (err) {
      return DeleteResult(isDeleted: false, errorMessage: "$err");
    }
  }

  //* 刪除資料表中所有資料
  Future<DeleteResult> deleteAllData() async {
    try {
      final database = await GetIt.I.get<DatabaseService>().database;
      await database.delete(tableName);
      return DeleteResult(isDeleted: true);
    } catch (err) {
      return DeleteResult(isDeleted: false, errorMessage: "$err");
    }
  }

  //* 刪除整個資料表
  Future<DeleteResult> deleteTable() async {
    try {
      final database = await GetIt.I.get<DatabaseService>().database;
      await database.execute("DROP TABLE $tableName");
      return DeleteResult(isDeleted: true);
    } catch (err, s) {
      return DeleteResult(isDeleted: false, errorMessage: "$err");
    }
  }
}
