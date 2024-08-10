import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intelli_chat/app_screens/auth_screens/log_in.dart';
import 'package:intelli_chat/app_screens/auth_screens/sign_up.dart';
import 'package:intelli_chat/app_screens/home.dart';
import 'package:intelli_chat/app_screens/splash_screen.dart';
import 'package:intelli_chat/app_theme/themes.dart';
import 'package:intelli_chat/common_utilities/get_storage_utility/get_storage_functions.dart';
import 'package:intelli_chat/common_utilities/helper_functions.dart';
import 'package:intelli_chat/constants/constants.dart';
import 'package:intelli_chat/cutsom_navigation/custom_navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intllie',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: AppThemes().lightTheme(),
      darkTheme: AppThemes().darkTheme(),
      home: const MyHomePage(title: 'Intelli-Chat',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  fetchUser() {
    String? userId = StorageService().readData(Constants.userId);
    if(userId == null)
      {
        print("IF");
        Future.delayed(Duration(seconds: 4)).then((value) {
          CustomNavigation.pushAndRemoveUntil(
              context: context, className: Login());
        });
      }
    else
      {
        StaticConstants.userId = userId;
        Future.delayed(Duration(seconds: 4)).then((value) {
            CustomNavigation.pushAndRemoveUntil(context: context, className: Home());
         }
        );
      }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HelperFunctions().initializeControllers();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
