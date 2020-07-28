class Weather {
  final String condition;
  final int humidity;
  final double pressure;
  final double temp;

  Weather({this.condition, this.humidity, this.temp, this.pressure});

  factory Weather.fromJSON(Map<String, dynamic> json) {
    return Weather(
      condition: json['weather'][0]['main'],
      humidity: json['main']['humidity'],
      pressure: json['main']['pressure'],
      temp: json['main']['temp'],
    );
  }
}
