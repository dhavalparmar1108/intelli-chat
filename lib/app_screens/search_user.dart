import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intelli_chat/screen_util/screen_util.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({super.key});

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  
  QuerySnapshot? searchedUsers;

  @override
  Widget build(BuildContext context) {
    SizeConstants.setScreenAwareConstant(context);
    return Scaffold(
      body: SafeArea(child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: TextField(
                  onChanged: (String val){
                    print(val);
                    FirebaseFirestore.instance.collection('users').where('name' , isEqualTo: val.toString()).get().then((value) {
                      setState(() {
                        searchedUsers = value;
                      });
                    });
                  },
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 17.sp),
                    hintText: 'Search',
                    suffixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    //focusedBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            searchedUsers != null ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context , idx){
                return ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text(searchedUsers!.docs.elementAt(idx)['name'])
                );
              } , itemCount: searchedUsers == null ? 0 : searchedUsers!.size,),
            ) : Container()
          ],
        ),
      )),
    );
  }
}
