import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:newsapp/src/services/news_service.dart';

class Tab1Page extends StatelessWidget {
  const Tab1Page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: Center(
        child: Text('Hola mundo'),
      ),
    );
  }
}
