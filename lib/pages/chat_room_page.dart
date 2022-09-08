import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/chat_room_provider.dart';
import '../widgets/message_item.dart';

class ChatRoomPage extends StatefulWidget {
  static const routeName = "chat-room-page";
  const ChatRoomPage({Key? key}) : super(key: key);

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final messageController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    messageController.dispose();
    super.dispose();
  }
  bool isinit= true;

  @override
  void didChangeDependencies() {
    if(isinit){
      Provider.of<ChatRoomProvider>(context, listen: false).getAllChatRoomMessages();
      isinit= false;

    }

    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ChatRoomProvider>(
        builder: (context, provider,_)=>
            Column(
              children: [
                Expanded(
                    child: ListView.builder(
                        reverse: true,
                        itemCount: provider.msgList.length,
                        itemBuilder: (context, index){
                          final msg = provider.msgList[index];
                          return MessageItem(messageModel: msg);
                        })),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                            controller: messageController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16))),
                          )),
                      IconButton(
                          onPressed: () {
                            provider.addMsg(messageController.text);
                            messageController.clear();

                          },
                          icon: Icon(
                            Icons.send,
                            color: Theme.of(context).primaryColor,
                          ))
                    ],
                  ),
                )
              ],
            ),
      ),
    );
  }
}
