


import 'dart:async';
import 'package:flutter_qr_scanner/src/bloc/validator.dart';
import 'package:flutter_qr_scanner/src/providers/db_provider.dart';

class ScansBloc with Validators{

  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc(){
    return _singleton;
  }

  ScansBloc._internal(){
    //Obtener Scans de la base de datos
    getAllScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream.transform(validarGeo);
  Stream<List<ScanModel>> get scansStreamHttp => _scansController.stream.transform(validarHttp);

  dispose(){
    _scansController?.close();
  }

  getAllScans() async{
    _scansController.sink.add(await DBProvider.db.getAllScan());
  }

  /*getScansByType(String type) async{
    _scansController.sink.add(await DBProvider.db.getScansByType(type));
  }*/

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