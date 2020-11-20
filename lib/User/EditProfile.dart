import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:meplo/UI/MyWidgets.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  List<Asset> images = List<Asset>();
  List<File> _imageFile = [];

  TextEditingController _userName =
  TextEditingController(text: MyWidgets.userName);
  TextEditingController _userDetails =
  TextEditingController(text: MyWidgets.userDetails);
  TextEditingController _userMobile =
  TextEditingController(text: MyWidgets.userMobile);
  TextEditingController _userEmail =
  TextEditingController(text: MyWidgets.userEmail);

  bool enableUpdateBtn = false;
  bool _isUpdating = false;

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          // actionBarTitle: "Example App",
          actionBarColor: "#0080ff",
          lightStatusBar: true,
          startInAllView: false,
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectionLimitReachedText: "Maximum 1 pics allowed",
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
      print("Try Error: $error");
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
      enableUpdateBtn = true;
    });

    images.forEach((imageAsset) async {
      final filePath =
      await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);

      File tempFile = File(filePath);
      if (tempFile.existsSync()) {
        _imageFile.add(tempFile);
      }
    });

    print("Image File Length: " + _imageFile.length.toString());
  }

  Future updateUser() async {
    setState(() {
      _isUpdating = true;
    });
    final uri = Uri.parse(MyWidgets.api + "UpdateUser");

    var request = http.MultipartRequest('POST', uri);

    request.fields['user_id'] = MyWidgets.userId;
    request.fields['user_name'] = _userName.text;
    request.fields['user_email'] = _userEmail.text;
    request.fields['user_mobile'] = _userMobile.text;
    request.fields['user_desc'] = _userDetails.text;

      request.files.add(
          await http.MultipartFile.fromPath("image", _imageFile[0].path));

      print(_imageFile[0].path);

    var response = await request.send();

    print(response.reasonPhrase);
    if (response.statusCode == 200) {
      setState(() {
        _isUpdating = false;
        MyWidgets.userImage = images[0].name;
      });
      print('User Profile Updated Successfully');
      print(response.stream);
      print(response.reasonPhrase);
      Fluttertoast.showToast(
          msg: response.toString(),
          fontSize: 16.0,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[600]);
    } else {
      setState(() {
        _isUpdating = false;
      });
      print('Error while Updating User Profile');
      print(response.stream);
      print(response.reasonPhrase);
      Fluttertoast.showToast(
          msg: response.statusCode.toString(),
          fontSize: 16.0,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[600]);
    }
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(children: [
        CircularProgressIndicator(),
        SizedBox(width: 20),
        Text("Updating profile...")
      ],),
      actions: [],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View/Edit Profile"),
        actions: [
          FlatButton(onPressed: enableUpdateBtn ? () {
            updateUser();
          } : null,
              child: Text(
                "Save", style: TextStyle(color: Colors.white, fontSize: 16),))
        ],
      ),
      body: /*_isUpdating ? showAlertDialog(context) :*/ Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Text("Basic Information",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
            SizedBox(height: 10),
            Row(
              children: [
                InkWell(
                  onTap: (){
                    loadAssets();
                  },
                  child: Container(
                      margin: EdgeInsets.all(10),
                      height: 100,
                      width: 100,
                      child: images.length > 0 ? AssetThumb(asset: images[0],
                        width: 100,
                        height: 100,) : CachedNetworkImage(
                          imageUrl: MyWidgets.userImageUrl + MyWidgets.userImage,
                          fit: BoxFit.fill,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.person, color: Colors.black, size: 100,))
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _userName,
                    decoration: InputDecoration(
                      labelText: "Enter your name",
                                      labelStyle: TextStyle(height: 0.5)
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: _userDetails,
              maxLength: 140,
              onChanged: (value) {
                if (value != MyWidgets.userDetails) {
                  setState(() {
                    enableUpdateBtn = true;
                  });
                } else {
                  setState(() {
                    enableUpdateBtn = false;
                  });
                }
              },
              decoration: InputDecoration(
                  labelText: "Something about you",
                  labelStyle: TextStyle(height: 0.5)),
            ),
            Divider(),
            SizedBox(height: 10),
            Text("Contact Information",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
            SizedBox(height: 10),
            TextField(
              controller: _userMobile,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              onChanged: (value) {
                if (value != MyWidgets.userMobile) {
                  setState(() {
                    enableUpdateBtn = true;
                  });
                } else {
                  setState(() {
                    enableUpdateBtn = false;
                  });
                }
              },
              decoration: InputDecoration(
                  prefixText: "+91 ",
                  labelText: "Phone Number",
                  labelStyle: TextStyle(height: 0.5)),
            ),
            SizedBox(height: 10),
            Text(
                "This is the number for buyers contacts, reminders, and other notifications."),
            SizedBox(height: 20),
            TextField(
              controller: _userEmail,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                if (value != MyWidgets.userEmail) {
                  setState(() {
                    enableUpdateBtn = true;
                  });
                } else {
                  setState(() {
                    enableUpdateBtn = false;
                  });
                }
              },
              decoration: InputDecoration(
                  labelText: "Email", labelStyle: TextStyle(height: 0.5)),
            ),
            SizedBox(height: 10),
            Divider()
          ],
        ),
      ),
    );
  }
}
