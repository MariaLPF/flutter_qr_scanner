import 'package:flutter/material.dart';
import 'package:flutter_qr_scanner/src/pages/addresses_page.dart';
import 'package:flutter_qr_scanner/src/pages/home_page.dart';
import 'package:flutter_qr_scanner/src/pages/maps_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRReader App',
      initialRoute: 'home',
      routes: {
        'home'         : (BuildContext context) => HomePage(),
        //'mapsPage'     : (BuildContext context) => MapsPage(),
        //'addressesPage': (BuildContext context) => AddressesPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple
      )
    );
  }
}
