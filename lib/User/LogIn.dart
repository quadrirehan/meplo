import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meplo/Home.dart';

import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:meplo/UI/DatabaseHelper.dart';
import 'package:meplo/UI/MyWidgets.dart';

import 'SignUp.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _userEmail = TextEditingController();
  TextEditingController _userPass = TextEditingController();
  String url;
  bool _isLoading = false;

  void setToMyWidgets(String _userId, String _userName, String _userDetail, String _userImage, String _userEmail,
      String _userMobile, String _userPassword) {
    setState(() {
      MyWidgets.userId = _userId;
      MyWidgets.userName = _userName;
      MyWidgets.userDetails = _userDetail;
      MyWidgets.userImage = _userImage;
      MyWidgets.userEmail = _userEmail;
      MyWidgets.userMobile = _userMobile;
      MyWidgets.userPassword = _userPassword;
    });
  }

  Future<void> logInUser() async {
    setState(() {
      _isLoading = true;
    });
    url = MyWidgets.api +
        "LoginUser?user_email=${_userEmail.text}&user_password=${_userPass
            .text}";
    print(url);
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': "application/json"});

    // print(jsonDecode(response.body).toString());

    if(response.statusCode == 200){
      if (response.body.toString() == "Invalid Credintials!") {
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg: "Invalid Credintials!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey[600],
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        setToMyWidgets(
            jsonDecode(response.body)[0]['user_id'].toString(),
            jsonDecode(response.body)[0]['user_name'].toString(),
            jsonDecode(response.body)[0]['user_description'].toString(),
            jsonDecode(response.body)[0]['user_img'].toString(),
            jsonDecode(response.body)[0]['user_email'].toString(),
            jsonDecode(response.body)[0]['user_mobile'].toString(),
            jsonDecode(response.body)[0]['user_password'].toString());
        DatabaseHelper db = DatabaseHelper.instance;
        db
            .insertUser(
            jsonDecode(response.body)[0]['user_id'].toString(),
            jsonDecode(response.body)[0]['user_name'].toString(),
            jsonDecode(response.body)[0]['user_description'].toString(),
            jsonDecode(response.body)[0]['user_img'].toString(),
            jsonDecode(response.body)[0]['user_email'].toString(),
            jsonDecode(response.body)[0]['user_mobile'].toString(),
            jsonDecode(response.body)[0]['user_password'].toString())
            .then((value) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        });
        Fluttertoast.showToast(
            msg: "LogIn Successfully!",
            backgroundColor: Colors.grey[600],
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_SHORT,
            fontSize:
            16.0
        );
      }
    }else{
      setState(() {
        _isLoading = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Card(
          margin: const EdgeInsets.only(left: 15, right: 15),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Container(
            padding: EdgeInsets.only(left: 25, top: 20, right: 25, bottom: 25),
            child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text(
                      "LOGIN",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 50),
                    Text(
                      "Email",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _userEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "example@gmail.com",
                          hintStyle:
                          TextStyle(color: Colors.grey, fontSize: 14)),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter Email Address";
                        } else if (EmailValidator.validate(value)) {
                          return null;
                        } else {
                          return "Enter Valid Email Address";
                        }
                      },
                    ),
                    SizedBox(height: 35),
                    Text(
                      "Password",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _userPass,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "**********",
                          hintStyle:
                          TextStyle(color: Colors.grey, fontSize: 14)),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter Password";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 40),
                    Container(
                      height: 50,
                      child: FlatButton(
                        onPressed: _isLoading ? null : () {
                          if (_formKey.currentState.validate()) {
                            logInUser();
                          }
                        },
                        child: _isLoading ? CircularProgressIndicator() : Text("LOGIN", style: TextStyle()),
                        textColor: Colors.white,
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80)),
                      ),
                    ),
                    SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text(
                        "Don't have an account? Sign UP",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
