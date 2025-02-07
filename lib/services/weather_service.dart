import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String _apiKey = '50394aa04359283e18a7a17340c48045';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static const String _oneCallUrl = 'https://api.openweathermap.org/data/2.5/onecall';
  static const String _airPollutionUrl = 'https://api.openweathermap.org/data/2.5/air_pollution';

  static Future<Map<String, dynamic>> getWeatherByLatLon(double lat, double lon) async {
    final response = await http.get(
      Uri.parse('$_baseUrl?lat=$lat&lon=$lon&appid=$_apiKey&units=metric'),
    );
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> getWeatherByCity(String city) async {
    final response = await http.get(
      Uri.parse('$_baseUrl?q=$city&appid=$_apiKey&units=metric'),
    );
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> getAQI(double lat, double lon) async {
    final response = await http.get(
      Uri.parse('$_airPollutionUrl?lat=$lat&lon=$lon&appid=$_apiKey'),
    );
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> getWeeklyForecast(double lat, double lon) async {
    final response = await http.get(
      Uri.parse('$_oneCallUrl?lat=$lat&lon=$lon&exclude=current,minutely,hourly,alerts&appid=$_apiKey&units=metric'),
    );
    return json.decode(response.body);
  }
}
