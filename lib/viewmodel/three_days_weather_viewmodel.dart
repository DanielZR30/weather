import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../Provider/services/location_service.dart';
import '../Provider/services/weather_service.dart';
import '../model/domain/weather_model.dart';

class ThreeDaysWeatherViewModel extends ChangeNotifier{
  late List<WeatherModel> weather;
  late final WeatherService weatherService;
  late final LocationService locationService;

  ThreeDaysWeatherViewModel(){
    this.weatherService = GetIt.instance<WeatherService>();
    this.locationService = GetIt.instance<LocationService>();
  }

  Future getWeekWeather() async{
    weather = await weatherService.fetch3daysWeatherAPI(locationService);
    return weather;
  }


}