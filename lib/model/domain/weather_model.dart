import 'dart:convert';

class WeatherModel {
  String? _description;
  String? _icon;
  double? _temperature;
  double? _minTemperature;
  double? _maxTemperature;
  String? _country;
  String? _city;
  DateTime? _date;

  WeatherModel(
      {String? description,
        String? icon,
        double? temperature,
        double? minTemperature,
        double? maxTemperature,
        String? country,
        String? city,
        DateTime? date}) {
    if (description != null) {
      this._description = description;
    }
    if (icon != null) {
      this._icon = icon;
    }
    if (temperature != null) {
      this._temperature = temperature;
    }
    if (minTemperature != null) {
      this._minTemperature = minTemperature;
    }
    if (maxTemperature != null) {
      this._maxTemperature = maxTemperature;
    }
    if (country != null) {
      this._country = country;
    }
    if (city != null) {
      this._city = city;
    }
    if (date != null) {
      this._date = date;
    }
  }

  String? get description => _description;
  set description(String? description) => _description = description;
  String? get icon => _icon;
  set icon(String? icon) => _icon = icon;
  double? get temperature => _temperature;
  set temperature(double? temperature) => _temperature = temperature;
  double? get minTemperature => _minTemperature;
  set minTemperature(double? minTemperature) => _minTemperature = minTemperature;
  double? get maxTemperature => _maxTemperature;
  set maxTemperature(double? maxTemperature) => _maxTemperature = maxTemperature;
  String? get country => _country;
  set country(String? country) => _country = country;
  String? get city => _city;
  set city(String? city) => _city = city;
  DateTime? get date => _date;
  set date(DateTime? date) => _date = date;

  WeatherModel.dayFromJson(Map<String, dynamic> json) {
    _description = json['weather'][0]['description'];
    _icon = json['weather'][0]['icon'];
    _temperature = json['main']['temp'].toDouble();
    _minTemperature = json['main']['temp_min'].toDouble();
    _maxTemperature = json['main']['temp_max'].toDouble();
    _country = json['sys']['country'];
    _city = json['name'];
    _date = DateTime.now();
  }

  WeatherModel.manyFromJson(Map<String,dynamic> json,String city, String country){
    _description = json['weather'][0]['description'];
    _icon = json['weather'][0]['icon'];
    _temperature = json['main']['temp'].toDouble();
    _minTemperature = json['main']['temp_min'].toDouble();
    _maxTemperature = json['main']['temp_max'].toDouble();
    _country = country;
    _city = city;
    _date = DateTime.parse(json['dt_txt']);
  }

  @override
  String toString() {
    return 'Clima para el dia de hoy (${date}) en ${city}-${country}: '
        '\nTemperatura:${temperature}'
        '\nDescripcion: ${description}';
  }
}