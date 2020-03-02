import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_demo/data/model/weather_model.dart';

class DBHelper {
  static Database _db;
  static const String ID = "id";
  static const String CITY = "city";
  static const String TEMP = "temp";
  static const String TABLE = "Weather";
  static const String DB_NAME = "weather_result.db";

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $CITY TEXT,$TEMP TEXT)");
  }

  Future<WeatherModel> save(WeatherModel weatherModel) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ($CITY, $TEMP) values ('" +
          weatherModel.city +
          "','" +
          weatherModel.temp +
          "')";
      return await txn.rawInsert(query);
    });  
    return weatherModel;
  }

  Future<List<WeatherModel>> getCityWeather(String city) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE,columns: [ID,CITY,TEMP],where: ' lower($CITY) = ?',whereArgs: ['$city']);    
    List<WeatherModel> weatherModelList = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        weatherModelList.add(WeatherModel.fromMap(maps[i]));
      }
    }
    dbClient.close();
    return weatherModelList;
  }
}
