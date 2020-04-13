import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter_qr_scanner/src/models/scan_model.dart';
export 'package:flutter_qr_scanner/src/models/scan_model.dart';

class DBProvider{

  static Database _database;
  static final DBProvider db = DBProvider._(); 

  //Constructor privado
  DBProvider._();

  Future<Database>get database async{
    if(_database !=null) return _database;

    _database = await initDB();

    return _database;

  }

  initDB() async{
    //Direccion donde se encuentra la BD
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ScansDB1.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version)async{
        await db.execute(
          'CREATE TABLE Scans ('
          ' id INTEGER PRIMARY KEY,'
          ' type TEXT,'
          ' value TEXT'
          ')'
        );
      }
    );
  }

  //Crear registros
  Future<int> newScanRaw(ScanModel newScan) async{

    final db = await database;

    final res = await db.rawInsert(
      "INSERT Into Scans(id, type, value) "
      "VALUES ( ${ newScan.id }, '${ newScan.type }', '${ newScan.value }')"
    );
    return res;
  }

  //Otra forma de crear registros
  Future<int> newScan(ScanModel newScan) async {
    final db = await database;
    final res = await db.insert('Scans', newScan.toJson());
    return res;
  }

  //Obtener información
  Future<ScanModel> getScanId( int id) async{

    final db = await database;
    final res = await db.query('Scans', where:' id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;

  }

  Future<List<ScanModel>> getAllScan() async{

    final db = await database;
    final res = await db.query('Scans');
    List<ScanModel> list = res.isNotEmpty ? 
        res.map((item)=>ScanModel.fromJson(item)).toList() : [];
    return list;

  }
  
  Future<List<ScanModel>> getScansByType(String type) async{

    final db = await database;
    //final res = await db.query('Scans', where: ' type = ?', whereArgs: [type]);
    final res = await db.rawQuery("SELECT * FROM Scans WHERE type='$type'");
    List<ScanModel> list = res.isNotEmpty ? 
        res.map((item)=>ScanModel.fromJson(item)) : [];
    return list;
    
  }

  //Actualizar registros
  Future<int> updateScan(ScanModel newScan)async{
    final db = await database;
    final res = await db.update('Scans', newScan.toJson(), where:'id = ?', whereArgs: [newScan.id]);
    return res;
  }

  //Eliminar registros

  Future<int> deleteScan(int idToDelete) async{
    final db = await database;
    final res = await db.delete('Scans', where:'id = ?', whereArgs: [idToDelete]);
    return res;
  }

   Future<int> deleteAll() async{
    final db = await database;
    //final res = await db.delete('Scans');
    final res = await db.rawDelete('DELETE FROM Scans');
    return res;
  }


}