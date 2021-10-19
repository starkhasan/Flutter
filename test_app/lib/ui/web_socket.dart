import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocket extends StatefulWidget {
  const WebSocket({ Key? key }) : super(key: key);

  @override
  _WebSocketState createState() => _WebSocketState();
}

class _WebSocketState extends State<WebSocket> {

  var textController = TextEditingController();

  final channel = WebSocketChannel.connect(Uri.parse('wss://echo.websocket.org'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Web Socket Example'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendMessage,
        child: const Icon(Icons.send),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: 'Send message to Web Socket',
                hintStyle: TextStyle(color: Colors.grey)
              )
            ),
            const SizedBox(height: 20),
            StreamBuilder(
              stream: channel.stream,
              builder: (BuildContext context,AsyncSnapshot snapshot){
                return Text('snapshot data : ${snapshot.data}');
              }
            )
          ]
        )
      )
    );
  }

  void sendMessage(){
    if(textController.text.isNotEmpty){
      channel.sink.add(textController.text);
    }
  }
}