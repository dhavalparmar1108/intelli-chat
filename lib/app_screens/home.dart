import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intelli_chat/app_screens/my_profile.dart';
import 'package:intelli_chat/app_screens/search_user.dart';
import 'package:intelli_chat/constants/constants.dart';
import 'package:intelli_chat/cutsom_navigation/custom_navigation.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int currentIdx = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("users/${StaticConstants.userId}/chats");
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
          child:  Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              StreamBuilder(stream: FirebaseFirestore.instance.collection('users/${StaticConstants.userId}/chats').snapshots(),
                  builder: (context , snapshot){
                    snapshot.data?.docs.forEach((element) {
                    print(element.data().toString());
                    });
                if(!snapshot.hasData)
                  {
                    return Center(child: Text("No Chats"));
                  }
                return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context , idx){
                  return ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(snapshot.data!.docs[idx]['name']),
                    subtitle: Text("NA"),
                  );
                }, itemCount: snapshot.data!.docs.length,);
              })
            ],
          ),
        ),
      ),
    );
  }
}
