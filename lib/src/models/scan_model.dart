class ScanModel {

    int id;
    String type;
    String value;

    ScanModel({
        this.id,
        this.type,
        this.value,
    }){
      if(value.contains('http')){
        this.type = 'http';
      } else{
        this.type = 'geo';
      }
    }

    factory ScanModel.fromJson(Map<String, dynamic> json) => Client(
        id    : json["id"],
        type  : json["type"],
        value : json["value"],
    );

    Map<String, dynamic> toJson() => {
        "id"    : id,
        "type"  : type,
        "value" : value,
    };
}