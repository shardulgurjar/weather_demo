
import 'package:weather_demo/bloc/weather_bloc/weather_event.dart';
import 'package:weather_demo/bloc/weather_bloc/weather_state.dart';
import 'package:bloc/bloc.dart';
import 'package:weather_demo/data/model/weather_model.dart';
import 'package:weather_demo/data/repository/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent,WeatherState>{

  WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository);

  @override
  // TODO: implement initialState
  WeatherState get initialState => WeatherNotSearched();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    // TODO: implement mapEventToState
    if(event is FetchWeatherEvent){
      yield WeatherIsLoading();
      try{
        WeatherModel weatherModel = await weatherRepository.getWeatherCondition(event.city);
        yield WeatherLoaded(weatherModel);
      }catch(e){
        yield WeatherNotLoaded();
      }
    }else if(event is ResetWeatherEvent){
      yield WeatherNotSearched();
    }
  }
}