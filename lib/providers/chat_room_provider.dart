import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/auth/auth_service.dart';
import 'package:firebase_project/db/db_helper.dart';
import 'package:firebase_project/models/message_model.dart';
import 'package:flutter/cupertino.dart';

class ChatRoomProvider extends ChangeNotifier {
  List<MessageModel> msgList = [];


  Future<void> addGroup(String groupName,String userid) {
    return DBHelper.addGroup(groupName, userid);

  }
  Future<void> addgroupMsg(String groupName,MessageModel messageModel){
    return DBHelper.addgroupMsg(groupName, messageModel);
  }


  Future<void> addMsg(String msg) {
    final messageModel = MessageModel(
        msgId: DateTime.now().microsecondsSinceEpoch,
        userUid: AuthService.user!.uid,
        userName: AuthService.user!.displayName,
        email: AuthService.user!.email!,
        userImage: AuthService.user!.photoURL,

        msg: msg,
        timestamp: Timestamp.fromDate(DateTime.now()));
    return DBHelper.addMsg(messageModel);
  }

  getAllChatRoomMessages() {
    DBHelper.getAllRoomMessage().listen((snapshot) {
      msgList = List.generate(snapshot.docs.length,
              (index) => MessageModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }
}
