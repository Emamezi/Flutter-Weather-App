import 'package:flutter/cupertino.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/service/weatherservice.dart';

class WeatherModel with ChangeNotifier {
  List<WeatherViewModel> weather = List<WeatherViewModel>();
  Future<void> fetchWeatherDatas(String cityName) async {
    final weData = await WeatherService().fetchWeatherData(cityName);
    this.weather =
        weData.map((data) => WeatherViewModel(weather: data)).toList();
    notifyListeners();
  }
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

  int get humidity {
    return this.weather.humidity;
  }

  double get pressure {
    return this.weather.pressure;
  }
}
