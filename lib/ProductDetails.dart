import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meplo/Post/EditPost.dart';
import 'package:meplo/UI/MyWidgets.dart';
import 'SellerProfile.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';

class ProductDetails extends StatefulWidget {
  final String _postId;
  final String _favourite;
  final String _postImageId;
  final String _image1;
  final String _image2;
  final String _image3;
  final String _image4;
  final String _image5;

  ProductDetails(
      this._postId,
      this._favourite,
      this._postImageId,
      this._image1,
      this._image2,
      this._image3,
      this._image4,
      this._image5);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool relatedAdsIsFavorite = false;
  int _relatedAdsIndex;

  CarouselController carouselController = CarouselController();
  List<String> images = [];

  var postData;

  Future<List> getSinglePost() async {
    String url = MyWidgets.api + "GetSinglePost?posts_id=${widget._postId}";
    print(url);
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': "application/json"});
    return jsonDecode(response.body);
  }

  Future<void> setImages() async {
    if (widget._image1 != "") {
      await images.add(widget._image1);
    }
    if (widget._image2 != "") {
      await images.add(widget._image2);
    }
    if (widget._image3 != "") {
      await images.add(widget._image3);
    }
    if (widget._image4 != "") {
      await images.add(widget._image4);
    }
    if (widget._image5 != "") {
      await images.add(widget._image5);
    }
  }

  Future<void> updateFavourite() async {
    String url = MyWidgets.api +
        "FavouritePost?user_id=${int.parse(MyWidgets.userId.toString())}&posts_id=${int.parse(widget._postId.toString())}&posts_img_id=${int.parse(widget._postImageId.toString())}";
    print(url);
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': "application/json"});
    setState(() {
      postData = getSinglePost();
    });
    print(response.body.toString());
    Fluttertoast.showToast(
        msg: response.body.toString(),
        backgroundColor: Colors.grey[600],
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16.0);
  }

  void _selected(String value) {
    switch (value) {
      case 'edit': Navigator.push(context, MaterialPageRoute(builder: (context) => EditPost(widget._postId)));
        break;
    }
  }
  
  @override
  void initState() {
    super.initState();
    setImages();
    postData = getSinglePost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, actions: [
        PopupMenuButton<String>(
          onSelected: _selected,
          itemBuilder: (BuildContext context) {
            return {'edit'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        )
      ]),
      body: FutureBuilder(
        future: postData,
        builder: (context, snap){
          if(snap.hasData){
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snap.data.length != 0 ? snap.data.length : 0,
              itemBuilder: (context, index){
                return ListView(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    /*Container(
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider.builder(
              carouselController: carouselController,
              options: CarouselOptions(
                initialPage: 0,

              ),
              itemCount: images.length,
              itemBuilder: (BuildContext context, int itemIndex) {
                  return Container(
                    child: CachedNetworkImage(
                        imageUrl: menifo.getImageUrl() + images[itemIndex],
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                            child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.image)
                    ),
                  );}
            ),
          ),*/
                    Container(
                      height: 250,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              child: CachedNetworkImage(
                                  imageUrl: MyWidgets.postImageUrl + images[index],
                                  fit: BoxFit.fitHeight,
                                  placeholder: (context, url) =>
                                      Center(child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.image)),
                            );
                          }),
                    ),
                    ListView(
                      physics: ScrollPhysics(),
                      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                      shrinkWrap: true,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                                  "₹ " + snap.data[index]['posts_price'].toString() + "/-",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                )),
                            InkWell(
                                onTap: () {
                                  updateFavourite().whenComplete(() {
                                    setState(() {});
                                  });
                                },
                                child: Icon(
                                  widget._favourite.toString() == "1"
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  size: 30,
                                ))
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          snap.data[index]['posts_title'].toString(),
                          overflow: TextOverflow.visible,
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(Icons.location_on),
                                  SizedBox(width: 5),
                                  Text("SATARA, AURANGABAD")
                                ],
                              ),
                            ),
                            Text(snap.data[index]['posts_date'].toString())
                          ],
                        ),
                        SizedBox(height: 5),
                        Divider(color: Colors.black),
                        SizedBox(height: 10),
                        Text(
                          "Description",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(snap.data[index]['posts_description'].toString()),
                        SizedBox(height: 10),
                        Divider(color: Colors.black),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SellerProfile(snap.data[index]['user_name'].toString())));
                          },
                          child: Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.all(10),
                                  height: 70,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[300],
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    size: 70,
                                  )),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snap.data[index]['user_name'].toString(),
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      "Member since Feb 2015",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "See Profile",
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_right),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Divider(color: Colors.black),
                        SizedBox(height: 15),
                        Text(
                          "Ad Posted At:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Container(height: 100, child: Center(child: Text("MAP"))),
                        SizedBox(height: 10),
                        Divider(color: Colors.black),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "AD ID : " + snap.data[index]['posts_id'].toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              "REPORT THIS AD",
                              textAlign: TextAlign.right,
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(color: Colors.black),
                        SizedBox(height: 10),
                        Text(
                          "Related Ads",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side:
                                    BorderSide(color: Colors.grey[300], width: 1.5)),
                                child: Container(
                                  width: 170,
                                  // margin: EdgeInsets.only(top: 10, right: 10, bottom: 10),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey[100]),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Image.asset(
                                          "assets/machine.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Expanded(child: Text("₹ 26,999")),
                                          InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _relatedAdsIndex = index;
                                                  relatedAdsIsFavorite =
                                                  !relatedAdsIsFavorite;
                                                  print(index.toString());
                                                });
                                              },
                                              child: Icon(index == _relatedAdsIndex &&
                                                  relatedAdsIsFavorite
                                                  ? Icons.favorite
                                                  : Icons.favorite_border)),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "HP i3 7 generation, brand new condition",
                                        style: TextStyle(fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Cantonment, Aurangabad",
                                        style: TextStyle(fontSize: 10),
                                        textAlign: TextAlign.left,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    )
                  ],
                );
              },
            );
          }else if(snap.hasError){return Center(child: Text("Try again later"));}else{return Center(child: CircularProgressIndicator());}
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: 8, top: 8, bottom: 8),
              height: 45,
              child: RaisedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Chat"),
                  ],
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: Colors.black,
                textColor: Colors.white,
              ),
            )),
            SizedBox(width: 8),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(top: 8, right: 8, bottom: 8),
              height: 45,
              child: RaisedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.local_offer,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Make Offer"),
                  ],
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: Colors.black,
                textColor: Colors.white,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
