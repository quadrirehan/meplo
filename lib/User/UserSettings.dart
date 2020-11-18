import 'package:flutter/material.dart';
import 'package:meplo/UI/DatabaseHelper.dart';
import 'package:meplo/User/EditPassword.dart';
import 'package:meplo/User/LogIn.dart';
import 'package:meplo/User/Notifications.dart';
import 'package:meplo/User/UserProfile.dart';

class UserSettings extends StatefulWidget {
  @override
  _UserSettingsState createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {

  showAlertDialog(BuildContext context, String _title, String _subTitle, String _nextButton) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget logoutButton = FlatButton(
      child: Text(_nextButton),
      onPressed: () async {
        DatabaseHelper db = DatabaseHelper.instance;
        await db.deleteUser().whenComplete(() {
          Navigator.pop(context);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LogIn()));
        });
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(_title),
      content: Text(_subTitle),
      actions: [cancelButton, logoutButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

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
            child: InkWell(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => EditPassword()));
              },
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Privacy", overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "Change password", overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 30,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Notifications()));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Notifications",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Recommendations & Special communications",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              showAlertDialog(context, "Logout",
                  "You won't receive messages and notifications for your ads until you log in again. Are you sure you want to log out?", "Log out");
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Logout", overflow: TextOverflow.ellipsis,),
            ),
          ),
          Divider(),
          InkWell(
            onTap: (){
              showAlertDialog(context, "Logout from all devices", "You will be logged out from all browsers and app sessions. Do you want to continue", "Continue");
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Logout from all devices", overflow: TextOverflow.ellipsis,),
            ),
          ),
          Divider(),
          InkWell(
            onTap: (){
              showAlertDialog(context, "Deactivate", "Are you sure you want to deactivate your account? this action cannot be undone.", "Deactivate");
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Deactivate account and delete my data", overflow: TextOverflow.ellipsis,),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
