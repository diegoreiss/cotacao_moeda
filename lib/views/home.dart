// https://api.flutter.dev/flutter/widgets/GestureDetector-class.html

import 'package:cotacao_moeda/services/cotacao_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController textEditingController = TextEditingController();
  List favoritos = [];

  void addFavorito(fav) {
    if (!favoritos.contains(fav)) {
      print('adicionado: ${fav}');
      favoritos.add(fav);
    }
  }

  void filtrar(filtro) {
    setState(() => {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home: Moedas'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: 'Pesquisar',
              ),
              onSubmitted: filtrar,
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: getAllCotacao(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      List<String> moedasIndex = snapshot.data.keys.toList();
                      List<String> moedasFiltro = moedasIndex
                          .where((moeda) =>
                              moeda.contains(textEditingController.text))
                          .toList();

                      return ListView.builder(
                          itemCount: moedasFiltro.length,
                          itemBuilder: (context, index) {
                            var moeda = snapshot.data[moedasFiltro[index]];
                            print(moeda);

                            return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onDoubleTap: () => addFavorito(
                                    '${moeda["code"]}-${moeda["codein"]}'),
                                child: Card(
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Text('${moeda['name']}'),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                  }))
        ],
      ),
    );
  }
}
