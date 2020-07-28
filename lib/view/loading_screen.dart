import 'package:flutter/material.dart';
import 'package:weather_app/view/weather_page.dart';
import '../service/location_service.dart';
import '../service/weatherservice.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  @override
  void initState() {
    super.initState();
    getLocationData();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    _controller.addListener(() {
      setState(() {});
      print(_controller.value);
    });
  }

  Future<void> getLocationData() async {
    final location = await LocationService().getUserCurrentLocation();
    print(location.longitude);
    print(location.latitude);
    var weatherData =
        await WeatherService().getCurrentLocationWeather(location);
    print(weatherData);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => WeatherPage(
              weatherData: weatherData,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '🌥',
          style: TextStyle(
            fontSize: _animation.value * 100,
          ),
        ),
      ),
    );
  }
}
