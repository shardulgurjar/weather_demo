import 'package:weather_demo/data/model/weather_model.dart';

abstract class WeatherRepository {

/*
Fetch the weather conditon from city name
*/
  Future<WeatherModel> getWeatherCondition(String city);

}