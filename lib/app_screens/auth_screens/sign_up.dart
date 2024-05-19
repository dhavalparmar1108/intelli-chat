import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intelli_chat/screen_util/screen_util.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    SizeConstants.setScreenAwareConstant(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Sign Up" , style: Theme.of(context).textTheme.displayLarge,),
                SizedBox(height: 10.h),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "E-mail"
                  ),
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Name"
                  ),
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Password"
                  ),
                ),
                SizedBox(height: 10.h),
                ElevatedButton(onPressed: (){}, child: Text("Create Account"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
