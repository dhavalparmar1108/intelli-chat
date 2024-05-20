import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intelli_chat/app_screens/home.dart';
import 'package:intelli_chat/common_utilities/firbebase_helper/firebase_functions.dart';
import 'package:intelli_chat/common_utilities/get_storage_utility/get_storage_functions.dart';
import 'package:intelli_chat/cutsom_navigation/custom_navigation.dart';
import 'package:intelli_chat/get_controllers/sign_up_controllers/email_controller.dart';
import 'package:intelli_chat/get_controllers/sign_up_controllers/loading_controller.dart';
import 'package:intelli_chat/get_controllers/sign_up_controllers/name_controller.dart';
import 'package:intelli_chat/get_controllers/sign_up_controllers/password_controller.dart';
import 'package:intelli_chat/screen_util/screen_util.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  late SignUpNameController nameController;
  late SignUpEmailController emailController;
  late SignUpPasswordController passwordController;
  late SignUpLoadingController loadingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = Get.find<SignUpNameController>();
    emailController = Get.find<SignUpEmailController>();
    passwordController = Get.find<SignUpPasswordController>();
    loadingController = Get.find<SignUpLoadingController>();
  }
  @override
  Widget build(BuildContext context) {
    SizeConstants.setScreenAwareConstant(context);
    return SafeArea(
      child: Scaffold(
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
                    Text("Sign Up" , style: Theme.of(context).textTheme.displayLarge,),
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
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500
                      ),
                      onChanged: (val)
                      {
                        nameController.name.value = val;
                      },
                      validator: (String? value) {
                        return (value == null && value!.isEmpty) ? 'Please enter your name' : null;
                      },
                      decoration: const InputDecoration(
                          hintText: "Name"
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500
                      ),
                      onChanged: (val){
                        passwordController.password.value = val;
                      },
                      validator: (String? value) {
                        return (value == null && value!.isEmpty) ? 'Please enter password' : null;
                      },
                      decoration: const InputDecoration(
                          hintText: "Password"
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ElevatedButton(onPressed: () async {
                      FocusScope.of(context).unfocus();
                      loadingController.isLoading.value = true;
                      await Future.delayed(Duration(seconds: 3));
                      bool x =await FirebaseHelper().createUser(emailController.email.value, nameController.name.value,  passwordController.password.value);
                      if(x)
                        {
                          CustomNavigation.pushAndRemoveUntil(context: context, className: Home());
                        }
                      loadingController.isLoading.value = false;
                      }, child: const Text("Create Account"))
                  ],
                ),
              ),
            ),
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
      ),
    );
  }
}
