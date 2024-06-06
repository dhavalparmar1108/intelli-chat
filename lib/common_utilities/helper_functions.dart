import 'package:get/get.dart';
import 'package:intelli_chat/common_utilities/get_storage_utility/get_storage_functions.dart';
import 'package:intelli_chat/constants/constants.dart';
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

  setUser(String name, String email, String userId)
  {
    StorageService().saveData(Constants.email, email);
    StorageService().saveData(Constants.name, name);
    StorageService().saveData(Constants.userId, userId);
  }
}