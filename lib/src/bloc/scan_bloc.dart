


import 'dart:async';
import 'package:flutter_qr_scanner/src/providers/db_provider.dart';

class ScansBloc{

  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc(){
    return _singleton;
  }

  ScansBloc._internal(){
    //Obtener Scans de la base de datos
    getAllScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream;

  dispose(){
    _scansController?.close();
  }

  getAllScans() async{
    _scansController.sink.add(await DBProvider.db.getAllScan());
  }

  addScan(ScanModel scan) async {
    await DBProvider.db.newScan(scan);
    getAllScans();
  }
  
  deleteScan(int id) async {
    await DBProvider.db.deleteScan(id);
    getAllScans();
  }

  deleteAllScan()async {
    await DBProvider.db.deleteAll();
    getAllScans();
    //_scansController.sink.add([]);

  }

}