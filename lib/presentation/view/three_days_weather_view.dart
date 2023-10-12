import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:weather/viewmodel/three_days_weather_viewmodel.dart';

class ThreeDaysWeatherView extends StatefulWidget{

  late final ThreeDaysWeatherViewModel viewModel;

  ThreeDaysWeatherView(){
    this.viewModel = GetIt.instance<ThreeDaysWeatherViewModel>();
  }

  @override
  State<ThreeDaysWeatherView> createState() => _ThreeDaysWeatherViewState();
}

class _ThreeDaysWeatherViewState extends State<ThreeDaysWeatherView> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: FutureBuilder(
          future: widget.viewModel.getWeekWeather(),
          builder: (BuildContext context,AsyncSnapshot snapshot){

            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child:CircularProgressIndicator());
            }else{
              return _WeekWeather(snapshot.data);
            }
          },
        ),
      );
  }
}

class _WeekWeather extends StatefulWidget{

  final WeekWeather;

  _WeekWeather(this.WeekWeather);
  @override
  State<_WeekWeather> createState() => _WeekWeatherState();
}

class _WeekWeatherState extends State<_WeekWeather> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          body: Center(
            child: Column(
              children: <Widget>[
                Text('${
                    (widget.WeekWeather!=null)?widget.WeekWeather.toString():
                    "Error:\nPor favor verifique los permisos o la conexion a internet"}')
              ],
            ),
          )
      );
  }
}