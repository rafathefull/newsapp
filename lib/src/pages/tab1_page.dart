import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_source_model.dart';
import 'package:newsapp/src/theme/tema.dart';
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
        body: Column(
      children: [
        _ListaSources(newsService.sourceList),
        Expanded(child: ListaNoticias(newsService.headlines)),
      ],
    ));
  }

  // Esto permite mantener el estado si cambiamos de pagina y volvemos a ella
  @override
  bool get wantKeepAlive => true;
}

class _ListaSources extends StatefulWidget {
  final List<SourceNews> sourceList;

  const _ListaSources(this.sourceList);

  @override
  __ListaSourcesState createState() => __ListaSourcesState();
}

class __ListaSourcesState extends State<_ListaSources> {
  @override
  Widget build(BuildContext context) {
    final sourceList = Provider.of<NewsService>(context).sourceList;
    return SafeArea(
      child: Container(
        height: 90.0,
        width: double.infinity,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: sourceList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  _sourceButton(sourceList[index]),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    sourceList[index].name,
                    softWrap: false,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _sourceButton extends StatelessWidget {
  final SourceNews sourceNews;

  const _sourceButton(this.sourceNews);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return GestureDetector(
      // Controlamos el click de los iconos
      onTap: () {
        // Cuando estamos en un onTap, click, etc.. el evento no se tiene que redibujar
        // final newsService = Provider.of<NewsService>(context);
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedSource = sourceNews.id;
      },
      child: Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: Icon(Icons.source,
              color: (newsService.selectedSource == this.sourceNews.id)
                  ? miTema.accentColor
                  : Colors.black54)),
    );
  }
}
