class WeatherModel{
  late double _Temperature;
  late String _Description;
  late String _City;
  late String _Icon;

  Weather(double temeperature,String description,
      String city, String icon){
    _Temperature = temeperature;
    _Description = description;
    _City = city;
    _Icon = icon;
  }

  double get Temperature{
    return _Temperature;
  }

  set Temperature(double temperature){
    _Temperature = temperature;
  }

  String get Description{
    return _Description;
  }

  set Description(String description){
    _Description = description;
  }

  String get City{
    return _City;
  }

  set City(String city){
    _City = city;
  }
  String get Icon{
    return _Icon;
  }

  set Icon(String icon){
    _Icon = icon;
  }

}