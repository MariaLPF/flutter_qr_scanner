import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_qr_scanner/config/constanst.dart';
import 'package:flutter_qr_scanner/src/models/scan_model.dart';

class ContainerMapPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location), 
            onPressed: (){},
          )
        ],
      ),
      body: _createFlutterMap(scan),
    );
  }

  Widget _createFlutterMap(ScanModel scan) {

   
    return FlutterMap(
      options: MapOptions(
        center: scan.getLatLng(),
        zoom:15
      ),
      layers: [
        _creatMap(),
      ],
    );
  }

  _creatMap() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/' //servidor del mapa
            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken' : mapboxToken,
        'id' : 'mapbox.satellite' //Tipos streets, dark, lignt, autdoors, satellite
      }
    );
  }
}