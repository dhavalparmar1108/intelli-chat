
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constants.dart';
import '../models/chat_timestamp_model.dart';
import '../models/message_model.dart';
import '../models/user_data.dart';

class ChatScreen extends StatefulWidget {
  String UserId = "";
  ChatScreen({super.key, required this.UserId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String message = "";
  TextEditingController chatController = TextEditingController();
  late StreamController streamController;
  UserData userData = UserData();
  ScrollController controller = ScrollController();

  fetchUserInfo() async {
    print("user id " + widget.UserId);
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection(
        'users').doc(widget.UserId).get();
    userData = UserData.fromSnapshot(snapshot);
    setState(() {});
  }

  sendMessage(String message) async {
    try {
      MessageModel messageModel = MessageModel(
        message: message,
        type: 0,
        sent: true,
        timestamp: DateTime
            .now()
            .millisecondsSinceEpoch,
      );

      MessageModel receiveMessageModel = MessageModel(
        message: message,
        type: 0,
        sent: false,
        timestamp: DateTime
            .now()
            .millisecondsSinceEpoch,
      );

      ChatTimestampModel chatModel = ChatTimestampModel(timestamp: DateTime
          .now()
          .millisecondsSinceEpoch
          .toString());

      String docId = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();
      await FirebaseFirestore.instance.collection(
          'users/${StaticConstants.userId}/messages+${widget.UserId}').doc(
          docId).set(messageModel.toJson());
      await FirebaseFirestore.instance.collection(
          'users/${widget.UserId}/messages+${StaticConstants.userId}').doc(
          docId).set(receiveMessageModel.toJson());
      await FirebaseFirestore.instance.collection(
          'users/${StaticConstants.userId}/chats').doc(widget.UserId).set(
          chatModel.toJson());
      await FirebaseFirestore.instance.collection(
          'users/${widget.UserId}/chats').doc(StaticConstants.userId).set(
          chatModel.toJson());
    }
    catch (e) {
      print("etrr " + e.toString());
    }
  }

  Widget UserInfoHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 5.h),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.indigo,
            child: Icon(Icons.person),
          ),
          SizedBox(width: 10.w,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(userData.name ?? '', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchUserInfo();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            UserInfoHeader(),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users/${StaticConstants.userId}/messages+${widget.UserId}')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  return Padding(
                    padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 5.h),
                    child: ListView.builder(
                      reverse: true,
                      controller: controller,
                      physics: BouncingScrollPhysics(), // Allows for smoother scrolling
                      itemBuilder: (context, idx) {
                        return Align(
                          alignment: snapshot.data!.docs.elementAt(idx)['sent'] ? Alignment.topRight : Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
                            child: Container(
                              padding:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blueGrey,
                              ),
                              child: Text(
                                snapshot.data!.docs.elementAt(idx)['message'],
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 5.h),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: TextFormField(
                  controller: chatController,
                  onChanged: (String val) {
                    message = val;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.indigo,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        setState(() {
                          chatController.clear();
                        });
                        sendMessage(message);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}