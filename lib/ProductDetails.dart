import 'package:flutter/material.dart';
import 'SellerProfile.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFavorite = false;
  bool relatedAdsIsFavorite = false;
  int _relatedAdsIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: 200,
            color: Colors.red,
          ),
          ListView(
            physics: ScrollPhysics(),
            padding: EdgeInsets.only(left: 10, top: 10, right: 10),
            shrinkWrap: true,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(
                    "₹ 7,50,000",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
                  InkWell(
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        size: 30,
                      ))
                ],
              ),
              SizedBox(height: 5),
              Text(
                "Birla Generator petrol and kerosene with battery",
                overflow: TextOverflow.visible,
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(width: 5),
                        Text("SATARA, AURANGABAD")
                      ],
                    ),
                  ),
                  Text("01 OCT")
                ],
              ),
              SizedBox(height: 5),
              Divider(color: Colors.black),
              SizedBox(height: 10),
              Text(
                "Description",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text("Very Good Condition"),
              SizedBox(height: 10),
              Divider(color: Colors.black),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SellerProfile()));
                },
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.all(10),
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                        child: Icon(
                          Icons.person,
                          size: 70,
                        )),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Seller Name",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 3),
                          Text(
                            "Member since Feb 2015",
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "See Profile",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_right),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Divider(color: Colors.black),
              SizedBox(height: 15),
              Text("Ad Posted At:", style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 10),
              Container(height: 100, child: Center(child: Text("MAP"))),
              SizedBox(height: 10),
              Divider(color: Colors.black),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "AD ID : 1598678686",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "REPORT THIS AD",
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Divider(color: Colors.black),
              SizedBox(height: 10),
              Text("Related Ads", style: TextStyle(fontWeight: FontWeight.bold),),
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(color: Colors.grey[300], width: 1.5)),
                      child: Container(
                        width: 170,
                        // margin: EdgeInsets.only(top: 10, right: 10, bottom: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[100]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.asset(
                                "assets/machine.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(child: Text("₹ 26,999")),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        _relatedAdsIndex = index;
                                        relatedAdsIsFavorite = !relatedAdsIsFavorite;
                                        print(index.toString());
                                      });
                                    },
                                    child: Icon(index == _relatedAdsIndex &&
                                        relatedAdsIsFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border)),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              "HP i3 7 generation, brand new condition", style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5),
                            Text("Cantonment, Aurangabad", style: TextStyle(fontSize: 10),textAlign: TextAlign.left,)
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 8, top: 8, bottom: 8),
                  height: 45,
                  child: RaisedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chat_bubble_outline, color: Colors.white,),
                        SizedBox(width: 5,),
                        Text("Chat"),
                      ],
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    color: Colors.black,
                    textColor: Colors.white,
                  ),
                )),
            SizedBox(width: 8),
            Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 8, right: 8, bottom: 8),
                  height: 45,
                  child: RaisedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.local_offer, color: Colors.white,),
                        SizedBox(width: 5,),
                        Text("Make Offer"),
                      ],
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    color: Colors.black,
                    textColor: Colors.white,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
