import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:flutter_geo_qrscanner/src/models/scan_model.dart';
export 'package:flutter_geo_qrscanner/src/models/scan_model.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async {
    //path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "ScansDB.db");
    print(path);

    //crear la db
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
            CREATE TABLE Scans(
              id INTEGER PRIMARY KEY,
              type TEXT,
              value TEXT
            )
          ''');
      },
    );
  }

  newRawScan(ScanModel newScan) async {
    final id = newScan.id;
    final type = newScan.type;
    final value = newScan.value;

    final db = await database;

    final response = await db.rawInsert('''
      INSERT INTO Scans( id, type, value)
        VALUES($id, '$type', '$value')

    ''');

    return response;
  }

  Future<int> newScan(ScanModel newScan) async {
    final db = await database;
    final response = await db.insert("Scans", newScan.toJson());

    print(response);
    return response;
  }

  Future<ScanModel> getScanById(int id) async {
    final db = await database;
    final response = await db.query(
      "Scans",
      where: "id = ?",
      whereArgs: [id],
    );

    return response.isNotEmpty ? ScanModel.fromJson(response.first) : null;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final response = await db.query("Scans");

    return response.isNotEmpty
        ? response.map((el) => ScanModel.fromJson(el)).toList()
        : [];
  }

  Future<List<ScanModel>> getScansByType(String type) async {
    final db = await database;
    final response = await db.rawQuery('''
      SELECT * FROM Scans WHERE type = '$type'
    ''');

    return response.isNotEmpty
        ? response.map((el) => ScanModel.fromJson(el)).toList()
        : [];
  }

  Future<int> updateScan(ScanModel newScan) async {
    final db = await database;
    final response = await db.update(
      "Scans",
      newScan.toJson(),
      where: "id = ?",
      whereArgs: [newScan.id],
    );

    return response;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final response = await db.delete(
      "Scans",
      where: "id = ?",
      whereArgs: [id],
    );

    return response;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final response = await db.rawDelete('''
      DELETE FROM Scans
    ''');

    return response;
  }
}
