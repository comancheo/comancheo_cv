import 'package:comancheo_cv/cubits/base_cubits.dart';
import 'package:http/http.dart' as http;
import 'package:rss_dart/domain/rss_feed.dart';
import 'package:rss_dart/domain/rss_item.dart';
class CtkNewsService {

  static String ctkUrl = 'https://www.ceskenoviny.cz/sluzby/rss/zpravy.php';
  final ListCubit<RssItem> newsItems = ListCubit<RssItem>([]);
  final NullBoolCubit loading = NullBoolCubit();

  Future<CtkNewsService> init() async {
    await loadNews();
    return this;
  }

  Future<void> loadNews() async {
    loading.set(true);
    var uri = Uri.parse(ctkUrl);
    String xmlString = await http.read(uri);
    RssFeed rssFeed = RssFeed.parse(xmlString);
    newsItems.clear();
    newsItems.addAll(rssFeed.items);
    loading.set(false);
  }

}