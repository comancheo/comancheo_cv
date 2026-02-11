import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rss_dart/domain/rss_feed.dart';
import 'package:rss_dart/domain/rss_item.dart';
class CtkNewsService {

  static String ctkUrl = 'https://www.ceskenoviny.cz/sluzby/rss/zpravy.php';
  List<RssItem> newsItems = [];
  Future<CtkNewsService> init() async {
    await loadNews();
    return this;
  }

  Future<void> loadNews() async {
    var uri = Uri.parse(ctkUrl);
    String xmlString = await http.read(uri);
    RssFeed rssFeed = RssFeed.parse(xmlString);
    newsItems = rssFeed.items;
  }

}