import 'package:fluttertoast/fluttertoast.dart';

class MyWidgets {
  static DateTime currentBackPressTime;

  static String userId;
  static String userName;
  static String userDetails;
  static String userImage;
  static String userEmail;
  static String userMobile;
  static String userPassword;
  static String userImageUrl = baseUrl+"Meplo/public/Profile/";

  static String baseUrl = "http://192.168.5.111/";
  static String api = baseUrl+"Meplo/api/";
  static String categoriesUrl = baseUrl+"Meplo/public/Categories/";
  static String postImageUrl = baseUrl+"Meplo/public/Images/";

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
