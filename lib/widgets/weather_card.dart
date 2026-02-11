import 'package:comancheo_cv/cubits/base_cubits.dart';
import 'package:comancheo_cv/models/weather_model.dart';
import 'package:comancheo_cv/services/weather.dart';
import 'package:comancheo_cv/utils/wmo_codes.dart';
import 'package:comancheo_cv/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocBuilder<NullBoolCubit, bool?>(
      bloc: _weatherService.loading,
      builder: (context, loading) {
        return BlocBuilder<NullForecastModelCubit, ForecastModel?>(
          bloc: _weatherService.forecast,
          builder: (context, forecast) {
            return CustomCard(
              width: 155,
              height: 155,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (loading == true) ...[
                    const Center(child: CircularProgressIndicator()),
                  ] else if (forecast == null) ...[
                    const SizedBox(),
                  ] else ...[
                    Row(
                      children: [
                        Text('${forecast.currentWeather.windSpeed?.toStringAsFixed(0)} ', style: Theme.of(context).textTheme.headlineSmall),
                        Text(forecast.currentWeather.windSpeedUnit, style: Theme.of(context).textTheme.bodySmall),
                        Spacer(),
                        Text('${forecast.currentWeather.humidity?.toStringAsFixed(0)} ', style: Theme.of(context).textTheme.headlineSmall),
                        Text(forecast.currentWeather.humidityUnit, style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${forecast.currentWeather.temperature} ', style: Theme.of(context).textTheme.headlineMedium),
                        Text(forecast.currentWeather.temperatureUnit, style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    Text('${wmoCodes[forecast.currentWeather.weatherCode]?['day']?['description'] ?? 'Neznámé'}', style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }
}
