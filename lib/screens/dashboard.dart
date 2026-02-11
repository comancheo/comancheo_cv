import 'package:comancheo_cv/services/ctk_news.dart';
import 'package:comancheo_cv/services/weather.dart';
import 'package:comancheo_cv/utils/geolocation.dart';
import 'package:comancheo_cv/widgets/custom_scaffold.dart';
import 'package:comancheo_cv/widgets/map_card.dart';
import 'package:comancheo_cv/widgets/news_card.dart';
import 'package:comancheo_cv/widgets/weather_card.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final GeolocationService _geolocationService;
  bool _geolocationReady = false;
  final CtkNewsService _ctkNewsService = GetIt.instance<CtkNewsService>();
  final WeatherService _weatherService = GetIt.instance<WeatherService>();

  @override
  void initState() {
    super.initState();
    GetIt.instance.getAsync<GeolocationService>().then((value) {
      _geolocationService = value;
      setState(() {
        _geolocationReady = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      onRefresh: () async {
        await Future.wait([if (_geolocationReady) _geolocationService.refresh(), _ctkNewsService.loadNews(), _weatherService.loadWeather()]);
      },
      title: "Dashboard",
      body: [
        Row(children: [WeatherCard(), Spacer(), WeatherCard()]),
        SizedBox(height: 20),
        NewsCard(),
        SizedBox(height: 20),
        MapCard(),
      ],
    );
  }
}
