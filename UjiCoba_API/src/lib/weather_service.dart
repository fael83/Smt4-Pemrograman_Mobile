import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherData {
  final String cityName;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;
  final int visibility;
  final String country;

  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    required this.visibility,
    required this.country,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cityName: json['name'] ?? '',
      temperature: (json['main']['temp'] as num).toDouble(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      tempMin: (json['main']['temp_min'] as num).toDouble(),
      tempMax: (json['main']['temp_max'] as num).toDouble(),
      description: json['weather'][0]['description'] ?? '',
      icon: json['weather'][0]['icon'] ?? '',
      humidity: json['main']['humidity'] ?? 0,
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      visibility: json['visibility'] ?? 0,
      country: json['sys']['country'] ?? '',
    );
  }

  String get iconUrl => 'https://openweathermap.org/img/wn/$icon@2x.png';

  double get tempCelsius => temperature - 273.15;
  double get feelsLikeCelsius => feelsLike - 273.15;
  double get tempMinCelsius => tempMin - 273.15;
  double get tempMaxCelsius => tempMax - 273.15;
}

class WeatherService {
  static const String _apiKey = '3b43bba4e4d47dd6c6935f3e500cffc7';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  /// Ambil cuaca berdasarkan nama kota
  Future<WeatherData> getWeatherByCity(String cityName) async {
    final url = Uri.parse(
      '$_baseUrl/weather?q=$cityName&appid=$_apiKey&lang=id',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return WeatherData.fromJson(json);
    } else if (response.statusCode == 401) {
      throw Exception('API Key tidak valid. Cek kembali API Key kamu.');
    } else if (response.statusCode == 404) {
      throw Exception('Kota "$cityName" tidak ditemukan.');
    } else {
      throw Exception('Gagal mengambil data cuaca. Kode: ${response.statusCode}');
    }
  }

  /// Ambil cuaca berdasarkan koordinat GPS
  Future<WeatherData> getWeatherByCoordinates(
      double latitude, double longitude) async {
    final url = Uri.parse(
      '$_baseUrl/weather?lat=$latitude&lon=$longitude&appid=$_apiKey&lang=id',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return WeatherData.fromJson(json);
    } else {
      throw Exception('Gagal mengambil data cuaca: ${response.statusCode}');
    }
  }
}