import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'ProductDetails.dart';
import 'UI/MyWidgets.dart';

class PostsByCategory extends StatefulWidget {

  String postCategoryId;

  PostsByCategory(this.postCategoryId);

  @override
  _PostsByCategoryState createState() => _PostsByCategoryState();
}

class _PostsByCategoryState extends State<PostsByCategory> {

  Future<List> postCategory() async {
    String url = MyWidgets.api + "PostCategory?user_id=${MyWidgets.userId}&category_id=${widget.postCategoryId}";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          onRefresh: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => PostsByCategory(widget.postCategoryId)));
            return Future.value(false);
          },
          child: ListView(
            shrinkWrap: true,
            children: [
              FutureBuilder(
                future: postCategory(),
                builder: (context, snap) {
                  if (snap.hasData) {
                    if (snap.data.toString() == "[]") {
                      return Container(height: MediaQuery.of(context).size.height, child: Center(child: Text("No Ads Found for this category")));
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
                                            snap.data[index]['posts_id'].toString(),
                                            snap.data[index]['favourites']
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
                                                .toString())));
                                setState(() {});
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
                                                      snap.data[index]
                                                      ['posts_image_1'].toString(),
                                                  fit: BoxFit.fitHeight,
                                                  placeholder: (context,
                                                      url) =>
                                                      Center(
                                                          child:
                                                          CircularProgressIndicator()),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                      Icon(Icons.image_outlined, size: 120,)),
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
                    return Container(height: MediaQuery.of(context).size.height, child: Center(child: Text("Try Again Later!")));
                  } else {
                    return Container(height: MediaQuery.of(context).size.height, child: Center(child: CircularProgressIndicator()));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
