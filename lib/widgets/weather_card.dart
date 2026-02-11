import 'package:comancheo_cv/services/weather.dart';
import 'package:comancheo_cv/utils/wmo_codes.dart';
import 'package:comancheo_cv/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class WeatherCard extends StatefulWidget {
  const WeatherCard({super.key});

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  final WeatherService _weatherService = GetIt.instance<WeatherService>();

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      width: 155,
      height: 155,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_weatherService.forecast?.currentWeather != null) ...[
            Row(
              children: [
                Text('${_weatherService.forecast!.currentWeather.windSpeed?.toStringAsFixed(0)} ', style: Theme.of(context).textTheme.headlineSmall),
                Text(_weatherService.forecast!.currentWeather.windSpeedUnit, style: Theme.of(context).textTheme.bodySmall),
                Spacer(),
                Text('${_weatherService.forecast!.currentWeather.humidity?.toStringAsFixed(0)} ', style: Theme.of(context).textTheme.headlineSmall),
                Text(_weatherService.forecast!.currentWeather.humidityUnit, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${_weatherService.forecast!.currentWeather.temperature} ', style: Theme.of(context).textTheme.headlineMedium),
                Text(_weatherService.forecast!.currentWeather.temperatureUnit, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            Text('${wmoCodes[_weatherService.forecast!.currentWeather.weatherCode]?['day']?['description'] ?? 'Neznámé'}', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ],
      ),
    );
  }
}
