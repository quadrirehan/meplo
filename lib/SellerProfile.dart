import 'package:flutter/material.dart';

class SellerProfile extends StatefulWidget {
  @override
  _SellerProfileState createState() => _SellerProfileState();
}

class _SellerProfileState extends State<SellerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.only(left: 20, top: 10, right: 20),
        shrinkWrap: true,
        children: [
          Container(
            // padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.all(10),
                        // height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                        child: Icon(
                          Icons.person,
                          size: 100,
                        )),
                    Expanded(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                Text(
                                  "0",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "FOLLOWING",
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            )),
                            Expanded(
                                child: Column(
                              children: [
                                Text(
                                  "1",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "FOLLOWERS",
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            )),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Container(
                            width: 250,
                            child: RaisedButton(
                              onPressed: () {},
                              color: Colors.black,
                              textColor: Colors.white,
                              child: Text("Follow"),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ))
                      ],
                    ))
                  ],
                ),
                SizedBox(height: 5),
                Text("Seller Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                SizedBox(height: 5),
                Text("MEMBER SINCE FEB 15", style: TextStyle(fontSize: 10),),
              ],
            ),
          )
        ],
      ),
    );
  }
}
