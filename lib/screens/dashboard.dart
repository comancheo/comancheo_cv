import 'package:comancheo_cv/services/calendar.dart';
import 'package:comancheo_cv/services/connection.dart';
import 'package:comancheo_cv/services/ctk_news.dart';
import 'package:comancheo_cv/services/weather.dart';
import 'package:comancheo_cv/utils/geolocation.dart';
import 'package:comancheo_cv/widgets/calendart_card.dart';
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
  final CalendarService _calendarService = GetIt.instance<CalendarService>();
  final ConnectionService _connectionService = GetIt.instance<ConnectionService>();

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
        await Future.wait([if (_geolocationReady) _geolocationService.refresh(), _connectionService.checkConnection(), _ctkNewsService.loadNews(), _weatherService.loadWeather(), _calendarService.loadTodayData()]);
      },
      title: "Dashboard",
      body: [
        Row(children: [WeatherCard(), Spacer(), CalendarCard()]),
        SizedBox(height: 20),
        NewsCard(),
        SizedBox(height: 20),
        MapCard(),
      ],
    );
  }
}
