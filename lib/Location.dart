import 'package:flutter/material.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {

  TextEditingController _location = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Location")),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 15, right: 15),
            child: TextField(
              controller: _location,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide()),
                  hintText: "Search city, area or neighbourhood"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 15.0, right: 15),
            child: ListTile(
              onTap: (){},
              leading: Icon(Icons.my_location, color: Colors.blue,),
              title: Text("Use current location", style: TextStyle(color: Colors.blue),),
              subtitle: Text("N 12, Aurangabad"),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, top: 5, bottom: 5),
            color: Colors.grey[300],
            child: Text("RECENTLY USED"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 8.0, right: 15, bottom: 8),
            child: ListTile(
              leading: Icon(Icons.location_on_outlined, color: Colors.grey, size: 30,),
              title: Text("Aurangabad, Maharashtra"),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, top: 5, bottom: 5),
            color: Colors.grey[300],
            child: Text("CHOOSE STATE"),
          ),
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("All in India", style: TextStyle(color: Colors.blue),),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(child: Text("Andaman & Nicobar Island")),
                    Icon(Icons.keyboard_arrow_right, color: Colors.black),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(child: Text("Andhra Pradesh")),
                    Icon(Icons.keyboard_arrow_right, color: Colors.black),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(child: Text("Arunachal Pradesh")),
                    Icon(Icons.keyboard_arrow_right, color: Colors.black),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(child: Text("Assam")),
                    Icon(Icons.keyboard_arrow_right, color: Colors.black),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(child: Text("Bihar")),
                    Icon(Icons.keyboard_arrow_right, color: Colors.black),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(child: Text("Chandhigarh")),
                    Icon(Icons.keyboard_arrow_right, color: Colors.black),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(child: Text("Chhattisgarh")),
                    Icon(Icons.keyboard_arrow_right, color: Colors.black),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(child: Text("Dadra & Nagar Haveli")),
                    Icon(Icons.keyboard_arrow_right, color: Colors.black),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(child: Text("Daman & Diu")),
                    Icon(Icons.keyboard_arrow_right, color: Colors.black),
                  ],
                ),
              ),
              Divider(),
            ],
          )
        ],
      ),
    );
  }
}
