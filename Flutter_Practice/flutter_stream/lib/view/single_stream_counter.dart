import 'package:flutter/material.dart';
import 'package:flutter_stream/streams/single_stream.dart';
import 'package:flutter_stream/model/album_response.dart';

class SingleStreamCounter extends StatefulWidget {
  const SingleStreamCounter({Key? key}) : super(key: key);

  @override
  SingleStreamCounterState createState() => SingleStreamCounterState();
}

class SingleStreamCounterState extends State<SingleStreamCounter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('Single Stream')),
      body: Center(
        child: StreamBuilder<AlbumResponse>(
          stream: SingleStream().counterStream,
          initialData: AlbumResponse(userId: 0,id: 0,title: ''),
          builder: (context, snapshot){
            if(ConnectionState.active  == snapshot.connectionState && snapshot.data != null){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('UserId => ${snapshot.data!.userId}'),
                  Text('Id => ${snapshot.data!.id}'),
                  Text('Title => ${snapshot.data!.title}')
                ]
              );
            }else{
              return const Text('No Album Data');
            }
          }
        ),
      ),
    );
  }
}
