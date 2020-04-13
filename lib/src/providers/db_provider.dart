import 'dart:io';

import 'package:flutter_qr_scanner/src/models/scan_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBPovider{

  static Database _database;
  static final DBPovider db = DBPovider._(); 

  //Constructor privado
  DBPovider._();

  Future<Database>get database async{
    if(_database !=null) return _database;

    _database = await initDB();

    return _database;

  }

  initDB() async{
    //Direccion donde se encuentra la BD
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version)async{
        await db.execute(
          'CREATE TABLE Scans ('
          ' id INTEGER PIMARY KEY,'
          ' type TEXT,'
          ' value TEXT'
          ')'
        );
      }
    );
  }

  //Crear registros
  newScanRaw(ScanModel newScan) async{

    final db = await database;

    final res = await db.rawInsert(
      "INSERT Into Scans(id, type, value) "
      "VALUES ( ${ newScan.id }, '${ newScan.type }', '${ newScan.value }')"
    );
    return res;
  }

  //Otra forma de crear registros
  newScan(ScanModel newScan) async {
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
        res.map((item)=>ScanModel.fromJson(item)).toString() : [];
    return list;

  }
  
   Future<List<ScanModel>> getScansByType(String type) async{

    final db = await database;
    //final res = await db.query('Scans', where: ' type = ?', whereArgs: [type]);
    final res = await db.rawQuery("SELECT * FROM Scans WHERE type='$type'");
    List<ScanModel> list = res.isNotEmpty ? 
        res.map((item)=>ScanModel.fromJson(item)).toString() : [];
    return list;
    
  }


}