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
              return Center(child:CircularProgressIndicator(color: Theme.of(context).primaryColor));
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
    TextTheme textTheme = Theme.of(context).textTheme;
    bool isModel =widget.weather is WeatherModel;
    WeatherModel data = new WeatherModel();
    if(isModel) data = widget.weather;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            (isModel)?'${data.city} - ${data.country}':'Algo salio mal.',
            style: textTheme.titleLarge,
          ),
          Text('last update: ${(isModel)?data.date:"No se tiene un ultimo registro."}',
              style: textTheme.bodyLarge),
          Image.network((isModel)?'https://openweathermap.org/img/wn/${data.icon}@2x.png':
          'https://openweathermap.org/img/wn/10d@2x.png'),
          Text((isModel)?'${data.description}':"--",style: textTheme.titleMedium),
          Text((isModel)?'${data.temperature}°C':'--',style: textTheme.titleLarge),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 80,
                width: 70,
                margin: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                    [
                      Text((isModel)?'${data.minTemperature}°C':'--',
                          style: textTheme.bodyLarge),
                      Text('max',
                          style: textTheme.bodyLarge),
                    ]
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 1,
                  ),
                ),
              ),Container(
                height: 80,
                width: 70,
                margin: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                  [
                    Text((isModel)?'${data.maxTemperature}°C':'--',
                        style: textTheme.bodyLarge),
                    Text('max',
                        style: textTheme.bodyLarge),
                  ]
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 1,
                  ),
                ),
              )
            ]
          )
        ],
      ),
    );
  }
}