import 'package:flutter/material.dart';
import 'package:meplo/UI/DatabaseHelper.dart';
import 'package:meplo/User/LogIn.dart';
import 'package:meplo/User/UserProfile.dart';

class UserSettings extends StatefulWidget {
  @override
  _UserSettingsState createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Privacy",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "Change password",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_right, size: 30,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Notifications",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Recommendations & Special communications",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              DatabaseHelper db = DatabaseHelper.instance;
              db.deleteUser().whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => LogIn()));
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Logout"),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("Logout from all devices"),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("Deactivate account and delete my data"),
          ),
          Divider(),
        ],
      ),
    );
  }
}
