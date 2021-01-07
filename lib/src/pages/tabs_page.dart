import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => new _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  const _Navegacion({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtenemos la navegacion model
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
        currentIndex: navegacionModel.paginaActual,
        onTap: (value) => navegacionModel.paginaActual = value,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Text 1'),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Text 2'),
        ]);
  }
}

class _Paginas extends StatelessWidget {
  const _Paginas({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtenemos la navegacion model
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      onPageChanged: (value) => navegacionModel.paginaActual = value,
      children: [
        Container(
          color: Colors.red,
        ),
        Container(color: Colors.green)
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;

  int get paginaActual => this._paginaActual;
  set paginaActual(int valor) {
    this._paginaActual = valor;
    // Notificar a los widgets que la pagina a cambiado
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
