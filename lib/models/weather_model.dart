import 'dart:convert';

class WeatherModel {
  final DateTime time;
  final double? temperature;
  final double? windSpeed;
  final double? humidity;
  final String? weatherCode;

  final String temperatureUnit;
  final String windSpeedUnit;
  final String humidityUnit;

  WeatherModel({
    required this.time,
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
    required this.weatherCode,
    this.temperatureUnit = "°C",
    this.windSpeedUnit = "km/h",
    this.humidityUnit = "%",
  });
  factory WeatherModel.fromJson(String jsonString, String type) {
    final dynamic jsonObject = json.decode(jsonString);
    var values = jsonObject[type];
    var units = jsonObject['${type}_units'];
    //parse jsonString and return WeatherModel
    return WeatherModel(
      time: DateTime.parse(values['time']),
      temperature: values['temperature_2m']?.toDouble(),
      windSpeed: values['wind_speed_10m']?.toDouble(),
      humidity: values['relative_humidity_2m']?.toDouble(),
      temperatureUnit: units['temperature_2m'],
      windSpeedUnit: units['wind_speed_10m'],
      humidityUnit: units['relative_humidity_2m'],
      weatherCode: values['weather_code']?.toString(),
    );
  }
}

class ForecastModel {
  final DateTime time;
  final WeatherModel currentWeather;
  final List<WeatherModel> hourlyForecast;

  ForecastModel({
    required this.time,
    required this.currentWeather,
    required this.hourlyForecast,
  });

  factory ForecastModel.fromJson(String jsonString) {
    final dynamic jsonObject = json.decode(jsonString);
    var currentWeather = WeatherModel.fromJson(jsonString, 'current');
    var hourlyForecast = List.generate((jsonObject['hourly']['time'] as List).length, (index) {
      return WeatherModel(
        time: DateTime.parse(jsonObject['hourly']['time'][index]),
        temperature: jsonObject['hourly']['temperature_2m'][index]?.toDouble(),
        windSpeed: jsonObject['hourly']['wind_speed_10m'][index]?.toDouble(),
        humidity: jsonObject['hourly']['relative_humidity_2m'][index]?.toDouble(),
        weatherCode: jsonObject['hourly']['weather_code'][index]?.toString(),
        temperatureUnit: jsonObject['hourly_units']['temperature_2m'],
        windSpeedUnit: jsonObject['hourly_units']['wind_speed_10m'],
        humidityUnit: jsonObject['hourly_units']['relative_humidity_2m'],
      );
    });
    return ForecastModel(
      time: DateTime.parse(jsonObject['current']['time']),
      currentWeather: currentWeather,
      hourlyForecast: hourlyForecast,
    );
  }
  
}