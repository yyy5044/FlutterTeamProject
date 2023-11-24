import 'package:flutter/material.dart';

class Weathers {
  static String rainy = 'assets/weather/cloud_with_lightning_and_rain_3d.png';
  static String snowy = 'assets/weather/cloud_with_snow_3d.png';
  static String windy = 'assets/weather/leaf_fluttering_in_wind_3d.png';
  static String sunny = 'assets/weather/sun_3d.png';
  static String sunnyWithCloud = 'assets/weather/sun_behind_large_cloud_3d.png';

  static List<String> weatherList = [
    sunny,
    sunnyWithCloud,
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
