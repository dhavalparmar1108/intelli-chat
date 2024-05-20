import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNavigation {
  static Future push({required BuildContext context, required Widget className}) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => className),
    );
  }

  static void pushReplacement({required BuildContext context,required Widget className}) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => className),
    );
  }

  static pushAndRemoveUntil({required BuildContext context,required Widget className}) {
    Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => className), (route) => false);
  }
}
