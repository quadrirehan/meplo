import 'dart:io';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meplo/MyAds.dart';
import 'package:meplo/UI/MyWidgets.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PostAd3 extends StatefulWidget {
  String adCategoriId;
  String adBrand;
  String adTitle;
  String adDescription;
  String adPrice;
  String postId;

  PostAd3(this.adCategoriId, this.adBrand, this.adTitle, this.adDescription,
      this.adPrice, this.postId);

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
      padding: EdgeInsets.all(10),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
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
          actionBarColor: "#0080ff",
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
      request.files.add(await http.MultipartFile.fromPath(
          "image${i + 1}", _imageFile[i].path));
      print("image${i + 1}");
      print(_imageFile[i].path);
    }

    var response = await request.send();

    print(response.reasonPhrase);
    if (response.statusCode == 200) {
      setState(() {
        _isPosting = false;
      });
      print('Ad Posted Successfully');
      Fluttertoast.showToast(
          msg: "Ad Posted Successfully",
          fontSize: 16.0,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[600]);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyAds(0)));
    } else {
      setState(() {
        _isPosting = false;
      });
      print('Error while posting Ad');
      Fluttertoast.showToast(
          msg: "Error while posting Ad",
          fontSize: 16.0,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[600]);
    }
  }

  Future updatePost() async {
    setState(() {
      _isPosting = true;
    });
    final uri = Uri.parse(MyWidgets.api + "UpdatePost");

    var request = http.MultipartRequest('POST', uri);

    request.fields['posts_id '] = MyWidgets.userId;
    request.fields['user_id'] = MyWidgets.userId;
    request.fields['category_id'] = widget.adCategoriId;
    request.fields['brand'] = widget.adBrand;
    request.fields['title'] = widget.adTitle;
    request.fields['description'] = widget.adDescription;
    request.fields['price'] = widget.adPrice;

    if(_imageFile.length > 0){
      for (int i = 0; i < _imageFile.length; i++) {
        request.files.add(await http.MultipartFile.fromPath(
            "image${i + 1}", _imageFile[i].path));
        print("image${i + 1}");
        print(_imageFile[i].path);
      }
    }

    var response = await request.send();

    print(response.reasonPhrase);
    if (response.statusCode == 200) {
      setState(() {
        _isPosting = false;
      });
      print('Ad Updated Successfully');
      Fluttertoast.showToast(
          msg: "Ad Updated Successfully",
          fontSize: 16.0,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[600]);
      if (widget.postId == "0") {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyAds(0)));
      } else {
        Navigator.pop(context);
        Navigator.pop(context);
        setState(() {});
      }
    } else {
      setState(() {
        _isPosting = false;
      });
      print('Error while updating Ad');
      Fluttertoast.showToast(
          msg: "Error while updating Ad",
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
                      SizedBox(width: 20),
                      Text(widget.postId.toString() == "0"
                          ? "Posting..."
                          : "Updating...")
                    ],
                  ),
                )
              : Column(
                  children: <Widget>[
                    // Center(child: Text('Error: $_error')),
                    Expanded(
                      child: _imageFile.length > 0
                          ? buildGridView()
                          : Center(child: Text("No Image Selected")),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 70,
                      width: double.infinity,
                      child: RaisedButton(
                        child:
                            Text("Pick images", style: TextStyle(fontSize: 16)),
                        onPressed: loadAssets,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: Colors.black,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
        ],
      ),
      bottomNavigationBar: !_isPosting
          ? BottomAppBar(
              child: Container(
                margin: EdgeInsets.all(8),
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    if (_imageFile.length != 0) {
                      if (widget.postId == "0") {
                        uploadImages();
                      } else {
                        updatePost();
                      }
                      print(_imageFile.length.toString());
                    } else {
                      updatePost();
                      print("No Images Selected");
                      Fluttertoast.showToast(
                          msg: "No Images Selected",
                          fontSize: 16.0,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.grey[600]);
                    }
                  },
                  child: Text(
                    widget.postId.toString() == "0" ? "Post" : "Update",
                    style: TextStyle(fontSize: 16),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Colors.black,
                  textColor: Colors.white,
                ),
              ),
            )
          : null,
    );
  }
}
