import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/Provider/services/weather_service.dart';
import 'package:weather/model/domain/weather_model.dart';
import 'package:weather/Provider/services/location_service.dart';

class TodayWeatherViewModel extends ChangeNotifier{
  late WeatherModel weather;
  late final WeatherService weatherService;
  late final LocationService locationService;

  TodayWeatherViewModel(){
    this.weatherService = GetIt.instance<WeatherService>();
    this.locationService = GetIt.instance<LocationService>();
  }

  Future getWeather() async{
      weather = await weatherService.fetchTodaysWeatherAPI(locationService);
      return weather;
  }


}