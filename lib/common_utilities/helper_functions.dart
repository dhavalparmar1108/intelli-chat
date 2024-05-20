import 'package:get/get.dart';
import 'package:intelli_chat/get_controllers/sign_up_controllers/email_controller.dart';
import 'package:intelli_chat/get_controllers/sign_up_controllers/loading_controller.dart';
import 'package:intelli_chat/get_controllers/sign_up_controllers/name_controller.dart';
import 'package:intelli_chat/get_controllers/sign_up_controllers/password_controller.dart';

class HelperFunctions
{
  initializeControllers()
  {
    Get.lazyPut(()=> SignUpNameController());
    Get.lazyPut(() => SignUpEmailController());
    Get.lazyPut(() => SignUpPasswordController());
    Get.lazyPut(() => SignUpLoadingController());
  }

  showToast(String msg)
  {

  }
}