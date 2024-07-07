import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final weatherProvider = ChangeNotifierProvider<WeatherNotifier>((ref) {
  return WeatherNotifier();
});

class WeatherNotifier extends ChangeNotifier {
  Future<Map<String, double>> getCoordinates(String city) async {
    var url =
        "http://api.openweathermap.org/geo/1.0/direct?q=$city&appid=${dotenv.env['WEATHER_API']}";
    var res = await http.get(Uri.parse(url));
    var data = jsonDecode(res.body);
    var cityData = data[0];

    double latitude = cityData["lat"];
    double longitude = cityData["lon"];

    return {"lat": latitude, "lon": longitude};
  }

  double kelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }

  double msToKmh(double speedInMs) {
    return speedInMs * 3.6;
  }

  Future<Map<String, dynamic>> getWeather(String city) async {
    var coordinates = await getCoordinates(city);
    double latitude = coordinates['lat']!;
    double longitude = coordinates['lon']!;

    var weatherUrl =
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=${dotenv.env['WEATHER_API']}";
    var result = await http.get(Uri.parse(weatherUrl));
    var weatherdata = jsonDecode(result.body);

    var tempinK = weatherdata['main']['temp'];
    var temp = kelvinToCelsius(tempinK);
    var cond = weatherdata['weather'][0]['main'];
    var icon = weatherdata['weather'][0]['icon'];
    var humidity = weatherdata['main']['humidity'];
    var wSpeed = weatherdata['wind']['speed'];
    var windSpeed = msToKmh(wSpeed);

    return {
      "temperature": temp,
      "conditon": cond,
      "icon": icon,
      "humidity": humidity,
      "windSpeed": windSpeed
    };
  }
}
