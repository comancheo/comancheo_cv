import 'package:auto_route/auto_route.dart';
import 'package:comancheo_cv/auto_route/app_router.gr.dart';
import 'package:comancheo_cv/cubits/base_cubits.dart';
import 'package:comancheo_cv/services/ctk_news.dart';
import 'package:comancheo_cv/widgets/custom_card.dart';
import 'package:comancheo_cv/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_drop_cap_text/flutter_drop_cap_text.dart';
import 'package:get_it/get_it.dart';
import 'package:rss_dart/domain/rss_item.dart';

class NewsCard extends StatefulWidget {
  const NewsCard({super.key});

  @override
  State<NewsCard> createState() => NewsCardState();
}

class NewsCardState extends State<NewsCard> {
  final CtkNewsService _ctkNewsService = GetIt.instance<CtkNewsService>();
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: () {
        context.router.push(NewsRoute());
      },
      child: BlocBuilder<NullBoolCubit, bool?>(
        bloc: _ctkNewsService.loading,
        builder: (context, loading) {
          return BlocBuilder<ListCubit<RssItem>, List<RssItem>>(
            bloc: _ctkNewsService.newsItems,
            builder: (context, items) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Zprávy ČTK", style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 20),
                  if (loading == true) ...[
                    const Center(child: CircularProgressIndicator()),
                  ] else if (items.isEmpty) ...[
                    const SizedBox(),
                  ] else
                    ...List.generate(3, (index) {
                      final RssItem item = _ctkNewsService.newsItems.state[index];
                      return DropCapText(
                        (item.title ?? '').trimLeft(),
                        style: Theme.of(context).textTheme.bodyMedium,
                        dropCap: (item.enclosure?.url == null)
                            ? null
                            : DropCap(
                                width: 60,
                                height: 60,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10, bottom: 10),
                                  child: ImageWidget(imagePath: item.enclosure!.url!, width: 50, height: 50),
                                ),
                              ),
                      );
                    }),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
