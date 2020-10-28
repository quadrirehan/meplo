import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:meplo/UI/Menifo.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:file_picker/file_picker.dart';

class PostAd3 extends StatefulWidget {
  String adCategoriId;
  String adBrand;
  String adTitle;
  String adDescription;
  String adPrice;

  PostAd3(this.adCategoriId, this.adBrand, this.adTitle, this.adDescription,
      this.adPrice);

  @override
  _PostAd3State createState() => _PostAd3State();
}

class _PostAd3State extends State<PostAd3> {
  Menifo menifo = Menifo();

  List<Asset> images = List<Asset>();
  File file;
  File _image;
  String _error = 'No Error Dectected';

  @override
  void initState() {
    super.initState();
  }

  void _chooseImage() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if(result != null) {
      file = File(result.files.single.path);
    } else {
      // User canceled the picker
    }
    /*var pickedImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage.path);
      // print(_image.path);
    });*/
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          // actionBarTitle: "Example App",
          actionBarColor: "#abcdef",
          lightStatusBar: true,
          startInAllView: false,
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectionLimitReachedText: "Maximum 5 pics allowed",
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
      print("Try Error: $error");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() async {
      images = resultList;
      _error = error;
    });

    /*for (int i = 0; i < images.length; i++) {
      var path =
      await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
      print(path);
      f.add(File(path));
    }*/
  }

  Future uploadImages() async {
    // final uri = Uri.parse(menifo.getBseUrl() + "CreatePost");
    final uri = Uri.parse("http://192.168.5.107/InstaGreet/api/PostCreate");

    var request = http.MultipartRequest('POST', uri);

    /*request.fields['category_id'] = widget.adCategoriId;
    request.fields['brand'] = widget.adBrand;
    request.fields['title'] = widget.adTitle;
    request.fields['description'] = widget.adDescription;
    request.fields['price'] = widget.adPrice;*/
    request.fields['user_id'] = "2";
    request.fields['post_type'] = "1";
    request.fields['post_image_cap'] = "Test Image";

    request.files.add(await http.MultipartFile.fromPath("post_video", file.path));
    print(request);
    var response = await request.send();
    print(response);
    if (response.statusCode == 200) {
      print('Image Uploaded!');
      Fluttertoast.showToast(
        msg: "Image Uploaded!",
        fontSize: 16.0,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[600]
      );
    } else {
      print('Image Not Uploaded!');
      Fluttertoast.showToast(
        msg: "Image Not Uploaded!",
        fontSize: 16.0,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[600]
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select product images"), centerTitle: true),
      body: Column(
        children: <Widget>[
          // Center(child: Text('Error: $_error')),
          RaisedButton(
            child: Text("Pick images"),
            onPressed: _chooseImage,
          ),
          Expanded(
            child: /*buildGridView()*/ _image != null
                ? Image.file(_image)
                : Center(child: Text("No Image Selected")),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          margin: EdgeInsets.all(8),
          height: 50,
          child: RaisedButton(
            onPressed: () {
              if (_image.length() != 0) {
                uploadImages();
              } else {
                print("No Images Selected");
                Fluttertoast.showToast(
                  msg: "No Images Selected",
                  fontSize: 16.0,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.grey[600]
                );
              }
              /*for (int i = 0; i < images.length; i++) {
                */ /* var path = await FlutterAbsolutePath.getAbsolutePath(
                    images[i].identifier);
                print("path:: :: " + path);*/ /*

                */
              /*ByteData byteData = await images[i].getByteData();
                List<int> imageData = byteData.buffer.asUint8List();
                var base64 = base64Encode(imageData);
                _base64.add(base64);*/ /*
              }*/
              // Navigator.push(context, MaterialPageRoute(builder: (context) => PostAd3()));
            },
            child: Text(
              "Post",
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
