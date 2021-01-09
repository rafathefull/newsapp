import 'package:flutter/material.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';
import 'package:newsapp/src/services/news_service.dart';

class Tab1Page extends StatefulWidget {
  @override
  _Tab1PageState createState() => _Tab1PageState();
}

// Nota; AutomaticKeepAliveClientMixin nos permite mantener el estado dentro de la lista
class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
        body: (newsService.headlines.length == 0)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListaNoticias(newsService.headlines));
  }

  // Esto permite mantener el estado si cambiamos de pagina y volvemos a ella
  @override
  bool get wantKeepAlive => true;
}
