import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_qr_scanner/config/constanst.dart';
import 'package:flutter_qr_scanner/src/models/scan_model.dart';

class ContainerMapPage extends StatefulWidget {

  @override
  _ContainerMapPageState createState() => _ContainerMapPageState();
}

class _ContainerMapPageState extends State<ContainerMapPage> {

  final controller = new MapController();

  final double defaultZoom = 15.0;
  final List<String> typeMaps = ['streets', 'dark', 'light', 'outdoors', 'satellite'];
  String currentMap='streets';

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location), 
            onPressed: (){
              controller.move(scan.getLatLng(), defaultZoom);
            },
          )
        ],
      ),
      body: _createFlutterMap(scan),
      floatingActionButton: _createButtonFloating(context)
    );
  }

  Widget _createFlutterMap(ScanModel scan) {

    return FlutterMap(
      mapController: controller,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom:defaultZoom
      ),
      layers: [
        _createMap(),
        _createMarks(scan),
      ],
    );
  }

  _createMap() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/' //servidor del mapa
            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken' : mapboxToken,
        'id' : 'mapbox.$currentMap' //Tipos streets, dark, lignt, autdoors, satellite
      }
    );
  }

  _createMarks(ScanModel scan) {

    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(),
          builder: (context) => Container(
            child: Icon(
              Icons.location_on, 
              size: 70.0,
              color: Theme.of(context).primaryColor,
            ),
          )
        )
      ]
    );

  }

  Widget _createButtonFloating(BuildContext context) {
    return FloatingActionButton(
      child : Icon(Icons.repeat),
      backgroundColor : Theme.of(context).primaryColor,
      onPressed: (){
        //Tipos streets, dark, lignt, autdoors, satellite
        int index = typeMaps.indexOf(currentMap);
        if(index + 1 == typeMaps.length){
          currentMap = typeMaps[0];
        }else{
          currentMap = typeMaps[index+1];
        }
        print('Nuevo tipo: $currentMap');
        setState(() {});
      }
    );
  }
}