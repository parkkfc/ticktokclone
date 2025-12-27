import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ticktokclone/screen/activityscreen.dart';
import 'package:ticktokclone/screen/chatscreen.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  void _onSend() {
    context.pushNamed(Chatscreen.routeName);
  }

  void _onActivity() {
    context.pushNamed(ActivityScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Inbox"),
        actions: [
          IconButton(
            onPressed: _onSend,
            icon: FaIcon(FontAwesomeIcons.paperPlane),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: _onActivity,
            title: Text("Activity"),
            subtitle: Text("this is for your choice"),
            trailing: FaIcon(FontAwesomeIcons.chevronRight),
          ),
          ListTile(
            leading: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              width: 50,
              child: Center(child: FaIcon(FontAwesomeIcons.users)),
            ),
            title: Text("New followers"),
            subtitle: Text("Messages from followers will appear here"),
            trailing: FaIcon(FontAwesomeIcons.chevronRight),
          ),
        ],
      ),
    );
  }
}
