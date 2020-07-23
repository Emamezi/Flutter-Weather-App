import 'package:flutter/cupertino.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/weatherservice.dart';

class WeatherModel with ChangeNotifier {
  List<WeatherViewModel> weather = List<WeatherViewModel>();
  // WeatherService().fetc;
}

class WeatherViewModel {
  final Weather weather;
  WeatherViewModel({this.weather});

  String get condition {
    return this.weather.condition;
  }

  double get temp {
    return this.weather.temp;
  }

  double get humidity {
    return this.weather.humidity;
  }

  double get pressure {
    return this.weather.pressure;
  }
}
