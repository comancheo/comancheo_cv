import 'package:comancheo_cv/services/ctk_news.dart';
import 'package:comancheo_cv/widgets/custom_card.dart';
import 'package:comancheo_cv/widgets/custom_scaffold.dart';
import 'package:comancheo_cv/widgets/map.dart';
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
  final CtkNewsService _ctkNewsService = GetIt.instance<CtkNewsService>();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      onRefresh: () async {
        return await _ctkNewsService.loadNews();
      },
      title: "Dashboard",
      body: [
        Row(children: [WeatherCard(),Spacer(),WeatherCard()]),
        SizedBox(height: 20),
        NewsCard(),
        SizedBox(height: 20),
        MapCard(),
      ],
    );
  }
}
