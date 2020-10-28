import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:meplo/UI/Menifo.dart';

import 'LogIn.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _userName = TextEditingController();
  TextEditingController _userMob = TextEditingController();
  TextEditingController _userEmail = TextEditingController();
  TextEditingController _userPass = TextEditingController();

  String url;
  Menifo menifo;

  @override
  void initState() {
    super.initState();
    menifo = Menifo();
  }

  Future<void> registerUser() async {
    url = menifo.getBseUrl() +
        "RegisterUser?user_name=${_userName.text}&user_email=${_userEmail.text}&user_mobile=${_userMob.text}&user_password=${_userPass.text}";
    print(url);
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': "application/json"});
    print(jsonDecode(response.body).toString());
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogIn()));
    return Fluttertoast.showToast(
          msg: "User Registered Successfully!",
          fontSize: 16.0,
          backgroundColor: Colors.grey[600],
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT);
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
                      "REGISTER",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Name",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _userName,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          hintText: "John Doe",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 14)),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter Full Name";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Mobile Number",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _userMob,
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          hintText: "8123******",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 14)),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter Mobile Number";
                        } else if (value.length != 10) {
                          return "Enter Valid Mobile Number";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10),
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
                    SizedBox(height: 20),
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
                    SizedBox(height: 20),
                    Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            registerUser();
                            /*Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')));*/
                          }
                        },
                        child: Text("SIGNUP", style: TextStyle()),
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
                            MaterialPageRoute(builder: (context) => LogIn()));
                      },
                      child: Text(
                        "Already have an account? Sign in",
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
