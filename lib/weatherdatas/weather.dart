import 'package:get/get.dart';

class Weather extends GetxController{
  int id;
  String main;
  String description;
  String icon;
  MainWeather mainweather;

  Weather({
    required this.id,
    required this.main,
    required this.mainweather,
    required this.description,
    required this.icon
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final weatherdata=json['weather'][0];
    return Weather(
        id: weatherdata["id"],
        main: weatherdata["main"],
        mainweather:MainWeather.fromJson(json['main']),
        description:weatherdata["description"],
        icon:weatherdata['icon']
      );
  }
}

class MainWeather {
  double temp;
  double feel;
  double temp_min;
  double temp_max;
  int pressure; // Changed from double to int
  int humidity; // Changed from double to int
  int sea_level; // Changed from double to int
  int grnd; // Changed from double to int

  MainWeather({
    required this.temp,
    required this.feel,
    required this.temp_min,
    required this.temp_max,
    required this.pressure,
    required this.humidity,
    required this.sea_level,
    required this.grnd,
  });

  factory MainWeather.fromJson(Map<String, dynamic> json) => MainWeather(
    temp: (json['temp']-273.15),
    feel: json['feels_like']-273.15,
    temp_min: json['temp_min'],
    temp_max: json['temp_max'],
    pressure: json['pressure'],
    humidity: json['humidity'],
    sea_level: json['sea_level'],
    grnd: json['grnd_level'],
  );
}
