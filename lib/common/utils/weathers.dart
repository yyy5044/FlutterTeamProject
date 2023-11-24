import 'package:flutter/material.dart';

class Weathers {
  static String rainy = 'assets/weather/weather=rainy.png';
  static String snowy = 'assets/weather/weather=snowy.png';
  static String windy = 'assets/weather/weather=windy.png';
  static String sunny = 'assets/weather/weather=sunny.png';
  static String cloudy = 'assets/weather/weather=cloudy.png';

  static String weatherButtonIcon = 'assets/weather/weather=weather6.png';

  static List<String> weatherList = [
    sunny,
    cloudy,
    windy,
    rainy,
    snowy,
  ];
  static List<Color> weatherColorList = [
    Colors.amber[200]!,
    Colors.blue[200]!,
    Colors.grey[350]!,
    Colors.deepPurple[300]!,
    Colors.blueGrey[300]!,
  ];
}
