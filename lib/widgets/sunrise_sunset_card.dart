import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SunriseSunsetCard extends StatelessWidget {
  final int sunriseTimestamp;
  final int sunsetTimestamp;

  const SunriseSunsetCard({super.key, required this.sunriseTimestamp, required this.sunsetTimestamp});

  String _formatTime(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat.jm().format(dateTime); // Converts to 12-hour format (e.g., 6:30 AM)
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              "Sunrise & Sunset",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Icon(Icons.wb_twighlight, color: Colors.orange, size: 40), // Correct sunrise icon
                    const SizedBox(height: 5),
                    const Text("Sunrise", style: TextStyle(fontSize: 16)),
                    Text(
                      _formatTime(sunriseTimestamp),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.nightlight_round, color: Colors.blue, size: 40), // Correct sunset icon
                    const SizedBox(height: 5),
                    const Text("Sunset", style: TextStyle(fontSize: 16)),
                    Text(
                      _formatTime(sunsetTimestamp),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
