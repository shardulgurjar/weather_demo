import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_demo/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_demo/bloc/weather_bloc/weather_event.dart';
import 'package:weather_demo/bloc/weather_bloc/weather_state.dart';
import 'package:weather_demo/data/model/weather_model.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  WeatherBloc weatherBloc;
  var cityController = TextEditingController();
  @override
  void initState() {
  weatherBloc = BlocProvider.of<WeatherBloc>(context);
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: SafeArea(
        child: BlocBuilder<WeatherBloc,WeatherState>(
          bloc: weatherBloc,
          builder: (context,state){
            if(state is WeatherNotSearched){
              return searchWeather(weatherBloc);
            }else if(state is WeatherIsLoading){
              return loading();
            }else if(state is WeatherLoaded){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  searchWeather(weatherBloc),
                  searchResult(state.weatherModel),
                ],
              );
            }else if(state is WeatherNotLoaded){
              return Text("Error",style: TextStyle(color:Colors.white),);
            }
            return null;
          })),
    );
  }


Widget loading(){
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget searchWeather(WeatherBloc blocWeather){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      TextField(
        controller: cityController,
        maxLines: 1,
        style: TextStyle(color:Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search,color: Colors.white),
          hintText: "Enter City Name",
          hintStyle: TextStyle(color:Colors.white)
        ),
      ),

      SizedBox(
        height: 30.0, 
      ),

      RaisedButton(
        color: Colors.blueAccent,
        onPressed: (){
          blocWeather.add(FetchWeatherEvent(cityController.text.toLowerCase()));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 40.0),
          child: Text("Search",style: TextStyle(color: Colors.white),),
        ),),
         RaisedButton(
        color: Colors.blueAccent,
        onPressed: (){
          cityController.clear();
          blocWeather.add(ResetWeatherEvent());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 40.0),
          child: Text("Search",style: TextStyle(color: Colors.white),),
        ),),
    ],
  );
}

Widget searchResult(WeatherModel weatherModel){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(weatherModel.city,style: TextStyle(color: Colors.white,fontSize: 22.0),),
      Text(weatherModel.temp,style: TextStyle(color: Colors.white,fontSize: 22.0),),
    ],
  );
}
}