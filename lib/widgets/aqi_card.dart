import 'package:flutter/material.dart';

class AQICard extends StatelessWidget {
  final double aqi;

  const AQICard({super.key, required this.aqi});

  @override
  Widget build(BuildContext context) {
    String aqiStatus = '';
    Color aqiColor = Colors.green;

    if (aqi == 1) {
      aqiStatus = 'Good';
      aqiColor = Colors.green;
    } else if (aqi == 2) {
      aqiStatus = 'Fair';
      aqiColor = Colors.yellow;
    } else if (aqi == 3) {
      aqiStatus = 'Moderate';
      aqiColor = Colors.orange;
    } else if (aqi == 4) {
      aqiStatus = 'Poor';
      aqiColor = Colors.red;
    } else if (aqi == 5) {
      aqiStatus = 'Very Poor';
      aqiColor = Colors.brown;
    }

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Air Quality Index', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(aqiStatus, style: TextStyle(fontSize: 16)),
              ],
            ),
            Text(
              'AQI: $aqi',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
