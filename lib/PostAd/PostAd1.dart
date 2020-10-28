import 'package:flutter/material.dart';
import 'package:meplo/PostAd/PostAd2.dart';

class PostAd1 extends StatefulWidget {
  @override
  _PostAd1State createState() => _PostAd1State();
}

class _PostAd1State extends State<PostAd1> {
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "What are you offering?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: GridView.builder(
              padding: EdgeInsets.only(left: 24, right: 24),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PostAd2(index)));
                  },
                  child: Card(
                    elevation: 2,
                    color: Colors.white,
                    child: GridTile(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Image.asset(
                          categoriesImages[index],
                          height: 85,
                          color: Colors.black,
                        )),
                        // SizedBox(height: 5),
                        Text(
                          categories[index],
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    )),
                  ),
                );
              }),
        ));
  }
}
