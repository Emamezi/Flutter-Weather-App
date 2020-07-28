import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/util/constants.dart';
import 'package:weather_app/viewmodel/weatherViewModel.dart';

import './widgets/weathercard.dart';
import '../service/weatherservice.dart';

class WeatherPage extends StatefulWidget {
  final weatherData;
  WeatherPage({this.weatherData});
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _textEditingController = TextEditingController();
  bool _isLoading = false;
  int temperature;
  String condition;
  int hummidity;
  var pressure;
  String cityName;
  String description;
  String weatherIcon;
  String weatherBackground;
  int weatherId;
  @override
  void initState() {
    super.initState();
    upDateWeatherData(widget.weatherData);
  }

  void upDateWeatherData(dynamic weatherData) {
    setState(() {
      if (widget.weatherData == null) {
        temperature = 0;
        condition = 'Nothing yet';
        hummidity = 0;
        pressure = 0;
        description = 'Loading...';
        cityName = 'Default';
        weatherIcon = 'Default';
        weatherId = 0;
        weatherBackground = 'assets/images/sunnyday_background.jpeg';
        return;
      }
      _isLoading = true;
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      condition = weatherData['weather'][0]['main'];
      hummidity = weatherData['main']['hummidity'];
      var press = weatherData['main']['pressure'];
      pressure = press.toInt();
      cityName = weatherData['name'];
      weatherId = weatherData['weather'][0]['id'];
      weatherBackground =
          (WeatherService()..getWeatherBackground(weatherId)) as String;
      description = weatherData['weather'][0]['description'];
      weatherIcon =
          WeatherService().getWeatherIcon(weatherData['weather'][0]['id']);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/sunnyday_background.jpg'),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 70,
          ),
          child: SingleChildScrollView(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        height: 40,
                        child: TextField(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            labelText: 'Enter a city location',
                            prefixIcon: Icon(FontAwesomeIcons.searchLocation),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onSubmitted: (typedCityName) async {
                            if (typedCityName.isEmpty) {
                              return;
                            }
                            var cityWeatherData = await WeatherService()
                                .fetchWeatherData(typedCityName);
                            upDateWeatherData(cityWeatherData);
                            _textEditingController.clear();
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                '$cityName',
                                textAlign: TextAlign.right,
                                style: kcityLabelTextStyle,
                              ),
                              Text(
                                '$description',
                                style: kWeatherTitleTextStyle,
                              ),
                              Text(
                                '$weatherIcon',
                                textAlign: TextAlign.right,
                                style: kcityLabelTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          WeatherCard(
                            cardTitle: '$temperature °C',
                            cardIcon: FontAwesomeIcons.thermometerThreeQuarters,
                          ),
                          // WeatherCard(
                          //   cardTitle: '$condition',
                          //   cardIcon: FontAwesomeIcons.thermometerThreeQuarters,
                          // )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          WeatherCard(
                            cardTitle: '$pressure',
                          ),
                          WeatherCard(
                            cardTitle: '$hummidity',
                          ),
                        ],
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
