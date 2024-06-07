import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '61a0c6e3613140e7993687f6713e8bbf';

  Future<Map<String, dynamic>> fetchWeatherData(String city) async {
    try {
      final weatherResponse = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric&lang=es'));
      final forecastResponse = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric&lang=es'));

      if (weatherResponse.statusCode == 200 && forecastResponse.statusCode == 200) {
        return {
          'weatherData': json.decode(weatherResponse.body),
          'forecastData': json.decode(forecastResponse.body),
        };
      } else {
        throw Exception('Error al cargar los datos del clima');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
      rethrow;
    }
  }
}
