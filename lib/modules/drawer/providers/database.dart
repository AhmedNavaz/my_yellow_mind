import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String? from;
  String? to;
  String? message;
  DateTime? createdAt;

  Message({
    this.from,
    this.to,
    this.message,
    this.createdAt,
  });

  Message.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    message = json['message'];
    createdAt = json['createdAt'].toDate();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['from'] = from;
    data['to'] = to;
    data['message'] = message;
    data['createdAt'] = createdAt;
    return data;
  }
}

class FirebaseApi {
  // upload message to firebase
  static Future<void> addMessage(String groupId, Message message) async {
    final docMessage = FirebaseFirestore.instance
        .collection('messages')
        .doc(groupId)
        .collection(groupId)
        .doc();

    await docMessage.set(message.toJson());
  }

  // add online status
  static Future<void> addOnlineStatus(String userId, bool status) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(userId);

    await docUser.set({'online': status});
  }

  // is online
  static Future<bool> isOnline(String userId) {
    final docUser = FirebaseFirestore.instance.collection('users').doc(userId);
    return docUser.get().then((value) => value.data()?['online'] ?? false);
  }

  // start free trial
  static Future<void> startFreeTrial(
      String userId, bool status, String endDate) async {
    final docUser =
        FirebaseFirestore.instance.collection('freeTrial').doc(userId);

    await docUser.set({'redeemed': status, 'endDate': endDate});
  }

  // get redeemed status
  static Future<bool> getRedeemedStatus(String userId) {
    final docUser =
        FirebaseFirestore.instance.collection('freeTrial').doc(userId);
    return docUser.get().then((value) => value.data()?['redeemed'] ?? false);
  }

  // get date of free trial
  static Future<DateTime> getFreeTrialDate(String userId) {
    final docUser =
        FirebaseFirestore.instance.collection('freeTrial').doc(userId);
    return docUser
        .get()
        .then((value) => DateTime.parse(value.data()?['endDate']));
  }
}
