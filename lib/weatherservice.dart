import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:weather_app/model/weather.dart';

const WEATHER_API_KEY = '7ed647beb78b9e2da5daff30f3412649';

class WeatherService {
  Future<Weather> fetchWeatherData(String cityName) async {
    final weatherUrl =
        'api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$WEATHER_API_KEY';
    final response = await http.get(weatherUrl);
    final weatherData = json.decode(response.body);
    return Weather.fromJSON(weatherData);
  }
}
