import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _url_news = 'https://newsapi.org/v2';
final _apikey = '400716e1b12149a786c3b6a28f628e81';

class NewsService with ChangeNotifier {
  String country = 'us';
  String _selectedCategory = 'business';

  bool _isLoading = true; // Si esta cargando el segundo tab2

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

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadLines();
    categories.forEach((element) {
      this.categoryArticles[element.name] = [];
    });
  }

  bool get isLoading => this._isLoading;

  get selectedCategory => this._selectedCategory;

  set selectedCategory(String valor) {
    this._selectedCategory = valor;
    this._isLoading = true;
    this.getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article> get getArticulosCategoriasSeleccionada =>
      this.categoryArticles[this.selectedCategory];

  getTopHeadLines() async {
    final url = '$_url_news/top-headlines?country=$country&apiKey=$_apikey';
    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners(); // Notificamos a quien este en la escucha.
  }

  // Solo cogeremos una vez los articulos.
  getArticlesByCategory(String category) async {
    if (this.categoryArticles[category].length > 0) {
      this._isLoading = false;
      notifyListeners();
      return this.categoryArticles[category];
    }
    final url =
        '$_url_news/top-headlines?country=$country&apiKey=$_apikey&category=$category';
    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);

    this.categoryArticles[category].addAll(newsResponse.articles);
    this._isLoading = false;
    notifyListeners(); // Notificamos a quien este en la escucha.
  }
}
