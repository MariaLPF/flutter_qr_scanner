import 'package:flutter/material.dart';
import 'package:flutter_qr_scanner/src/pages/addresses_page.dart';
import 'package:flutter_qr_scanner/src/pages/maps_page.dart';

class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever), 
            onPressed: (){},
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _createBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: (){

        },
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
}