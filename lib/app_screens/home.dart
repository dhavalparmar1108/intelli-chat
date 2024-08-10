import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intelli_chat/app_screens/chat_screen.dart';
import 'package:intelli_chat/app_screens/my_profile.dart';
import 'package:intelli_chat/app_screens/search_user.dart';
import 'package:intelli_chat/constants/constants.dart';
import 'package:intelli_chat/cutsom_navigation/custom_navigation.dart';
import 'package:intelli_chat/models/chat_model.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int currentIdx = 0;
  late StreamSubscription streamSubscription;
  List<ChatModel> chats = [];

  fetchChats()
  {
    streamSubscription = FirebaseFirestore.instance.collection('users/${StaticConstants.userId}/chats').orderBy('timestamp' , descending: true).snapshots().listen((event) {
      print(event.docChanges.length);
      event.docChanges.forEach((e) async {
        try
            {
              if(e.type == DocumentChangeType.modified)
                {
                  print("old " + e.oldIndex.toString() + " " + e.newIndex.toString());
                  chats.removeAt(e.oldIndex);
                  DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('users').doc(e.doc.id).get();
                  ChatModel chatModel = ChatModel(name: documentSnapshot['name'] , dp: "" , userId: e.doc.id);
                  setState(() {chats.add(chatModel);});
                  chats.insert(e.newIndex, chatModel);
                }
              else
                {
                  DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('users').doc(e.doc.id).get();
                  ChatModel chatModel = ChatModel(name: documentSnapshot['name'] , dp: "" , userId: e.doc.id);
                  setState(() {chats.add(chatModel);});
                  print("\n added");
                }
            }
            catch(e)
            {
              print("exc " + e.toString());
            }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchChats();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    streamSubscription.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIdx,
        onTap: (int i){
          setState(() {
            currentIdx = i;
          });
          switch(i)
          {
            case 1 : CustomNavigation.push(context: context, className: SearchUser());
            case 3 : CustomNavigation.push(context: context, className: MyProfile());
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.verified_outlined) , label: "updates"),
          BottomNavigationBarItem(icon: Icon(Icons.person) , label: "Profile")
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child:  StreamBuilder(stream: FirebaseFirestore.instance.collection('users/${StaticConstants.userId}/chats').orderBy('timestamp' , descending: true).snapshots(),
              builder: (context, snapshot){
                if(!snapshot.hasData)
                  {
                    return Container();
                  }
                return  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context , idx){
                      return ListTile(
                        onTap: (){
                          CustomNavigation.push(context: context, className: ChatScreen(UserId: snapshot.data!.docs.elementAt(idx).id));
                        },
                        leading: CircleAvatar(
                          backgroundColor: Colors.indigo,
                          child: Icon(Icons.person),
                        ),
                        title: Text(chats.isEmpty ? "" : chats.elementAt(idx).name??"", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
                        //subtitle: Text("NA"),
                      );
                    }, itemCount: snapshot.data!.docs.length);
              }),
        ),
      ),
    );
  }
}
