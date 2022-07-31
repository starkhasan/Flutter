import 'package:flutter/material.dart';
import 'package:flutter_stream/bloc/album_bloc.dart';
import 'package:flutter_stream/model/album_response.dart';

class StreamRxDart extends StatelessWidget {
  const StreamRxDart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    final AlbumBloc albumBloc = AlbumBloc();
    albumBloc.fetchAlbum();
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('Stream RX Dart Example')),
      body: Container(
        color: Colors.white,
        child: StreamBuilder(
          stream: albumBloc.allAlbum,
          builder: (context, snapshot) {
            if(ConnectionState.active == snapshot.connectionState && snapshot.data != null){
              var data = snapshot.data as List<AlbumResponse>;
              return ListView.builder(
                itemCount: data.length,
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index){
                  return Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(color: Colors.white,boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 2)],borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Text(data[index].title)
                  );
                }
              );
            }else{
              return const Center(child: CircularProgressIndicator());
            }
          }
        )
      )
    );
  }
}
