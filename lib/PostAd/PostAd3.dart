import 'dart:io';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meplo/UI/MyWidgets.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

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

  bool _isPosting = false;
  List<Asset> images = List<Asset>();
  List<File> _imageFile = [];
  String _error = 'No Error Dectected';

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      padding: EdgeInsets.all(5),
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
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

    setState(() {
      images = resultList;
      _error = error;
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

    /*for (int i = 0; i < images.length; i++) {
      var path =
      await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
      print(path);
      f.add(File(path));
    }*/
  }

  Future uploadImages() async {
    setState(() {
      _isPosting = true;
    });
    final uri = Uri.parse(MyWidgets.api + "CreatePost");

    var request = http.MultipartRequest('POST', uri);

    request.fields['user_id'] = MyWidgets.userId;
    request.fields['category_id'] = widget.adCategoriId;
    request.fields['brand'] = widget.adBrand;
    request.fields['title'] = widget.adTitle;
    request.fields['description'] = widget.adDescription;
    request.fields['price'] = widget.adPrice;

    for (int i = 0; i < _imageFile.length; i++) {
      request.files.add(
          await http.MultipartFile.fromPath("image${i+1}", _imageFile[i].path));
      print("image${i+1}");
      print(_imageFile[i].path);
    }

    var response = await request.send();

    print(response.reasonPhrase);
    if (response.statusCode == 200) {
      setState(() {
        _isPosting = false;
      });
      print('Image Uploaded!');
      Fluttertoast.showToast(
          msg: "Image Uploaded!",
          fontSize: 16.0,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[600]);
    } else {
      setState(() {
        _isPosting = false;
      });
      print('Image Not Uploaded!');
      Fluttertoast.showToast(
          msg: "Image Not Uploaded!",
          fontSize: 16.0,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[600]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select product images"), centerTitle: true),
      body: Stack(
        children: [
          _isPosting
              ? AlertDialog(
                  actions: [],
                  title: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 25),
                      Text("Posting Ad...")
                    ],
                  ),
                )
              : Column(
                  children: <Widget>[
                    // Center(child: Text('Error: $_error')),
                    RaisedButton(
                      child: Text("Pick images"),
                      onPressed: loadAssets,
                    ),
                    Expanded(
                      child: _imageFile.length > 0
                          ? buildGridView()
                          : Center(child: Text("No Image Selected")),
                    )
                  ],
                ),
        ],
      ),
      bottomNavigationBar: !_isPosting ? BottomAppBar(
        child: Container(
          margin: EdgeInsets.all(8),
          height: 50,
          child: RaisedButton(
            onPressed: () {
              if (_imageFile.length != 0) {
                uploadImages();
                print(_imageFile.length.toString());
              } else {
                print("No Images Selected");
                Fluttertoast.showToast(
                    msg: "No Images Selected",
                    fontSize: 16.0,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.grey[600]);
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
      ) : null,
    );
  }
}
