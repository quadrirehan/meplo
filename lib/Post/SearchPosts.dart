import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meplo/UI/MyWidgets.dart';
import 'package:http/http.dart' as http;

import 'ProductDetails.dart';

class SearchPosts extends StatefulWidget {
  @override
  _SearchPostsState createState() => _SearchPostsState();
}

class _SearchPostsState extends State<SearchPosts> {

  String _keyword;
  String searchKeyword;

  TextEditingController _searchText = TextEditingController();

  Future<List> searchPosts() async {
    String url = MyWidgets.api + "SearchPosts?user_id=${MyWidgets.userId}&name=$_keyword";
    print(url);
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': "application/json"});
    return jsonDecode(response.body);
  }

  Future<void> updateFavourite(int _postId, int _imageId) async {
    String url = MyWidgets.api +
        "FavouritePost?user_id=${int.parse(MyWidgets.userId
            .toString())}&posts_id=$_postId&posts_img_id=$_imageId";
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: TextField(
          controller: _searchText,
          autofocus: true,
          onChanged: (value) {
            setState(() {
              searchKeyword = value;
            });
          },
          decoration: InputDecoration(
              suffixIcon: InkWell(
                onTap: (){
                  setState(() {
                    _keyword = searchKeyword;
                  });
                },
                child: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
              border: InputBorder.none,
              hintText: "Search..."),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: searchPosts(),
            builder: (context, snap) {
              if (snap.hasError) {
                return Center(child: Text("Try again later"));
              } else if(snap.hasData){
                if (snap.data.toString() != "[]") {
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
                                    builder: (context) =>
                                        ProductDetails(
                                            snap.data[index]['posts_id']
                                                .toString(),
                                            snap
                                                .data[index]['posts_img_id']
                                                .toString(),
                                            snap
                                                .data[index]['posts_image_1']
                                                .toString(),
                                            snap
                                                .data[index]['posts_image_2']
                                                .toString(),
                                            snap
                                                .data[index]['posts_image_3']
                                                .toString(),
                                            snap
                                                .data[index]['posts_image_4']
                                                .toString(),
                                            snap
                                                .data[index]['posts_image_5']
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
                                                  ['posts_image_1']
                                                      .toString(),
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
                                          "₹ ${snap
                                              .data[index]['posts_price']
                                              .toString()}",
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
                } else {
                  return Center(child: Text("No Data Found"));
                }
              }else{
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
