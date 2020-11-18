import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meplo/UI/MyWidgets.dart';

class EditPost extends StatefulWidget {
  String _postId;

  EditPost(this._postId);

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _adTitle = TextEditingController();
  TextEditingController _adDescription = TextEditingController();
  TextEditingController _adBrand = TextEditingController();
  TextEditingController _adPrice = TextEditingController();

  var postData;

  Future<List> getSinglePost() async {
    String url = MyWidgets.api + "GetSinglePost?posts_id=${widget._postId}";
    print(url);
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': "application/json"});
    return jsonDecode(response.body);
  }

  @override
  void initState() {
    super.initState();
    postData = getSinglePost();
    /*_adTitle.text = postData[0]['posts_title'].toString();
    _adDescription.text = postData[0]['posts_description'].toString();
    _adBrand.text = postData[0]['posts_brand'].toString();
    _adPrice.text = postData[0]['posts_price'].toString();*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
        child: FutureBuilder(
          future: postData,
          builder: (context, snap) {
            if (snap.hasData) {
              return ListView.builder(
                  itemCount: snap.data.length != 0 ? snap.data.length : 0,
                  itemBuilder: (context, index){
                    return Form(
                      key: _formKey,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Text(
                            "Ad title *",
                            style: TextStyle(
                                color: Colors.blue, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            controller: _adTitle,
                            maxLength: 50,
                            onChanged: (value){},
                            validator: (value){
                              if(value.isEmpty){
                                return "Enter Title";
                              }else{
                                return null;
                              }
                            },
                          ),
                          Text("Mention the key features of your item (e.g. brand, model, type, year)", style: TextStyle(fontWeight: FontWeight.w600),),
                          SizedBox(height: 20),
                          Text(
                            "Ad description *",
                            style: TextStyle(
                                color: Colors.blue, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            controller: _adDescription,
                            maxLength: 100,
                            validator: (value){
                              if(value.isEmpty){
                                return "Enter Description";
                              }else{
                                return null;
                              }
                            },
                          ),
                          Text("Include condition, features and reason for selling", style: TextStyle(fontWeight: FontWeight.w600),),
                          SizedBox(height: 20),
                          Text(
                            "Brand *",
                            style: TextStyle(
                                color: Colors.blue, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            controller: _adBrand,
                            validator: (value){
                              if(value.isEmpty){
                                return "Enter Brand";
                              }else{
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Ad Price *",
                            style: TextStyle(
                                color: Colors.blue, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            controller: _adPrice,
                            keyboardType: TextInputType.number,
                            validator: (value){
                              if(value.isEmpty){
                                return "Enter price";
                              }else if(double.parse(value) >= 50.0){
                                return null;
                              }else{
                                return "min price should be 50";
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  });
            } else if (snap.hasError) {
              return Center(child: Text("Try again later"));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          margin: EdgeInsets.all(8),
          height: 50,
          child: RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                // _createPost();
                print("Post Created");
                // Navigator.push(context, MaterialPageRoute(builder: (context) => PostAd3(widget.categoryId.toString(), _adBrand.text, _adTitle.text, _adDescription.text, _adPrice.text)));
              } else {
                print("ERRRRROOOORRR!!!!");
              }
            },
            child: Text(
              "Select Images",
              style: TextStyle(fontSize: 16),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Colors.black,
            textColor: Colors.white,
          ),
        ),
      ),
    );
  }
}