import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meplo/Home.dart';
import 'package:meplo/User/UserProfile.dart';
import 'package:meplo/User/UserSettings.dart';
import 'UI/DatabaseHelper.dart';
import 'User/LogIn.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  DatabaseHelper db = DatabaseHelper.instance;
  int userCount;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3),() async {
      userCount = await db.getCount();
      if(userCount > 0){
        db.getUser().then((data) {
          print(data[0]['user_id'].toString());
        });
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogIn()));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: Text(
        "MEPLO",
        style: TextStyle(
            color: Colors.blue, fontSize: 40, fontWeight: FontWeight.bold),
      ),
    ),);
  }
}
