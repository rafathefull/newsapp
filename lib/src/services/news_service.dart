import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY = '400716e1b12149a786c3b6a28f628e81';

class NewsService with ChangeNotifier {
  String country = 'ar';

  List<Article> headlines = [];

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
  ];

  NewsService() {
    this.getTopHeadLines();
  }

  getTopHeadLines() async {
    final url = '$_URL_NEWS/top-headlines?country=$country&apiKey=$_APIKEY';
    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners(); // Notificamos a quien este en la escucha.
  }
}
