import 'package:flutter/material.dart';
import 'package:flutter_qr_scanner/src/bloc/scan_bloc.dart';
import 'package:flutter_qr_scanner/src/models/scan_model.dart';

import 'package:flutter_qr_scanner/src/utils/Utils.dart' as Utils;

//import 'package:flutter_qr_scanner/src/providers/db_provider.dart';

class MapsPage extends StatelessWidget {

  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
   // return FutureBuilder<List<ScanModel>>(
      //future: DBProvider.db.getAllScan(),
    return StreamBuilder(
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }
        final scans = snapshot.data;
        if(scans.length == 0){
          return Center(child: Text('No hay informacion'));
        }
        return  ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context,  index) => Dismissible(
            key: UniqueKey(),
            background: Container(color: Colors.grey),
           // onDismissed: (direccion)=> DBProvider.db.deleteScan(scans[index].id),
            onDismissed: (direccion)=> scansBloc.deleteScan(scans[index].id),
            child: ListTile(
              leading: Icon(Icons.cloud_queue, color: Theme.of(context).primaryColor),
              title: Text(scans[index].value),
              subtitle: Text('ID: ${scans[index].id}'),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              onTap: ()=>Utils.openScan(context, scans[index]),
            ),
          )
        );
      },
    );
  }
}