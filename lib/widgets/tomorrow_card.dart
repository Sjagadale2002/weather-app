import 'package:flutter/material.dart';

class TomorrowOutlookCard extends StatelessWidget {
  final String date;
  final double tempMin;
  final double tempMax;
  final String description;
  final String icon;

  const TomorrowOutlookCard({
    super.key,
    required this.date,
    required this.tempMin,
    required this.tempMax,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
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
                Text(date, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(description, style: const TextStyle(fontSize: 16)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Min: ${tempMin.toStringAsFixed(1)}°C\nMax: ${tempMax.toStringAsFixed(1)}°C',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Image.network('http://openweathermap.org/img/wn/$icon@2x.png', height: 40, width: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
