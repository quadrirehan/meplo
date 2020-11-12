import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meplo/PostAd/PostAd2.dart';
import 'package:meplo/UI/MyWidgets.dart';
import 'package:http/http.dart' as http;

class PostAd1 extends StatefulWidget {
  @override
  _PostAd1State createState() => _PostAd1State();
}

class _PostAd1State extends State<PostAd1> {

  List<Color> categoriesColour = [
    Colors.deepPurpleAccent[400],
    Colors.green[900],
    Colors.pinkAccent[400],
    Colors.green[800],
    Colors.deepOrange,
    Colors.purple[900],
  ];

  List<String> categoriesImages = [
    "assets/categories/Meplo-G01.png",
    "assets/categories/Meplo-G02.png",
    "assets/categories/Meplo-G03.png",
    "assets/categories/Meplo-G04.png",
    "assets/categories/Meplo-G05.png",
    "assets/categories/Meplo-G06.png",
  ];
  List<String> categories = [
    "Plants",
    "Machines",
    "Parts",
    "Operators/Mechanic",
    "Engines",
    "New Dealers"
  ];

  Future<List> getCategories() async{
    String url = MyWidgets.api+"GetCategories";
    print(url);
    var respose = await http.get(Uri.encodeFull(url), headers: {'Accept': "application/json"});
    return jsonDecode(respose.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "What are you offering?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: FutureBuilder(
            future: getCategories(),
            builder: (context, snap){
              if(snap.hasData){
                return GridView.builder(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemCount: snap.data.length != 0 ? snap.data.length : 0,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => PostAd2(snap.data[index]['posts_category_id'])));
                        },
                        child: Card(
                          elevation: 2,
                          color: Colors.white,
                          child: GridTile(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: CachedNetworkImage(
                                        imageUrl: MyWidgets.categoriesUrl + snap.data[index]['category_image'],
                                        fit: BoxFit.fitHeight,
                                        height: 120,
                                        placeholder: (context, url) =>
                                            Center(child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.image, size: 150,)),),
                                  // SizedBox(height: 5),
                                  Text(snap.data[index]['category_name'],
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.visible,),
                                ],
                              ),
                          ),
                        ),
                      );
                    });
              }else if(snap.hasError){
                return Center(child: Text("Try Again!"));
              }else{return Center(child: CircularProgressIndicator());}
            },
          ),
        ));
  }
}
