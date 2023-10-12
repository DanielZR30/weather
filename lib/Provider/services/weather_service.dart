import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:weather/Provider/services/location_service.dart';
import 'package:weather/model/domain/weather_model.dart';

class WeatherService{
  static const String _APIKEY = '09c09d16add0d692539d39d53701650a';
  late LocationData _LocationData;

  Future fetchTodaysWeatherAPI(LocationService locationService) async{
    try {
      await getDeviceLocation(locationService);

      var uri = Uri.https('api.openweathermap.org','data/2.5/weather',{
        'lat':'${_LocationData.latitude}','lon':'${_LocationData.longitude}','lang':'es',
        'appid':_APIKEY ,'units':'metric'
      });

      final res = await http.get(uri);

      if(res!=null && res.statusCode == 200){
        return WeatherModel.dayFromJson(json.decode(res.body));
      }
      throw new Exception("Error, intenta más tarde.");
    }catch(e){
      return null;
    }
  }

  Future fetch3daysWeatherAPI(LocationService locationService) async{
    try {
      await getDeviceLocation(locationService);

      var uri = Uri.https('api.openweathermap.org','data/2.5/forecast',{
        'lat':'${_LocationData.latitude}','lon':'${_LocationData.longitude}','lang':'es',
        'appid':_APIKEY ,'units':'metric','exclude':'minutely,hourly,current,alerts',
        'cnt': '30'
      });

      final res = await http.get(uri);

      if(res!=null && res.statusCode == 200){
        List<WeatherModel> weathers = getWeatherModelsFromJson(json.decode(res.body));
        return calculateWeathers(weathers);
      }
      throw new Exception("Error, intenta más tarde.");
    }catch(e){
      return null;
    }
  }

  List<WeatherModel> getWeatherModelsFromJson(Map<String, dynamic> json) {
    final weatherModels = <WeatherModel>[];
    for (final item in json['list']) {
      final weatherModel = WeatherModel.variousFromJson(item,
          json['city']['name'],json['city']['country']);
      weatherModels.add(weatherModel);
    }
    return weatherModels;
  }

  List<WeatherModel> calculateWeathers(List<WeatherModel> weathers){
    List<WeatherModel> newWeathers = [];
    WeatherModel auxWeather = new WeatherModel();
    for (final item in weathers) {
        if(validateDifferentDay(auxWeather.date,item.date)){
          if(auxWeather.date!=null){
            auxWeather.temperature = (auxWeather.maxTemperature! + auxWeather.minTemperature!)/2;
            auxWeather.date!.toLocal();
            newWeathers.add(auxWeather);
          }
          auxWeather = item;
        }else{
          auxWeather.minTemperature = min(auxWeather.minTemperature!, item.minTemperature!);
          auxWeather.maxTemperature = max(auxWeather.maxTemperature!, item.maxTemperature!);
        }
    }
    return newWeathers;
  }

  bool validateDifferentDay(DateTime? first,DateTime? second){
    if(first == null || second == null){
      return true;
    }
    return !(first.day == second.day && first.month == second.month && first.year == second.year);
  }

  Future getDeviceLocation(LocationService locationService) async{
    try {
      LocationData? locationData = (await locationService.getDeviceLocation());
      if (locationData == null) {
        throw new Exception("Error, No se puede acceder a la ubicacion.");
      }
      _LocationData = locationData;
    }catch(e){
      return e;
    }
  }
}
