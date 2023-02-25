import 'package:flutter/material.dart';
import 'package:learn_it/chatpage/widgets/own_message.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../models/user_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
TextEditingController? controller;
IO.Socket? socket;
List<MessageModel> message_list = [];
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
    controller = TextEditingController();
  }

  void connect(){
     socket = IO.io('http://localhost:3000',<String,dynamic>{"transports":["websocket"],"autoConnect":false});
  socket!.onConnect((_) {
    print('---connected to backend---');
  socket!.on('sendMessageFromBackEnd', (data){
    final msg = MessageModel(message: data["message"], type: data["type"], sender: data["sender"]);
    message_list.add(data);
  });
  });
  
  socket!.onDisconnect((_) => print('disconnect'));
  socket!.on('fromServer', (_) => print(_));
  }

  void sendMessage(String message,String senderName){

    MessageModel ownMsg = MessageModel(type: "ownMsg",message: message,sender: senderName);
    message_list.add(ownMsg);
      socket!.emit('message',{
        
        "type" : "ownMsg",
        "message": message,
        "sender":senderName
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Chat Screen")),
    
    body: Column(
      children: [
        Expanded(
          child: ListView(children: [
           OwnMessageWidget(),
            
          ]),
        ),
        Row(children: [
        
              Expanded(child: Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(decoration: InputDecoration(hintText: "Type a message"),controller: controller,))),
                IconButton(onPressed: (){
                  
                  sendMessage(controller!.text,"NK");
                  controller!.clear();
                  
                  },
                 icon: Icon(Icons.send))
            ])
      ],
    ),);
  }
}