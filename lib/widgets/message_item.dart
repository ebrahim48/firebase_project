import 'package:firebase_project/models/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth/auth_service.dart';
import '../utils/helper_function.dart';

class MessageItem extends StatelessWidget {
  final MessageModel messageModel;
  const MessageItem({Key? key, required this.messageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: messageModel.userUid == AuthService.user!.uid
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              messageModel.userName ?? messageModel.email,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(getFormattedDate(messageModel.timestamp.toDate()),
                style: TextStyle(fontSize: 12, color: Colors.grey)),
            SizedBox(
              height: 3,
            ),
            Text(
              messageModel.msg,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
