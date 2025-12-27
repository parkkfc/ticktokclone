import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ticktokclone/screen/chatloom.dart';

class Chatscreen extends StatefulWidget {
  const Chatscreen({super.key});
  static const routeName = "chatscreen";
  static const routeUrl = "/chatscreen";

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();
  int index_num = 0;
  List<int> items = [];

  void _addItem() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(items.length);
    }
    items.add(items.length);
    index_num += 1;
  }

  void _deleteItem(int index) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(
        index,
        (context, animation) => FadeTransition(
          opacity: animation,
          child: ListTile(
            onLongPress: () => _deleteItem(index),
            key: UniqueKey(),
            leading: CircleAvatar(child: Container(child: Text("park"))),
            title: Text("CHAT$index"),
            subtitle: Text("this is for you"),
          ),
        ),
      );
    }
    items.removeAt(index);
    index_num -= 1;
  }

  void _chatloom(BuildContext context, int index) {
    context.pushNamed(Chatloom.routeName, params: {"id": "$index"});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("chat"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _addItem, icon: FaIcon(FontAwesomeIcons.plus)),
        ],
      ),
      body: AnimatedList(
        key: _key,
        initialItemCount: 0,

        itemBuilder:
            (BuildContext context, int index, Animation<double> animation) {
              return ScaleTransition(
                scale: animation,
                child: ListTile(
                  onTap: () => _chatloom(context, index),
                  onLongPress: () => _deleteItem(index),
                  key: UniqueKey(),
                  leading: CircleAvatar(child: Container(child: Text("park"))),
                  title: Text("CHAT$index"),
                  subtitle: Text("this is for you"),
                ),
              );
            },
      ),
    );
  }
}
