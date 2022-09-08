import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/models/message_model.dart';
import '../models/UserModel.dart';

class DBHelper {
  static const String collectionUser = "users";
  static const String collectionRoomMessage = "ChatRoomMessages";

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addUser(UserModel userModel) {
    final doc = _db.collection(collectionUser).doc(userModel.uid);
    return doc.set(userModel.toMap());
  }

  static Future<void> addMsg(MessageModel messageModel) {
    return _db
        .collection(collectionRoomMessage)
        .doc()
        .set(messageModel.toMap());
  }
  static Future<void> addGroup(String groupName,String userid) {
    return _db
        .collection(groupName).doc(userid).set({});
  }
  static Future<void> addgroupMsg(String groupName,MessageModel messageModel) {
    return _db
        .collection(groupName)
        .doc()
        .set(messageModel.toMap());
  }


  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserByUid(
      String uid) =>
      _db.collection(collectionUser).doc(uid).snapshots();

  static Future<DocumentSnapshot<Map<String, dynamic>>> getUserByUidFuture(
      String uid) =>
      _db.collection(collectionUser).doc(uid).get();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllRoomMessage() => _db
      .collection(collectionRoomMessage)
      .orderBy("msgId", descending: true)
      .snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() => _db
      .collection(collectionUser)
      .orderBy("name", descending: true)
      .snapshots();

  static Future<void> updateAvailable(String uid, bool isAvailable) async {
    _db.collection(collectionUser).doc(uid).update({'available': isAvailable});
  }

  static Future<void> updateProfile(String uid, Map<String, dynamic> map) {
    return _db.collection(collectionUser).doc(uid).update(map);
  }
}
