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
}