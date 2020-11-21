import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:meplo/Location.dart';
import 'package:meplo/MyAds.dart';
import 'package:meplo/Post/SearchPosts.dart';
import 'file:///D:/Rehan/Android/flutter/meplo/lib/Post/PostsByCategory.dart';
import 'package:meplo/UI/DatabaseHelper.dart';
import 'package:meplo/UI/MyWidgets.dart';
import 'package:meplo/User/UserProfile.dart';
import 'package:meplo/User/UserSettings.dart';
import 'Post/PostAd/PostAd1.dart';
import 'Post/ProductDetails.dart';
import 'User/LogIn.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _bottomIndex = 0;

  List<Color> categoriesColour = [
    Colors.deepPurpleAccent[400],
    Colors.green[900],
    Colors.pinkAccent[400],
    Colors.green[800],
    Colors.deepOrange,
    Colors.purple[900],
  ];

  Future<List> getCategories() async {
    String url = MyWidgets.api + "GetCategories";
    print(url);
    var respose = await http
        .get(Uri.encodeFull(url), headers: {'Accept': "application/json"});
    return jsonDecode(respose.body);
  }

  Future<List> getAllPosts() async {
    String url = MyWidgets.api + "GetAllPost?user_id=${MyWidgets.userId}";
    print(url);
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': "application/json"});
    return jsonDecode(response.body);
  }

  Future<void> updateFavourite(int _postId, int _imageId) async {
    String url = MyWidgets.api +
        "FavouritePost?user_id=${int.parse(MyWidgets.userId.toString())}&posts_id=$_postId&posts_img_id=$_imageId";
    print(url);
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': "application/json"});
    print(response.body.toString());
    Fluttertoast.showToast(
        msg: response.body.toString(),
        backgroundColor: Colors.grey[600],
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16.0);
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget logoutButton = FlatButton(
      child: Text("Logout"),
      onPressed: () async {
        DatabaseHelper db = DatabaseHelper.instance;
        await db.deleteUser().whenComplete(() {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LogIn()));
        });
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text(
          "You won't receive messages and notifications for your ads until you log in again. Are you sure you want to log out?"),
      actions: [cancelButton, logoutButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  @override
  void initState() {
    super.initState();
    print(MyWidgets.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          DrawerHeader(
            // decoration: BoxDecoration(color: Colors.black),
            child: Container(
              child: Column(
                children: [
                  Container(
                      height: 100,
                      width: 100,
                      child: CachedNetworkImage(
                          imageUrl:
                              MyWidgets.userImageUrl + MyWidgets.userImage,
                          fit: BoxFit.fill,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Icon(
                                Icons.person,
                                color: Colors.black,
                                size: 100,
                              ))),
                  SizedBox(height: 10),
                  Text(MyWidgets.userName, style: TextStyle(fontSize: 20))
                ],
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserProfile()));
            },
            title: Text("Profile"),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MyAds(0)));
            },
            title: Text("My Ads"),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MyAds(1)));
            },
            title: Text("Favourites"),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserSettings()));
            },
            title: Text("Settings"),
          ),
          ListTile(
            onTap: () async {
              showAlertDialog(context);
            },
            title: Text("Log Out"),
          ),
          ListTile(
            title: Text("Contact"),
          ),
        ],
      )),
      body: WillPopScope(
        onWillPop: MyWidgets.onWillPop,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RefreshIndicator(
            onRefresh: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home()));
              return Future.value(false);
            },
            child: ListView(
              shrinkWrap: true,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Location()));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.location_on,
                          color: Color.fromRGBO(0, 65, 0, 1)),
                      SizedBox(width: 5),
                      Text(
                        "Collector Office Campus, Aurangabad ",
                        style: TextStyle(color: Color.fromRGBO(0, 65, 0, 1)),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Color.fromRGBO(0, 65, 0, 1),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchPosts()));
                        },
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Icon(Icons.search, color: Colors.black),
                              SizedBox(width: 10),
                              Text(
                                "Machines, Engine, Plant, Parts....",
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        /*Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LogIn()));*/
                      },
                      child: Icon(
                        Icons.notifications_none,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                Divider(color: Colors.black),
                SizedBox(height: 10),
                Text("Browse Categories", textAlign: TextAlign.left),
                SizedBox(height: 10),
                FutureBuilder(
                    future: getCategories(),
                    builder: (context, snap) {
                      if (snap.hasData) {
                        return GridView.builder(
                            padding: EdgeInsets.only(left: 25, right: 25),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.8,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 25,
                                    crossAxisCount: 3),
                            itemCount:
                                snap.data.length != 0 ? snap.data.length : 0,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PostsByCategory(
                                              snap.data[index]
                                                      ['posts_category_id']
                                                  .toString(),
                                              snap.data[index]['category_name']
                                                  .toString()))).whenComplete(
                                      () {
                                    setState(() {});
                                  });
                                },
                                child: GridTile(
                                    child: Column(
                                  children: [
                                    Container(
                                      height: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: categoriesColour[index],
                                        // image: DecorationImage(
                                        //     image: AssetImage(
                                        //         "assets/categories/plants.png"))
                                      ),
                                      child: Center(
                                          child: CachedNetworkImage(
                                              imageUrl:
                                                  MyWidgets.categoriesUrl +
                                                      snap.data[index]
                                                          ['category_image'],
                                              fit: BoxFit.fitHeight,
                                              color: Colors.white,
                                              height: 80,
                                              placeholder: (context, url) => Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) => Icon(
                                                        Icons.image_outlined,
                                                        size: 80,
                                                      ))),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      snap.data[index]['category_name'],
                                      style: TextStyle(fontSize: 10),
                                      textAlign: TextAlign.center,
                                      softWrap: false,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ],
                                )),
                              );
                            });
                      } else if (snap.hasError) {
                        return Center(child: Text("Try again later"));
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
                SizedBox(height: 10),
                Container(
                  height: 80,
                  color: Colors.blue[900],
                ),
                SizedBox(height: 10),
                Text(
                  "Fresh Recommendations",
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 10),
                FutureBuilder(
                  future: getAllPosts(),
                  builder: (context, snap) {
                    if (snap.hasData) {
                      if (snap.data.toString() == "[]") {
                        return Center(child: Text("No Ads Found"));
                      } else {
                        return GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    // /*crossAxisSpacing: 10*/
                                    childAspectRatio: 0.7),
                            itemCount:
                                snap.data.length != 0 ? snap.data.length : 0,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductDetails(
                                              snap.data[index]['posts_id']
                                                  .toString(),
                                              snap.data[index]['posts_img_id']
                                                  .toString(),
                                              snap.data[index]['posts_image_1']
                                                  .toString(),
                                              snap.data[index]['posts_image_2']
                                                  .toString(),
                                              snap.data[index]['posts_image_3']
                                                  .toString(),
                                              snap.data[index]['posts_image_4']
                                                  .toString(),
                                              snap.data[index]['posts_image_5']
                                                  .toString()))).whenComplete(
                                      () => setState(() {}));
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(
                                          color: Colors.grey[300], width: 1.5)),
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 200,
                                                width: 200,
                                                child: CachedNetworkImage(
                                                    imageUrl: MyWidgets
                                                            .postImageUrl +
                                                        snap.data[index][
                                                                'posts_image_1']
                                                            .toString(),
                                                    fit: BoxFit.fitHeight,
                                                    placeholder: (context,
                                                            url) =>
                                                        Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Icon(
                                                          Icons.image_outlined,
                                                          size: 120,
                                                        )),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "₹ ${snap.data[index]['posts_price'].toString()}",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 5),
                                              Text(snap.data[index]
                                                      ['posts_title']
                                                  .toString()),
                                            ]),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white),
                                            padding: EdgeInsets.all(5),
                                            child: InkWell(
                                              onTap: () {
                                                updateFavourite(
                                                        int.parse(snap
                                                            .data[index]
                                                                ['posts_id']
                                                            .toString()),
                                                        int.parse(snap
                                                            .data[index]
                                                                ['posts_img_id']
                                                            .toString()))
                                                    .whenComplete(() {
                                                  setState(() {});
                                                });
                                              },
                                              child: Icon(snap.data[index]
                                                              ['favourites']
                                                          .toString() ==
                                                      "1"
                                                  ? Icons.favorite
                                                  : Icons.favorite_border),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    } else if (snap.hasError) {
                      return Center(child: Text("Try Again Later!"));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PostAd1()));
        },
        child: Icon(
          Icons.add_circle_outline,
          size: 60,
          color: Colors.black,
        ),
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
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("HOME")),
          BottomNavigationBarItem(icon: Icon(null), title: Text("SELL")),
          BottomNavigationBarItem(
              icon: Icon(Icons.font_download), title: Text("MY ADS"))
          /*BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text("ACCOUNT"),
          )*/
        ],
        onTap: (value) {
          setState(() {
            _bottomIndex = value;
            switch (value) {
              // case 0:
              //   Navigator.pushReplacement(
              //       context, MaterialPageRoute(builder: (context) => Home()));
              //   break;
              //
              case 1:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PostAd1()));
                break;
              case 2:
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => MyAds(0)));
                break;
              /*case 3: Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => UserProfile()));
                break;*/
            }
          });
        },
      ),
    );
  }
}
