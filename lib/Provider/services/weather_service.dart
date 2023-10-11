import 'dart:async';
import 'dart:convert';

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
      return e;
    }
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
