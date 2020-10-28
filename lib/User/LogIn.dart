import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meplo/Home.dart';

import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:meplo/UI/DatabaseHelper.dart';
import 'package:meplo/UI/Menifo.dart';

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
  Menifo menifo = Menifo();

  Future<void> logInUser() async {
    url = menifo.getBseUrl() +
        "LoginUser?user_email=${_userEmail.text}&user_password=${_userPass.text}";
    print(url);
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': "application/json"});

    // print(jsonDecode(response.body).toString());

    if (jsonDecode(response.body).toString() == "Invalid Credintials!") {
      setState(() {

      });
      return Fluttertoast.showToast(
          msg: "Invalid Credintials!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.grey[600],
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      DatabaseHelper db = DatabaseHelper.instance;
      db
          .insertUser(
              jsonDecode(response.body)[0]['user_id'].toString(),
              jsonDecode(response.body)[0]['user_name'].toString(),
              jsonDecode(response.body)[0]['user_email'].toString(),
              jsonDecode(response.body)[0]['user_mobile'].toString(),
              jsonDecode(response.body)[0]['user_password'].toString())
          .then((value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      });
      return Fluttertoast.showToast(
          msg: "LogIn Successfully!",
          backgroundColor: Colors.grey[600],
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 16.0);
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
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            logInUser();
                          }
                        },
                        child: Text("LOGIN", style: TextStyle()),
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
