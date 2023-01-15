import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_yellow_mind/constants/style.dart';
import 'package:my_yellow_mind/modules/authentication/provider/authProvider.dart';
import 'package:my_yellow_mind/modules/drawer/providers/database.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key, required this.friend});

  Map<String, dynamic> friend;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  String? myId;
  String? groupId;
  bool? isOnline;
  bool isLoading = true;
  @override
  void initState() {
    myId = Provider.of<AuthProvider>(context, listen: false).localUser.userId!;
    groupId = myId.hashCode > widget.friend['userId'].hashCode
        ? '${myId}-${widget.friend['userId']}'
        : '${widget.friend['userId']}-${myId}';
    FirebaseApi.addOnlineStatus(myId!, true);
    isOnlineStatus();
    super.initState();
  }

  Future<void> isOnlineStatus() async {
    isOnline = await FirebaseApi.isOnline(widget.friend['userId']);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              elevation: 2,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  // offline
                  Navigator.pop(context);
                  FirebaseApi.addOnlineStatus(myId!, false);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: Row(
                children: [
                  isOnline!
                      ? Container(
                          height: 10,
                          width: 10,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(50)),
                        )
                      : Container(
                          height: 10,
                          width: 10,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                  Text(
                    widget.friend['name'],
                    style: customTextStyle(14, FontWeight.w600),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.call),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.videocam),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('messages')
                          .doc(groupId)
                          .collection(groupId!)
                          .orderBy('createdAt', descending: false)
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        return snapshot.data!.docs.isEmpty
                            ? const Center(child: Text('No chat yet'))
                            : ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        left: 20,
                                        right: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          snapshot.data!.docs[index]['from'] ==
                                                  myId
                                              ? MainAxisAlignment.end
                                              : MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            snapshot.data!.docs[index]
                                                        ['from'] ==
                                                    myId
                                                ? const SizedBox.shrink()
                                                : Column(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 25,
                                                        backgroundImage:
                                                            NetworkImage(''),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        DateFormat('hh:mm a')
                                                            .format(snapshot
                                                                .data!
                                                                .docs[index][
                                                                    'createdAt']
                                                                .toDate())
                                                            .toString(),
                                                        style: customTextStyle(
                                                            9, FontWeight.w300),
                                                      ),
                                                    ],
                                                  ),
                                            const SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 15,
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      color: snapshot.data!
                                                                          .docs[
                                                                      index]
                                                                  ['from'] ==
                                                              myId
                                                          ? const Color(
                                                              0xff5D9EFF)
                                                          : const Color(
                                                              0xffF6F6F6),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Text(
                                                    snapshot.data!.docs[index]
                                                        ['message'],
                                                    style: customTextStyle(
                                                        14, FontWeight.w500,
                                                        color: snapshot.data!
                                                                            .docs[
                                                                        index]
                                                                    ['from'] ==
                                                                myId
                                                            ? Colors.white
                                                            : Colors.black),
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                snapshot.data!.docs[index]
                                                            ['from'] ==
                                                        myId
                                                    ? Text(
                                                        DateFormat('hh:mm a')
                                                            .format(snapshot
                                                                .data!
                                                                .docs[index][
                                                                    'createdAt']
                                                                .toDate())
                                                            .toString(),
                                                        style: customTextStyle(
                                                            9, FontWeight.w300),
                                                      )
                                                    : const SizedBox.shrink(),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                      }),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            hintStyle: customTextStyle(14, FontWeight.w500),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          final message = Message(
                              from: myId!,
                              to: widget.friend['userId'],
                              message: messageController.text,
                              createdAt: DateTime.now());
                          FirebaseApi.addMessage(groupId!, message);
                          messageController.clear();
                          setState(() {});
                        },
                        icon: const Icon(Icons.send),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
