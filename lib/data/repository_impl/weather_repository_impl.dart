import 'dart:convert';

import 'package:weather_demo/data/database/db_helper.dart';
import 'package:weather_demo/data/model/weather_model.dart';
import 'package:weather_demo/data/repository/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:weather_demo/res/app_strings.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  @override
  Future<WeatherModel> getWeatherCondition(String city) async {
    var dbHelper = DBHelper();
    WeatherModel weatherModel;
    List<WeatherModel> mList =  await dbHelper.getCityWeather(city);
    if (mList.length > 0) {
      print("From Database");
      weatherModel = mList[0];
      print(weatherModel.city);
      return weatherModel;
    } else {
      print("From Network");
      String url = AppString.BASE_URL + "q=$city&APPID=" + AppString.API_KEY;
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonDecoded = json.decode(response.body);
        var weather = jsonDecoded['main'];
        weatherModel = new WeatherModel(
            jsonDecoded['id'], jsonDecoded['name'], weather['temp'].toString());
        dbHelper.save(weatherModel);
      }
      return weatherModel;
    }
  }
}
