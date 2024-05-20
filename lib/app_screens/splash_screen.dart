import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intelli_chat/screen_util/screen_util.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConstants.setScreenAwareConstant(context);
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: FlutterLogo(
          size: 60.sp,
        ),
      ),
    );
  }
}
