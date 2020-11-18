import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:meplo/UI/MyWidgets.dart';

import 'PostAd3.dart';

class PostAd2 extends StatefulWidget {
  int categoryId;
  PostAd2(this.categoryId);
  @override
  _PostAd2State createState() => _PostAd2State();
}

class _PostAd2State extends State<PostAd2> {

  String url;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _adTitle = TextEditingController();
  TextEditingController _adDescription = TextEditingController();
  TextEditingController _adBrand = TextEditingController();
  TextEditingController _adPrice = TextEditingController();

  Future<void> _createPost() async{
    url = MyWidgets.api + "CreatePost?category_id=${widget.categoryId.toString()}&brand=${_adBrand.text}&title=${_adTitle.text}&description=${_adDescription.text}&price=${_adPrice.text}";
    print(url);
    var response = await http.get(Uri.encodeFull(url), headers: {'Accept': "application/json"});
    var data = jsonDecode(response.body);
    print(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Include some details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
        child: Form(
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
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          margin: EdgeInsets.all(8),
          height: 50,
          child: RaisedButton(
            onPressed: () {
              if(_formKey.currentState.validate()){
                // _createPost();
                print("Post Created");
                Navigator.push(context, MaterialPageRoute(builder: (context) => PostAd3(widget.categoryId.toString(), _adBrand.text, _adTitle.text, _adDescription.text, _adPrice.text)));
              }else{
                print("ERRRRROOOORRR!!!!");
              }
            },
            child: Text("Select Images", style: TextStyle(fontSize: 16),),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Colors.black,
            textColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
