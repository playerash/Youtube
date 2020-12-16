import 'package:Youtube/Api.dart';
import 'package:Youtube/models/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class Inicio extends StatefulWidget {
  String pesquisa;
  Inicio(this.pesquisa);
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  _listarVideos(String pesquisa) {
    Api api = Api();

    return api.pesquisar(pesquisa);
  }

  @override
  void initState() {
    super.initState();
    print("chamado 1 - initstate");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("Chamado 2 - didchange");
  }

  @override
  void didUpdateWidget(covariant Inicio oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("Chamado 2 - didupdate");
  }

  @override
  void dispose() {
    super.dispose();
    print("Chamado 4 - Dispose");
  }

  @override
  Widget build(BuildContext context) {
    print("Chamdo 3 - build");
    return FutureBuilder<List<Video>>(
      future: _listarVideos(widget.pesquisa),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  List<Video> videos = snapshot.data;
                  Video video = videos[index];
                  return GestureDetector(
                    onTap: () {
                      FlutterYoutube.playYoutubeVideoById(
                          apiKey: CHAVE_YOUTUBE_API,
                          videoId: video.id,
                          autoPlay: true,
                          fullScreen: true);
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(video.imagem),
                                  fit: BoxFit.cover)),
                          height: 200,
                        ),
                        ListTile(
                          title: Text(video.titulo),
                          subtitle: Text(video.canal),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  height: 2,
                  color: Colors.grey,
                ),
                itemCount: snapshot.data.length,
              );
            } else {
              return Center(
                child: Text("Nada encontrado"),
              );
            }
            break;
        }
      },
    );
  }
}
