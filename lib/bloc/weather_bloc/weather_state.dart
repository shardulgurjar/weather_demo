
import 'package:equatable/equatable.dart';
import 'package:weather_demo/data/model/weather_model.dart';

class WeatherState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class WeatherNotSearched extends WeatherState{

}

class WeatherIsLoading extends WeatherState{

}

class WeatherLoaded extends WeatherState{
  WeatherModel weatherModel;
  
  WeatherLoaded(this.weatherModel);

  @override
  // TODO: implement props
  List<Object> get props => [weatherModel];
  
}

class WeatherNotLoaded extends WeatherState{

}