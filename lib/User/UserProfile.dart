import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meplo/UI/MyWidgets.dart';
import 'package:meplo/User/EditProfile.dart';
import 'package:meplo/User/UserSettings.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0,),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(left: 10, right: 10),
        shrinkWrap: true,
        children: [
          Container(
            // padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
                  },
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.all(10),
                          height: 100,
                          width: 100,
                         /* decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.yellow[700],
                          ),*/
                          child: CachedNetworkImage(
                              imageUrl: MyWidgets.userImageUrl + MyWidgets.userImage,
                              fit: BoxFit.fill,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.person, color: Colors.black, size: 100,))
                          ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(MyWidgets.userName, style: TextStyle(fontSize: 25,
                              fontWeight: FontWeight.w500),),
                          SizedBox(height: 3),
                          Text("View and edit profile", style: TextStyle(
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              decorationThickness: 1.5),),
                        ],
                      )
                    ],
                  ),
                ),
                // SizedBox(height: 5),
                // Text("Seller Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                // SizedBox(height: 5),
                // Text("MEMBER SINCE FEB 15", style: TextStyle(fontSize: 10),),
              ],
            ),
          ),
          SizedBox(height: 20),
          ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                leading: Icon(Icons.credit_card_rounded, color: Colors.black,),
                title: Text("Buy Packages & My Orders"),
                subtitle: Text("Packages, orders, billing and invoices"),
                trailing: Icon(
                  Icons.keyboard_arrow_right, color: Colors.black,),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserSettings()));
                },
                leading: Icon(Icons.settings_rounded, color: Colors.black,),
                title: Text("Settings"),
                subtitle: Text("Privacy and logout"),
                trailing: Icon(
                  Icons.keyboard_arrow_right, color: Colors.black,),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.help_outline, color: Colors.black,),
                title: Text("Help & Support"),
                subtitle: Text("Help center and legal terms"),
                trailing: Icon(
                  Icons.keyboard_arrow_right, color: Colors.black,),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.language_sharp, color: Colors.black,),
                title: Text("Select Language / भाषा चुने"),
                subtitle: Text("English (India)"),
                trailing: Icon(
                  Icons.keyboard_arrow_right, color: Colors.black,),
              ),
              Divider(),
            ],
          )
        ],
      ),
    );
  }
}
