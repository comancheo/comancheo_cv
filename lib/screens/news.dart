import 'package:comancheo_cv/cubits/base_cubits.dart';
import 'package:comancheo_cv/services/ctk_news.dart';
import 'package:comancheo_cv/widgets/custom_scaffold.dart';
import 'package:comancheo_cv/widgets/news_item_card.dart';
import 'package:comancheo_cv/widgets/no_data_card.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rss_dart/domain/rss_item.dart';

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
    return BlocBuilder<NullBoolCubit, bool?>(
      bloc: _ctkNewsService.loading,
      builder: (context, loading) {
        return BlocBuilder<ListCubit<RssItem>, List<RssItem>>(
          bloc: _ctkNewsService.newsItems,
          builder: (context, items) {
            return CustomScaffold(
              primary: false,
              onRefresh: () async {
                return await _ctkNewsService.loadNews();
              },
              title: "Zprávy ČTK",
              body: [
                if (loading == true) ...[
                    const Center(child: CircularProgressIndicator()),
                  ] else if (items.isEmpty) ...[
                    const NoDataCard(),
                  ] else
                ...List.generate(_ctkNewsService.newsItems.state.length, (index) {
                  final item = _ctkNewsService.newsItems.state[index];
                  return NewsItemCard(title: item.title ?? '', description: item.description ?? '', imageUrl: item.enclosure?.url, link: item.link);
                }),
              ],
            );
          },
        );
      },
    );
  }
}
