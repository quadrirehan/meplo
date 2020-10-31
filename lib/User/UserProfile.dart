import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meplo/UI/MyWidgets.dart';
import 'package:meplo/User/UserSettings.dart';

import '../Home.dart';
import '../MyAds.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  MyWidgets _myWidgets = MyWidgets();
  int _bottomIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0,),
      body: WillPopScope(
        onWillPop: MyWidgets.onWillPop,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(left: 10, right: 10),
          shrinkWrap: true,
          children: [
            Container(
              // padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.all(10),
                          // height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.yellow[700],
                          ),
                          child: Icon(
                            Icons.person,
                            size: 100,
                          )),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text("Shams", style: TextStyle(fontSize: 25,
                            fontWeight: FontWeight.bold),),
                        Text("View and edit profile", style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold, decorationThickness: 1.5),),
                      ],
                      )
                    ],
                  ),
                  // SizedBox(height: 5),
                  // Text("Seller Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  // SizedBox(height: 5),
                  // Text("MEMBER SINCE FEB 15", style: TextStyle(fontSize: 10),),
                ],
              ),
            ),
            SizedBox(height: 20),
            ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: Icon(Icons.credit_card_rounded, color: Colors.black,),
                  title: Text("Buy Packages & My Orders"),
                  subtitle: Text("Packages, orders, billing and invoices"),
                  trailing: Icon(Icons.keyboard_arrow_right, color: Colors.black,),
                ),
                Divider(),
                ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserSettings()));
                  },
                  leading: Icon(Icons.settings_rounded, color: Colors.black,),
                  title: Text("Settings"),
                  subtitle: Text("Privacy and logout"),
                  trailing: Icon(Icons.keyboard_arrow_right, color: Colors.black,),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.help_outline, color: Colors.black,),
                  title: Text("Help & Support"),
                  subtitle: Text("Help center and legal terms"),
                  trailing: Icon(Icons.keyboard_arrow_right, color: Colors.black,),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.language_sharp, color: Colors.black,),
                  title: Text("Select Language / भाषा चुने"),
                  subtitle: Text("English (India)"),
                  trailing: Icon(Icons.keyboard_arrow_right, color: Colors.black,),
                ),
                Divider(),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomIndex,
        showUnselectedLabels: true,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("HOME")),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline), title: Text("SELL")),
          BottomNavigationBarItem(
              icon: Icon(Icons.font_download), title: Text("MY ADS")),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text("ACCOUNT"),
          )
        ],
        onTap: (value) {
          setState(() {
            _bottomIndex = value;
            switch (value) {
              case 0:
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home()));
                ;
                break;
              case 1:
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home()));
                break;
              case 2:
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => MyAds()));
                break;
              case 3:
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => UserProfile()));
                break;
            }
          });
        },
      ),
    );
  }
}
