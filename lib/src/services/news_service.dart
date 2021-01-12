import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/src/models/news_source_model.dart';

final _url_news = 'https://newsapi.org/v2';
final _apikey = 'TODO';

class NewsService with ChangeNotifier {
  String country = 'us';
  String _selectedCategory = 'general';
  String _seletedSource = '';

  bool _isLoading = false; // Si esta cargando el segundo tab2

  List<SourceNews> _sourceList = [];

  List<Article> headlines = [];

  List<Categoria> categories = [
    Categoria(FontAwesomeIcons.addressCard, 'general'),
    Categoria(FontAwesomeIcons.building, 'business'),
    Categoria(FontAwesomeIcons.headSideVirus, 'health'),
    Categoria(FontAwesomeIcons.vials, 'science'),
    Categoria(FontAwesomeIcons.volleyballBall, 'sports'),
    Categoria(FontAwesomeIcons.memory, 'technology'),
    Categoria(FontAwesomeIcons.tv, 'entertainment'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadLines();
    categories.forEach((element) {
      this.categoryArticles[element.name] = [];
    });
    this.getArticlesByCategory(this._selectedCategory);
    this.getSourceList();
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

  List<SourceNews> get sourceList => this._sourceList;

  getTopHeadLines() async {
    var url = '$_url_news/top-headlines?apiKey=$_apikey';

    // No se puede mezclar country con source en la peticion.
    //final url = '$_url_news/top-headlines?country=$country&apiKey=$_apikey';
    if (_seletedSource.isEmpty) {
      url += '&country=$country';
    } else {
      url += '&sources=$_seletedSource';
    }

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

  get selectedSource => this._seletedSource;

  set selectedSource(String valor) {
    this._seletedSource = valor;
    this.headlines.clear();
    getTopHeadLines();
  }

  // Seleccionamos las fuentes que tenemos
  getSourceList() async {
    final url = '$_url_news/sources?apiKey=$_apikey&country=$country';
    final resp = await http.get(url);
    final newsResponse = newsSourceFromJson(resp.body);

    this.sourceList.addAll(newsResponse.sources);
    notifyListeners(); // Notificamos a quien este en la escucha.
  }
}
