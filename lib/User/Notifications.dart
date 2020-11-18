import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool _notifications = true;
  bool _specialCommunications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            shrinkWrap: true,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _notifications = !_notifications;
                  });
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Notifications",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "Recommendations & Special communications",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      _notifications
                          ? Icons.toggle_on
                          : Icons.toggle_off_outlined,
                      size: 50,
                    )
                  ],
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  setState(() {
                    _specialCommunications = !_specialCommunications;
                  });
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Special communications & offers",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "Receive updates, offers, surveys and more",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      _specialCommunications
                          ? Icons.toggle_on
                          : Icons.toggle_off_outlined,
                      size: 50,
                    ),
                  ],
                ),
              ),
              Divider(),
            ],
          )),
    );
  }
}
