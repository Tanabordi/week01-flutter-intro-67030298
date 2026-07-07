import 'package:flutter/material.dart';

// สร้าง Enum สำหรับเลือกสภาพอากาศเพื่อให้โค้ดอ่านง่ายและจัดการ Type ได้ดี
enum WeatherCondition { sunny, cloudy, rainy }

class WeatherCard extends StatelessWidget {
  final String cityName;
  final double temperature;
  final WeatherCondition condition;
  final int humidity;

  // Constructor รับค่าผ่าน Parameters
  const WeatherCard({
    super.key,
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.humidity,
  });

  // Helper method สำหรับเลือก Icon ตามสภาพอากาศ
  IconData _getWeatherIcon() {
    switch (condition) {
      case WeatherCondition.sunny:
        return Icons.wb_sunny_rounded;
      case WeatherCondition.cloudy:
        return Icons.cloud_rounded;
      case WeatherCondition.rainy:
        return Icons.umbrella_rounded;
    }
  }

  // Helper method สำหรับเลือกสี Icon ให้เหมาะสม
  Color _getIconColor() {
    switch (condition) {
      case WeatherCondition.sunny:
        return Colors.orangeAccent;
      case WeatherCondition.cloudy:
        return Colors.blueGrey;
      case WeatherCondition.rainy:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      // Material Design 3: ใช้ Filled Card และการจัดเงาแบบใหม่
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: Theme.of(context).colorScheme.surfaceVariant, 
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // ให้ Card ขยายขนาดตามเนื้อหาภายใน
          children: [
            // 1. ชื่อเมือง
            Text(
              cityName,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            // 2. ไอคอนสภาพอากาศและอุณหภูมิ
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getWeatherIcon(),
                  size: 64,
                  color: _getIconColor(),
                ),
                const SizedBox(width: 20),
                Text(
                  '${temperature.toStringAsFixed(1)}°',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 3. ความชื้น
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.water_drop_outlined, 
                     size: 18, 
                     color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 4),
                Text(
                  'Humidity: $humidity%',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
