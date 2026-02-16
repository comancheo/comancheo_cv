import 'package:comancheo_cv/cubits/base_cubits.dart';
import 'package:comancheo_cv/models/weather_model.dart';
import 'package:comancheo_cv/services/weather.dart';
import 'package:comancheo_cv/utils/wmo_codes.dart';
import 'package:comancheo_cv/widgets/custom_card.dart';
import 'package:comancheo_cv/widgets/no_data_image.dart';
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
    return MultiBlocListener(
        listeners: [
          BlocListener<NullBoolCubit, bool?>(
            bloc: _weatherService.loading,
            listener: (context, state) {
              setState(() {});
            },
          ),
          BlocListener<NullForecastModelCubit, ForecastModel?>(
            bloc: _weatherService.forecast,
            listener: (context, state) {
              setState(() {});
            },
          ),
        ],
        child:CustomCard(
              width: 155,
              height: 155,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_weatherService.loading.state == true) ...[
                    const Center(child: CircularProgressIndicator()),
                  ] else if (_weatherService.forecast.state == null) ...[
                    const NoDataImage(),
                  ] else ...[
                    Row(
                      children: [
                        Text('${_weatherService.forecast.state!.currentWeather.windSpeed?.toStringAsFixed(0)} ', style: Theme.of(context).textTheme.headlineSmall),
                        Text(_weatherService.forecast.state!.currentWeather.windSpeedUnit, style: Theme.of(context).textTheme.bodySmall),
                        Spacer(),
                        Text('${_weatherService.forecast.state!.currentWeather.humidity?.toStringAsFixed(0)} ', style: Theme.of(context).textTheme.headlineSmall),
                        Text(_weatherService.forecast.state!.currentWeather.humidityUnit, style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${_weatherService.forecast.state!.currentWeather.temperature} ', style: Theme.of(context).textTheme.headlineMedium),
                        Text(_weatherService.forecast.state!.currentWeather.temperatureUnit, style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    Text('${wmoCodes[_weatherService.forecast.state!.currentWeather.weatherCode]?['day']?['description'] ?? 'Neznámé'}', style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ],
              ),
            )
        );
  }
}
