import 'package:Youtube/Api.dart';
import 'package:Youtube/Pesquisa.dart';
import 'package:Youtube/telas/biblioteca.dart';
import 'package:Youtube/telas/em_alta.dart';
import 'package:Youtube/telas/inicio.dart';
import 'package:Youtube/telas/inscricoes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp((MaterialApp(
    home: Home(),
  )));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _indiceAtual = 0;
  String resultado = "";

  @override
  Widget build(BuildContext context) {
    
    List<Widget> telas = [
      Inicio(resultado),
      EmAlta(),
      Inscricoes(),
      Biblioteca(),
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey,
          opacity: 1,
        ),
        backgroundColor: Colors.white,
        title: Image.asset(
          "imagens/youtube.png",
          width: 98,
          height: 22,
        ),
        actions: [
          /*IconButton(
              icon: Icon(Icons.videocam),
              onPressed: () {
                print("Video cam");
              }),*/
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                String res = await showSearch(
                  context: context,
                  delegate: Pesquisa(),
                );
                setState(() {
                  resultado = res;
                });
              }),
          /*IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                print("conta");
              })*/
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: telas[_indiceAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        currentIndex: _indiceAtual,
        onTap: (index) {
          setState(() {
            _indiceAtual = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
            backgroundColor: Colors.orange,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
            label: 'Em alta',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions),
            label: 'Inscrições',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Biblioteca',
            backgroundColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
