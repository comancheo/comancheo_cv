import 'package:comancheo_cv/cubits/base_cubits.dart';
import 'package:comancheo_cv/services/connection.dart';
import 'package:comancheo_cv/utils/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:rss_dart/domain/rss_feed.dart';
import 'package:rss_dart/domain/rss_item.dart';
class CtkNewsService {

  static String ctkUrl = 'https://www.ceskenoviny.cz/sluzby/rss/zpravy.php';
  final ListCubit<RssItem> newsItems = ListCubit<RssItem>([]);
  final NullBoolCubit loading = NullBoolCubit();
  final ConnectionService connectionService = GetIt.instance.get<ConnectionService>();

  Future<CtkNewsService> init() async {
    await loadNews();
    return this;
  }

  Future<void> loadNews() async {
    loading.set(true);
    if(!connectionService.isConnectedCubit.state){
      loading.set(false);
      return;
    }
    var uri = Uri.parse(ctkUrl);
    try {
      String xmlString = await http.read(uri);
      RssFeed rssFeed = RssFeed.parse(xmlString);
      newsItems.clear();
      newsItems.addAll(rssFeed.items);
    } catch (e) {
      ScaffoldMessenger.of(globals.appRouter.navigatorKey.currentContext!).showSnackBar(
        const SnackBar(content: Text('Chyba při načítání zpráv')),
      );
    }
    loading.set(false);
  }

}