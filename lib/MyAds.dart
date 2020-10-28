import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meplo/Home.dart';
import 'package:meplo/User/UserProfile.dart';

import 'PostAd/PostAd1.dart';
import 'UI/MyWidgets.dart';

class MyAds extends StatefulWidget {
  @override
  _MyAdsState createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {
  MyWidgets _myWidgets = MyWidgets();
  int _bottomIndex = 2;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Ads"),
          bottom: TabBar(labelPadding: EdgeInsets.all(8.0), tabs: [
            Text("ADS", style: TextStyle(fontSize: 15)),
            Text("FAVOURITES", style: TextStyle(fontSize: 15)),
          ]),
        ),
        body: WillPopScope(
          onWillPop: _myWidgets.onWillPop,
          child: TabBarView(children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("You haven't listed anything yet",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 20),
                  Text("Let go of what you don't use anymore",style:
                  TextStyle(color: Colors.grey[700], fontSize: 12)),
                  SizedBox(height: 20),
                  Container(
                    height: 40,
                    width: 250,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => PostAd1()));
                      },
                      child: Text("Post"),
                      color: Colors.black,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("You haven't liked anything yet",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 15),
                  Text("Collect all the things", style: TextStyle(color: Colors.grey[700], fontSize: 12)),
                  Text("you like in one place", style: TextStyle(color: Colors.grey[700], fontSize: 12)),
                  SizedBox(height: 18),
                  Container(
                    height: 40,
                    width: 250,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: Text("Discover"),
                      color: Colors.black,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PostAd1()));
          },
          child: Icon(Icons.add_circle_outline, size: 60, color: Colors.black,), backgroundColor: Colors.white, elevation: 0,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _bottomIndex,
          showUnselectedLabels: true,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("HOME")),
            BottomNavigationBarItem(
                icon: Icon(null), title: Text("SELL")),
            BottomNavigationBarItem(
                icon: Icon(Icons.font_download), title: Text("MY ADS")),
            /*BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text("ACCOUNT"),
          )*/
          ],
          onTap: (value) {
            setState(() {
              _bottomIndex = value;
              switch (value) {
                case 0: Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home()));;
                break;
                case 2:
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => MyAds()));
                  break;
              /*case 3: Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => UserProfile()));
                break;*/
              }
            });
          },
        ),
      ),
    );
  }
}
