// https://api.flutter.dev/flutter/widgets/GestureDetector-class.html

import 'package:cotacao_moeda/services/cotacao_service.dart';
import 'package:cotacao_moeda/views/favorites.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController textEditingController = TextEditingController();
  List favoritos = [];

  gotoViewFavoritos() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Favorites(favoritos: favoritos,),
      )
    );
  }

  void addFavorito(fav) {
    setState(() {
      if (favoritos.contains(fav))
        favoritos.remove(fav);
      else
        favoritos.add(fav);
    });
  }

  void filtrar(filtro) {
    setState(() => {});
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
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
                              moeda.contains(textEditingController.text.toUpperCase()))
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text('${moeda['name']}'),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            child: Text(
                                                '${moeda['code']}-${moeda['codein']}'),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Maior Valor: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text('${moeda['high']}'),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Menor Valor: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text('${moeda['low']}'),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Variação: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text('${moeda['varBid']}')
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Variação Percentual: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text('${moeda['pctChange']}%')
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Preço de Compra: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text('${moeda['bid']}')
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Preço de Venda: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text('${moeda['ask']}')
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Data de atualização: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text('${moeda['create_date']}')
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      ),
                                      Icon(
                                        favoritos.contains(
                                                '${moeda['code']}-${moeda['codein']}')
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: Colors.cyan,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                  })),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: gotoViewFavoritos,
        backgroundColor: Colors.cyan,
        child: Icon(Icons.star),
      )
    );

    return scaffold;
  }
}
