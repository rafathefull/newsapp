import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:provider/provider.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/utils/stringExtension.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [Expanded(child: _ListaCategorias())],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return ListView.builder(
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
    );
  }
}

class _categoryButton extends StatelessWidget {
  final Category categoria;

  const _categoryButton({this.categoria});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Controlamos el click de los iconos
      onTap: () {
        print('${categoria.name}');
      },
      child: Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: Icon(
            categoria.icon,
            color: Colors.black54,
          )),
    );
  }
}
