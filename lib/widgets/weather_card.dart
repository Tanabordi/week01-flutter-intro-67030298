import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final String city;
  final double temperature;
  final String condition;
  final int humidity;

  const WeatherCard({
    super.key,
    required this.city,
    required this.temperature,
    required this.condition,
    required this.humidity,
  });

  IconData _getWeatherIcon() {
    switch (condition.toLowerCase()) {
      case 'sunny':
        return Icons.wb_sunny;
      case 'cloudy':
        return Icons.cloud;
      case 'rainy':
        return Icons.water_drop;
      default:
        return Icons.wb_cloudy_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.blue.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade400, Colors.blue.shade800],
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              city,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getWeatherIcon(),
                  color: Colors.white,
                  size: 64,
                ),
                const SizedBox(width: 20),
                Text(
                  '${temperature.toStringAsFixed(1)}°',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 64,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.water_drop, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'Humidity $humidity%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
