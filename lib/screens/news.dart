import 'package:comancheo_cv/services/ctk_news.dart';
import 'package:comancheo_cv/widgets/custom_scaffold.dart';
import 'package:comancheo_cv/widgets/news_item_card.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => NewsScreenState();
}

class NewsScreenState extends State<NewsScreen> {
  final CtkNewsService _ctkNewsService = GetIt.instance<CtkNewsService>();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      primary: false,
      onRefresh: () async {
        return await _ctkNewsService.loadNews();
      },
      title: "Zprávy ČTK",
      body: [
        ...List.generate(_ctkNewsService.newsItems.length, (index) {
          final item = _ctkNewsService.newsItems[index];
          return NewsItemCard(
            title: item.title??'',
            description: item.description??'',
            imageUrl: item.enclosure?.url,
            link: item.link,
          );
        }),
      ],
    );
  }
}
