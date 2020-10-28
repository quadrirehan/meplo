import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meplo/Location.dart';
import 'package:meplo/MyAds.dart';
import 'package:meplo/PostAd/PostAd1.dart';
import 'package:meplo/UI/MyWidgets.dart';
import 'package:meplo/User/UserProfile.dart';
import 'ProductDetails.dart';
import 'User/LogIn.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controller = TextEditingController();
  int _bottomIndex = 0;
  MyWidgets _myWidgets = MyWidgets();

  bool _isSelected = false;
  int _index;

  List<Color> categoriesColour = [
    Colors.deepPurpleAccent[400],
    Colors.green[900],
    Colors.pinkAccent[400],
    Colors.green[800],
    Colors.deepOrange,
    Colors.purple[900],
  ];

  List<String> categoriesImages = [
    "assets/categories/Meplo-G01.png",
    "assets/categories/Meplo-G02.png",
    "assets/categories/Meplo-G03.png",
    "assets/categories/Meplo-G04.png",
    "assets/categories/Meplo-G05.png",
    "assets/categories/Meplo-G06.png",
  ];
  List<String> categories = [
    "Plants",
    "Machines",
    "Parts",
    "Operators/Mechanic",
    "Engines",
    "New Dealers"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: _myWidgets.onWillPop,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Location()));
                },
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: Color.fromRGBO(0, 65, 0, 1)),
                    SizedBox(width: 5),
                    Row(
                      children: [
                        Text(
                          "Collector Office Campus, Aurangabad ",
                          style: TextStyle(color: Color.fromRGBO(0, 65, 0, 1)),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Color.fromRGBO(0, 65, 0, 1),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide()),
                          hintText: "Machines, Engine, Plant, Parts...."),
                    ),
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LogIn()));
                    },
                    child: Icon(
                      Icons.notifications_none,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              Divider(color: Colors.black),
              SizedBox(height: 10),
              Text("Browse Categories", textAlign: TextAlign.left),
              SizedBox(height: 10),
              GridView.builder(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.8,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 25,
                      crossAxisCount: 3),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GridTile(
                        child: Column(
                      children: [
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: categoriesColour[index],
                            // image: DecorationImage(
                            //     image: AssetImage(
                            //         "assets/categories/plants.png"))
                          ),
                          child: Center(
                              child: Image.asset(
                            categoriesImages[index],
                            height: 75,
                            color: Colors.white,
                          )),
                        ),
                        SizedBox(height: 5),
                        Text(
                          categories[index],
                          style: TextStyle(fontSize: 10),
                          textAlign: TextAlign.center,
                          softWrap: false,
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ));
                  }),
              SizedBox(height: 10),
              Container(
                height: 80,
                color: Colors.blue[900],
              ),
              SizedBox(height: 10),
              Text(
                "Fresh Recommendations",
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10),
              GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    // /*crossAxisSpacing: 10*/ childAspectRatio: 0.9
                  ),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side:
                              BorderSide(color: Colors.grey[300], width: 1.5)),
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              print(index.toString());
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetails()));
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset("assets/machine.jpg",
                                      fit: BoxFit.fill),
                                  SizedBox(height: 10),
                                  Text(
                                    "₹ 7,50,000",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Text("Birla Generator"),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                padding: EdgeInsets.all(5),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _index = index;
                                      _isSelected = !_isSelected;
                                    });
                                  },
                                  child: Icon(index == _index && _isSelected
                                      ? Icons.favorite
                                      : Icons.favorite_border),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PostAd1()));
        },
        child: Icon(
          Icons.add_circle_outline,
          size: 60,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomIndex,
        showUnselectedLabels: true,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("HOME")),
          BottomNavigationBarItem(icon: Icon(null), title: Text("SELL")),
          BottomNavigationBarItem(
              icon: Icon(Icons.font_download), title: Text("MY ADS")),
          /*BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text("ACCOUNT"),
          )*/
        ],
        onTap: (value) {
          setState(() {
            _bottomIndex = value;
            switch (value) {
              case 0:
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home()));
                ;
                break;
              case 1:
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home()));
                break;
              case 2:
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => MyAds()));
                break;
              /*case 3: Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => UserProfile()));
                break;*/
            }
          });
        },
      ),
    );
  }
}
