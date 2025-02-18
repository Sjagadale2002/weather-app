import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeeklyForecastCard extends StatelessWidget {
  final List<dynamic> weeklyData;

  const WeeklyForecastCard({super.key, required this.weeklyData});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Weekly Forecast', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...weeklyData.map((day) {
              final DateTime date = DateTime.fromMillisecondsSinceEpoch(day["dt"] * 1000);
              final String dayName = DateFormat('EEE').format(date);
              final double temp = day["temp"]["day"];
              return ListTile(
                title: Text(dayName),
                subtitle: Text("Temp: ${temp.toStringAsFixed(1)}°C"),
                trailing: const Icon(Icons.wb_sunny, color: Colors.orange), // Fixed icon issue
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
