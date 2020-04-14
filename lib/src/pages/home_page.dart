
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_qr_scanner/src/bloc/scan_bloc.dart';
import 'package:flutter_qr_scanner/src/models/scan_model.dart';

import 'package:flutter_qr_scanner/src/pages/addresses_page.dart';
import 'package:flutter_qr_scanner/src/pages/maps_page.dart';
import 'package:flutter_qr_scanner/src/utils/Utils.dart' as Utils;

//import 'package:barcode_scan/barcode_scan.dart';

//import 'package:flutter_qr_scanner/src/providers/db_provider.dart';


class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansBloc = new ScansBloc();

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever), 
            onPressed: scansBloc.deleteAllScan
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _createBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () => _scanQR(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _callPage(int currentPage) {
    switch(currentPage){

      case 0: return MapsPage();
      case 1: return AddressesPage();

      default : return MapsPage();
    }
  }

  Widget _createBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex, //Indica elemento activo
      onTap: (index){
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon:Icon(Icons.map), title: Text('Mapas')),
        BottomNavigationBarItem(icon:Icon(Icons.brightness_5), title: Text('Direcciones'))
      ],

    );
  }

  _scanQR(BuildContext context) async{

    String futureString = 'https://fernando-herrera.com';
    String futureStringGeo = 'geo:43.34691726057801,-8.397832064236486';

    /*String futureString ='';
    try{
      futureString = await BarcodeScanner.scan();
    }catch(e){
      futureString = e.toString();
    }*/
    
    if(futureString != null){
      print('Tenemos información');
      final newScanValue = ScanModel(value: futureString);
      //DBProvider.db.newScan(newScanValue);
      scansBloc.addScan(newScanValue);

      final newScanValueGeo = ScanModel(value: futureStringGeo);
      scansBloc.addScan(newScanValueGeo);
      if(Platform.isIOS){
        Future.delayed(Duration(milliseconds: 750), (){
          Utils.openScan(context, newScanValue);
        });
      }else{
        Utils.openScan(context,newScanValue);
      }
    }
  }
}