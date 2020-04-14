import 'package:latlong/latlong.dart';

class ScanModel {

    int id;
    String type;
    String value;

    ScanModel({
        this.id,
        this.type, //entiendo que no es necesario ya que por el valor sabemos el tipo
        this.value,
    }){
      if(value.startsWith('http')){
        this.type = 'http';
      } else{
        this.type = 'geo';
      }
    }

    factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id    : json["id"],
        type  : json["type"],
        value : json["value"],
    );

    Map<String, dynamic> toJson() => {
        "id"    : id,
        "type"  : type,
        "value" : value,
    };

    LatLng getLatLng(){

      /*final  int separatorIndex = value.indexOf(',');
      final  int startIndex = value.indexOf(':')+1;
      final  double x = double.parse(value.substring(startIndex,separatorIndex));
      final  double y = double.parse(value.substring(separatorIndex+1, value.length));
      */

      final lalo = value.substring(value.indexOf(':')+1).split(',');
      final lat = double.parse(lalo[0]);
      final lng = double.parse(lalo[1]);
      return LatLng(lat, lng);
    }
}