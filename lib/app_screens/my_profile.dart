import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intelli_chat/app_screens/auth_screens/log_in.dart';
import 'package:intelli_chat/common_utilities/get_storage_utility/get_storage_functions.dart';
import 'package:intelli_chat/constants/constants.dart';
import 'package:intelli_chat/cutsom_navigation/custom_navigation.dart';
import 'package:intelli_chat/models/user_data.dart';
import 'package:intelli_chat/screen_util/screen_util.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  late UserData userData = UserData();
  logout() async{
    StaticConstants.userId = "";
    await StorageService().erase();
    CustomNavigation.pushAndRemoveUntil(context: context, className: Login());
  }

  getUserInfo()
  {
    userData.name = StorageService().readData(Constants.name);
    userData.email = StorageService().readData(Constants.email);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getUserInfo();
    });
  }
  @override
  Widget build(BuildContext context) {
    SizeConstants.setScreenAwareConstant(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(onPressed: (){logout();}, icon: Icon(Icons.logout))
        ],
      ),
      body: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 30.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60.h,
                child: Icon(Icons.person),
              ),
            ],
          ),
          SizedBox(height: 20.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal : 10.w , vertical : 5.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 20.w,),
                    Expanded(
                      flex: 9,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name'),
                            Text(userData.name??"", style: TextStyle(fontSize: 18.sp),)
                          ],
                        ),
                      ),
                    ),
                    IconButton(onPressed: (){}, icon: Icon(Icons.edit))
                  ],
                ),
                SizedBox(height: 20.h,),
                Row(
                  children: [
                    Icon(Icons.info_outline),
                    SizedBox(width: 20.w,),
                    Expanded(
                      flex: 9,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('About'),
                            Text("..." , style: TextStyle(fontSize: 18.sp),)
                          ],
                        ),
                      ),
                    ),
                    IconButton(onPressed: (){}, icon: Icon(Icons.edit))
                  ],
                ),
                SizedBox(height: 20.h,),
                Row(
                  children: [
                    Icon(Icons.email_outlined),
                    SizedBox(width: 20.w,),
                    Expanded(
                      flex: 9,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email'),
                            Text(userData.email??"" , style: TextStyle(fontSize: 18.sp),)
                          ],
                        ),
                      ),
                    ),
                    IconButton(onPressed: (){}, icon: Icon(Icons.edit))
                  ],
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
