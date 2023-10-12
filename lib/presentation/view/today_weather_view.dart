import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/model/domain/weather_model.dart';
import 'package:weather/viewmodel/today_weather_viewmodel.dart';

class TodayWeatherView extends StatefulWidget{
  late final TodayWeatherViewModel viewModel;

  TodayWeatherView(){
    this.viewModel = GetIt.instance<TodayWeatherViewModel>();
  }

  @override
  State<TodayWeatherView> createState() => _TodayWeatherViewState();
}

class _TodayWeatherViewState extends State<TodayWeatherView> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: FutureBuilder(
          future: widget.viewModel.getWeather(),
          builder: (BuildContext context,AsyncSnapshot snapshot){

            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child:CircularProgressIndicator());
            }else{
              return _Weather(snapshot.data);
            }
          },
        ),
      );
  }
}

class _Weather extends StatefulWidget{

  final weather;

  _Weather(this.weather);

  @override
  State<_Weather> createState() => _WeatherState();
}

class _WeatherState extends State<_Weather> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: Center(
          child: Column(
            children:
          ),
        )
      );
  }
}