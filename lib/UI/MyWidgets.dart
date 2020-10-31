import 'package:fluttertoast/fluttertoast.dart';

class MyWidgets {
  static DateTime currentBackPressTime;

  static String userId;
  static String userName;
  static String userEmail;
  static String userMobile;
  static String userPassword;

  static Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Double tap to exit");
      return Future.value(false);
    }
    return Future.value(true);
  }
}
