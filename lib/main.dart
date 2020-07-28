import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view/loading_screen.dart';
import 'package:weather_app/view/weather_page.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(indicatorColor: Colors.grey),
      home: LoadingScreen(),
    );
  }
}
