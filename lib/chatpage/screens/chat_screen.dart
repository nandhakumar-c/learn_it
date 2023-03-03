import 'package:flutter/material.dart';
import 'package:learn_it/chatpage/providers/chat_provider.dart';
import 'package:learn_it/chatpage/widgets/own_message.dart';
import 'package:provider/provider.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../models/user_model.dart';
import '../widgets/other_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController? controller;
  IO.Socket? socket;
  List<MessageModel>? message_list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
    controller = TextEditingController();
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    message_list = [...chatProvider.message_list];
  }

  void connect() {
    socket = IO.io('http://192.168.1.80:4000', <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false
    });
    socket!.connect();
    socket!.onConnect((_) {
      print('---connected to backend---');

      //Response From the Backend
      socket!.on('messageResponse', (data) {
        //data from backend
        final msg = MessageModel(
            message: data["text"],
            sender: data["name"],
            date: DateTime.parse(data['currentDate']),
            socketId: data['socketID']);
        setState(() {
          message_list!.add(msg);
        });
      });
    });

    socket!.onDisconnect((_) => print('disconnect'));
    socket!.on('fromServer', (_) => print(_));
  }

  void sendMessage(String message, String senderName, ChatProvider provider) {
    MessageModel ownMsg = MessageModel(
        date: DateTime.now(),
        socketId: socket!.id as String,
        message: message,
        sender: senderName);

    setState(() {
      message_list!.add(ownMsg);
      provider.addMessage(message_list!);
    });
    print(socket!.id);
    //emiting to backend
    socket!.emit('message', {
      // "type": "ownMsg",
      "text": message,
      "name": senderName,
      "id": "sample",
      "socketID": socket!.id as String,
      "currentDate": DateTime.now().toIso8601String()
    });
  }

  @override
  Widget build(BuildContext context) {
    final messageProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      // backgroundColor: Color(0xffF5FAFA),
      appBar: AppBar(
        title: Text(
          "In Call Messages",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.secondary),
        ),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            messageProvider.addMessage(message_list!);
            Navigator.of(context).pop();
          },
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: messageProvider.message_list.length,
              itemBuilder: (context, index) {
                final message_data = messageProvider.message_list[index];
                return message_data.socketId == socket!.id
                    ? OwnMessageWidget(
                        message: message_data.message,
                        sender: message_data.sender,
                      )
                    : OtherMessageWidget(
                        message: message_data.message,
                        sender: message_data.sender);
              },
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffDCEDF5),
                          contentPadding: EdgeInsets.all(20.0),
                          suffixIcon: IconButton(
                              onPressed: () {
                                sendMessage(
                                    controller!.text, "NK", messageProvider);
                                controller!.clear();
                              },
                              icon: Icon(Icons.send)),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(width: 0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(48),
                            ),
                          ),
                          hintText: "Type a message"),
                      controller: controller,
                    ),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
