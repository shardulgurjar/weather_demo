import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_demo/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_demo/data/repository_impl/weather_repository_impl.dart';
import 'package:weather_demo/ui/search_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => WeatherBloc(WeatherRepositoryImpl()),
        child: SearchPage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
