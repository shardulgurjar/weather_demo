
class WeatherModel{
  int _id;
  String _city;
  String _temp;

  int get id  => (this._id);
  String get city => (this._city);
  String get temp => (this._temp);

  WeatherModel(this._id,this._city,this._temp);

  Map<String, dynamic> toMap(){
    var map = <String,dynamic> {'id':id,'city': city,'temp': temp};
    return map;
  }

  WeatherModel.fromMap(Map<String, dynamic> map){
    _id = map['id'];
    _city = map['city'];
    _temp = map['temp'];
  }

}