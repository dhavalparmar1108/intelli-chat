import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intelli_chat/app_screens/auth_screens/sign_up.dart';
import 'package:intelli_chat/app_screens/home.dart';
import 'package:intelli_chat/common_utilities/firbebase_helper/firebase_functions.dart';
import 'package:intelli_chat/screen_util/screen_util.dart';
import '../../cutsom_navigation/custom_navigation.dart';
import '../../get_controllers/login_controllers/email_controller.dart';
import '../../get_controllers/login_controllers/loading_controller.dart';
import '../../get_controllers/login_controllers/password_controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  late LoginEmailController emailController;
  late LoginPasswordController passwordController;
  late LoginLoadingController loadingController;

  bool isPasswordVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = Get.put(LoginEmailController());
    passwordController = Get.put(LoginPasswordController());
    loadingController = Get.put(LoginLoadingController());
  }

  @override
  Widget build(BuildContext context) {
    SizeConstants.setScreenAwareConstant(context);
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Login" , style: Theme.of(context).textTheme.displayLarge,),
                  SizedBox(height: 10.h),
                  TextFormField(
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500
                    ),
                    validator: (String? value) {
                      return (value != null && value.contains('@')) ? null : 'Do not use the @ char.';
                    },
                    onChanged: (val)
                    {
                      emailController.email.value = val;
                    },
                    decoration: const InputDecoration(
                        hintText: "E-mail"
                    ),
                  ),
                  SizedBox(height: 10.h),
                  TextFormField(
                    obscureText: !isPasswordVisible,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500
                    ),
                    onChanged: (val){
                      passwordController.password.value = val;
                    },
                    validator: (String? value) {
                      return (value == null && value!.isEmpty) ? 'Please enter password' : null;
                    },
                    decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: isPasswordVisible ? IconButton(
                            onPressed: (){
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            icon : Icon(Icons.visibility)) : IconButton(
                            onPressed: (){
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            icon : Icon(Icons.visibility_off))
                    ),
                  ),
                  SizedBox(height: 10.h),
                  ElevatedButton(onPressed: () async {
                    FocusScope.of(context).unfocus();
                    loadingController.isLoading.value = true;
                    await Future.delayed(Duration(seconds: 3));
                    bool x = await FirebaseHelper().login(emailController.email.value, passwordController.password.value);
                    if(x)
                    {
                      CustomNavigation.pushAndRemoveUntil(context: context, className: Home());
                    }
                    loadingController.isLoading.value = false;
                    }, child: Text("Login")),
                  SizedBox(height: 20.h),
                  InkWell(
                      onTap: (){
                        CustomNavigation.push(context: context, className: SignUp());
                      },
                      child: Text("Don't have an account ? Sign Up" , style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white
                      ),))
                ],
              ),
            ),
          ),
          /// Loading Widget
          Obx(() => loadingController.isLoading.value ? BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
                child: Center(
                  child: Container(
                      height: 5.sp,
                      width: 50.sp,
                      color: Colors.cyan,
                      child: LinearProgressIndicator()),
                ),
              )) : SizedBox(height: 0, width: 0,))
        ],
      ),
    );
  }
}
