import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/model/domain/weather_model.dart';

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
    bool isArray = widget.WeekWeather is List<WeatherModel>;
    return
      Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("3 Dias",style: Theme.of(context).textTheme.titleLarge,),
                Container(child: _DayWeather((isArray)?
                  widget.WeekWeather[0]:widget.WeekWeather)),
                Container(child: _DayWeather((isArray)?
                  widget.WeekWeather[1]:widget.WeekWeather)),
                Container(child: _DayWeather((isArray)?
                  widget.WeekWeather[2]:widget.WeekWeather)),
              ],
      );
  }
}

class _DayWeather extends StatefulWidget{
  final weather;

  _DayWeather(this.weather);

  @override
  State<_DayWeather> createState() => _DayWeatherState();
}

class _DayWeatherState extends State<_DayWeather> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    bool isModel = widget.weather is WeatherModel;
    WeatherModel data = new WeatherModel();
    if(isModel) data = widget.weather;
    return(
      Container(
        height: 150,
        margin: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child:Image.network((isModel)?'https://openweathermap.org/img/wn/${data.icon}@2x.png':
              'https://openweathermap.org/img/wn/10d@2x.png'),
            ),
            Column(
              children: [
                Text(
                  (isModel)?'${data.city} - ${data.country}':'Algo salio mal.',
                  style: textTheme.titleMedium,
                ),
                Text((isModel)?'${data.description}':"--",style: textTheme.titleSmall),
                Text('last update: '
                    '${(isModel)?data.date:"No se tiene un ultimo registro."}',
                    style: textTheme.bodyMedium,
                ),
                Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            margin: EdgeInsets.all(5),
                            alignment: Alignment.center,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                [
                                  Text((isModel)?
                                  '${data.temperature?.toStringAsFixed(2)}°C':'--',
                                  style: textTheme.bodyMedium),
                                  Text('AVG',
                                      style: textTheme.bodyMedium),
                                ]
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 1,
                              ),
                            ),
                          ),
                          Container(
                            height: 60,
                            width: 60,
                            margin: EdgeInsets.all(5),
                            alignment: Alignment.center,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                [
                                  Text((isModel)?'${data.minTemperature}°C':'--',
                                      style: textTheme.bodyMedium),
                                  Text('MIN',
                                      style: textTheme.bodyMedium),
                                ]
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 1,
                              ),
                            ),
                          ),
                          Container(
                            height: 60,
                            width: 60,
                            margin: EdgeInsets.all(5),
                            alignment: Alignment.center,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                [
                                  Text((isModel)?'${data.maxTemperature}°C':'--',
                                      style: textTheme.bodyMedium),
                                  Text('MAX',
                                      style: textTheme.bodyMedium),
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
                )
              ],
            )
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(0xff0e0e0e),
            width: 1,
          ),
        ),
      )
    );
  }
}