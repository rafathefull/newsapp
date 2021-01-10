import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/theme/tema.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/utils/stringExtension.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _ListaCategorias(),
            if (!newsService.isLoading)
              Expanded(
                  child: ListaNoticias(
                      newsService.getArticulosCategoriasSeleccionada)),
            if (newsService.isLoading)
              Expanded(
                  child: Center(
                child: CircularProgressIndicator(),
              ))
          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      height: 80.0,
      width: double.infinity,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                _categoryButton(categoria: categories[index]),
                SizedBox(
                  height: 5,
                ),
                Text(
                  categories[index].name.capitalize(),
                  softWrap: false,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _categoryButton extends StatelessWidget {
  final Category categoria;

  const _categoryButton({this.categoria});

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      // Controlamos el click de los iconos
      onTap: () {
        // Cuando estamos en un onTap, click, etc.. el evento no se tiene que redibujar
        // final newsService = Provider.of<NewsService>(context);
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(categoria.icon,
            color: (newsService.selectedCategory == this.categoria.name
                ? miTema.accentColor
                : Colors.black54)),
      ),
    );
  }
}
