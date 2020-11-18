import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meplo/UI/MyWidgets.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class EditPassword extends StatefulWidget {
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  TextEditingController _newPass = TextEditingController();
  TextEditingController _newPassConfirm = TextEditingController();

  bool enableUpdateBtn = false;
  bool showNewPass = false;
  bool showNewPassConfirm = false;

  Future<void> updatePassword() async {
    String url = MyWidgets.api +
        "UpdatePassword?user_id=${MyWidgets.userId}&user_password=${_newPass.text}";
    print(url);
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': "application/json"});
    print(response.body.toString());

    if (response.body.toString() == "Password Updated Successfully") {
      setState(() {
        MyWidgets.userPassword = _newPass.text;
      });
      Fluttertoast.showToast(
          msg: response.body.toString(),
          fontSize: 16.0,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[600]);
    }else{
      Fluttertoast.showToast(
          msg: "Error while updating new Password",
          fontSize: 16.0,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[600]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Create Password"),),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text("Please enter your new password"),
              SizedBox(height: 10),
              TextField(
                controller: _newPass,
                obscureText: !showNewPass,
                onChanged: (value) {
                  if (value != MyWidgets.userPassword) {
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
                    labelText: "New Password",
                    labelStyle: TextStyle(height: 0.5),
                    suffix: InkWell(
                        onTap: () {
                          setState(() {
                            showNewPass = !showNewPass;
                          });
                        },
                        child: showNewPass
                            ? Icon(Icons.remove_red_eye, color: Colors.blue)
                            : Icon(Icons.remove_red_eye, color: Colors.black))),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _newPassConfirm,
                obscureText: !showNewPassConfirm,
                onChanged: (value) {
                  if (value != MyWidgets.userPassword) {
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
                    labelText: "Confirm New Password",
                    labelStyle: TextStyle(height: 0.5),
                    suffix: InkWell(
                        onTap: () {
                          setState(() {
                            showNewPassConfirm = !showNewPassConfirm;
                          });
                        },
                        child: showNewPassConfirm
                            ? Icon(Icons.remove_red_eye, color: Colors.blue)
                            : Icon(Icons.remove_red_eye, color: Colors.black))),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            margin: EdgeInsets.only(left: 8, top: 8, bottom: 8),
            height: 45,
            child: RaisedButton(
              onPressed: enableUpdateBtn
                  ? () {
                      if (_newPass.text == _newPassConfirm.text) {
                        updatePassword()
                            .whenComplete(() => Navigator.pop(context));
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please enter password correctly",
                            fontSize: 16.0,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.grey[600]);
                      }
                    }
                  : null,
              child: Text("Save"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: Colors.black,
              textColor: Colors.white,
            ),
          ),
        ));
  }
}
