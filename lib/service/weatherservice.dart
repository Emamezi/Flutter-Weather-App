import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:weather_app/model/weather.dart';
import 'package:weather_app/service/location_service.dart';

const WEATHER_API_KEY = '7ed647beb78b9e2da5daff30f3412649';

class WeatherService {
  Future<dynamic> fetchWeatherData(String cityName) async {
    final weatherUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$WEATHER_API_KEY';
    final response = await http.get(weatherUrl);
    if (response.statusCode == 200) {
      final weatherData = json.decode(response.body);
      print(weatherData);
      return weatherData;
    } else {
      throw Exception('Not Working');
    }
  }

  Future<dynamic> getCurrentLocationWeather(UserLocation userLocation) async {
    final url =
        'http://samples.openweathermap.org/data/2.5/weather?lat=${userLocation.latitude}&lon=${userLocation.longitude}&appid=$WEATHER_API_KEY';
    final response = await http.get(url);
    final weatherData = json.decode(response.body);
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '🌧';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getWeatherBackground(int condition) {
    if (condition < 300) {
      return 'assets/images/thunder_storm.jpeg';
    } else if (condition < 600) {
      return 'assets/images/Drizzle.jpeg';
    } else if (condition < 700) {
      return 'assets/images/snow.jpeg';
    } else if (condition < 800) {
      return 'assets/images/atmosphere.jpeg';
    } else if (condition == 800) {
      return 'assets/images/clear_sky.jpg';
    } else if (condition <= 804) {
      return 'assets/images/clouds.jpg';
    } else {
      return 'assets/images/sunnyday_background.jpg';
    }
  }
}
