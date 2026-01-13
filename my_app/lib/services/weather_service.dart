import 'package:http/http.dart'as http;
import 'dart:convert';
import '../models/weather.dart';
import 'package:flutter/foundation.dart';
class WeatherService {

  static const String apiKey = 'f2b5b59e4f2f2c9e0ff004ef67bc8972';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';


  static Future<Weather> getWeather(String cityName) async {
    try {
      String url = '$baseUrl?q=$cityName&appid=$apiKey&units=metric';

      if (kIsWeb) {
        url = 'https://corsproxy.io/?' + Uri.encodeComponent(url);
      }
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if(response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return Weather.fromJson(data);
      }
      else if (response.statusCode == 434) {
        throw Exception('City Not Found');
      }
      else{
        throw Exception('failed to load weather');
      }
    }
    catch(e){
      throw Exception('Error fething weather: $e');
    }
  }
}