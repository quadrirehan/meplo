import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meplo/Home.dart';
import 'package:meplo/ProductDetails.dart';
import 'package:meplo/UI/Menifo.dart';
import 'package:http/http.dart' as http;

import 'PostAd/PostAd1.dart';
import 'UI/MyWidgets.dart';

class MyAds extends StatefulWidget {
  @override
  _MyAdsState createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {
  int _bottomIndex = 2;
  Menifo menifo = Menifo();

  Future<List> getPosts() async {
    String url = menifo.getBseUrl() + "GetPost?user_id=${MyWidgets.userId}";
    var response = await http.get(
        Uri.encodeFull(url), headers: {'Accept': "application/json"});
    return jsonDecode(response.body);
  }

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
          onWillPop: MyWidgets.onWillPop,
          child: TabBarView(children: [
            FutureBuilder(future: getPosts(),
                builder: (context, snap) {
                  if (snap.hasData) {
                    if (snap.data.toString() == "[]") {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("You haven't listed anything yet",
                                style:
                                TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            SizedBox(height: 20),
                            Text("Let go of what you don't use anymore", style:
                            TextStyle(color: Colors.grey[700], fontSize: 12)),
                            SizedBox(height: 20),
                            Container(
                              height: 40,
                              width: 250,
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                          builder: (context) => PostAd1()));
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
                      );
                    } else {
                      return ListView.builder(
                        padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                          shrinkWrap: true,
                          itemCount: snap.data.length != 0
                              ? snap.data.length
                              : 0,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: EdgeInsets.only(bottom: 10),
                              shadowColor: Colors.lightBlueAccent,
                              borderOnForeground: true,
                              child: ListTile(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(snap.data[index]['posts_id'].toString(), snap.data[index]['posts_title'].toString(), snap.data[index]['posts_description'].toString(), snap.data[index]['posts_price'].toString(), snap.data[index]['posts_date'].toString(), snap.data[index]['posts_image_1'].toString(), snap.data[index]['posts_image_2'].toString(), snap.data[index]['posts_image_3'].toString(), snap.data[index]['posts_image_4'].toString(), snap.data[index]['posts_image_5'].toString())));
                                },
                                leading: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: CachedNetworkImage(
                                    imageUrl: menifo.getImageUrl() +
                                        snap.data[index]['posts_image_1'],
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.image)
                                  ),
                                ),
                                title: Text(snap.data[index]['posts_title'].toString()),
                                subtitle: Text("₹ " + snap.data[index]['posts_price'].toString()),
                              ),
                            );
                          });
                    }
                  } else if (snap.hasError) {
                    return Center(child: Text("Try Again Later!"));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("You haven't liked anything yet",
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 15),
                    Text("Collect all the things",
                        style: TextStyle(color: Colors.grey[700], fontSize: 12)),
                    Text("you like in one place",
                        style: TextStyle(color: Colors.grey[700], fontSize: 12)),
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
            ),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PostAd1()));
          },
          child: Icon(Icons.add_circle_outline, size: 60, color: Colors.black,),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _bottomIndex,
          showUnselectedLabels: true,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("HOME")),
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
                case 0:
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Home()));
                  ;
                  break;
                case 2:
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyAds()));
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
