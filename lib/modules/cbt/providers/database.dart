import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<void> addReply(
      String sessionId, String id, String text, DateTime createdAt) async {
    try {
      await FirebaseFirestore.instance
          .collection("cbt_sessions")
          .doc(sessionId)
          .collection("cbt_chat")
          .doc(id)
          .set({'sessionId': sessionId, 'text': text, 'createdAt': createdAt});
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
