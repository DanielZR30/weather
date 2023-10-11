import 'dart:convert';

class WeatherModel {
  String? _description;
  String? _icon;
  double? _temperature;
  String? _country;
  String? _city;
  DateTime? _date;

  WeatherModel(
      {String? description,
        String? icon,
        double? temperature,
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
  String? get country => _country;
  set country(String? country) => _country = country;
  String? get city => _city;
  set city(String? city) => _city = city;
  DateTime? get date => _date;
  set date(DateTime? date) => _date = date;

  WeatherModel.dayFromJson(Map<String, dynamic> json) {
    _description = json['weather'][0]['description'];
    _icon = json['weather'][0]['icon'];
    _temperature = json['main']['temp'];
    _country = json['sys']['country'];
    _city = json['name'];
    _date = DateTime.now();
  }
}