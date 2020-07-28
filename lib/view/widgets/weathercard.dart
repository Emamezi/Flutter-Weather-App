import 'package:flutter/material.dart';
import 'package:weather_app/util/constants.dart';

class WeatherCard extends StatelessWidget {
  final String cardTitle;
  final IconData cardIcon;
  const WeatherCard({
    this.cardTitle,
    this.cardIcon,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Card(
            color: Colors.transparent,
            // elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    cardTitle,
                    style: kWeatherTitleTextStyle,
                  ),
                  Icon(
                    cardIcon,
                    size: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
