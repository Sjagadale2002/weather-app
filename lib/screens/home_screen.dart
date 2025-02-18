import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import '../services/weather_service.dart';
import '../widgets/weather_card.dart';
import '../widgets/sunrise_sunset_card.dart';
import '../widgets/aqi_card.dart';
import '../widgets/weekly_forecast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String city = "Fetching...";
  double temperature = 0.0;
  int sunriseTimestamp = 0;
  int sunsetTimestamp = 0;
  double aqi = 0.0;
  bool isLoading = true;
  List<dynamic> weeklyData = [];



  @override
  void initState() {
    super.initState();
    _fetchWeatherForCurrentLocation();
  }

  Future<void> _fetchWeatherForCurrentLocation() async {
    setState(() => isLoading = true);
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      var weather = await WeatherService.getWeatherByLatLon(position.latitude, position.longitude);
      var aqiData = await WeatherService.getAQI(position.latitude, position.longitude);
      var weeklyForecast = await WeatherService.getWeeklyForecast(position.latitude, position.longitude);

      setState(() {
        city = weather["name"];
        temperature = weather["main"]["temp"].toDouble();
        sunriseTimestamp = weather["sys"]["sunrise"];
        sunsetTimestamp = weather["sys"]["sunset"];
        aqi = aqiData["list"][0]["main"]["aqi"].toDouble();
        weeklyData = weeklyForecast["daily"];
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> _fetchWeatherForCity(String cityName) async {
    setState(() => isLoading = true);
    try {
      var weather = await WeatherService.getWeatherByCity(cityName);
      var aqiData = await WeatherService.getAQI(weather["coord"]["lat"], weather["coord"]["lon"]);
      var weeklyForecast = await WeatherService.getWeeklyForecast(weather["coord"]["lat"], weather["coord"]["lon"]);

      setState(() {
        city = weather["name"];
        temperature = weather["main"]["temp"].toDouble();
        sunriseTimestamp = weather["sys"]["sunrise"];
        sunsetTimestamp = weather["sys"]["sunset"];
        aqi = aqiData["list"][0]["main"]["aqi"].toDouble();
        weeklyData = weeklyForecast["daily"];
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching city weather: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        title: const Text('Weather App'),
        elevation: 0,
        backgroundColor: Colors.blue[600],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search City...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (_searchController.text.isNotEmpty) {
                      _fetchWeatherForCity(_searchController.text);
                    }
                  },
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : Column(
              children: [
                WeatherCard(city: city, temperature: temperature),
                const SizedBox(height: 20),
                SunriseSunsetCard(
                  sunriseTimestamp: sunriseTimestamp,
                  sunsetTimestamp: sunsetTimestamp,
                ),
                const SizedBox(height: 20),
                AQICard(aqi: aqi),
                const SizedBox(height: 20),
                WeeklyForecastCard(weeklyData: weeklyData),
              ],
            ),
          ],
        ),
      ),
    );
  }
}