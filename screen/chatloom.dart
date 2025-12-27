import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ticktokclone/repos/autentication_repo.dart';
import 'package:ticktokclone/repos/user_repo.dart';
import 'package:ticktokclone/setting/gaps.dart';
import 'package:ticktokclone/viewmodel/message_view_model.dart';

class Chatloom extends ConsumerStatefulWidget {
  final String chatNum;
  const Chatloom({super.key, required this.chatNum});
  static const routeUrl = ":id";
  static const routeName = "chatloom";

  @override
  ConsumerState<Chatloom> createState() => _ChatloomState();
}

class _ChatloomState extends ConsumerState<Chatloom> {
  final TextEditingController _editingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  void _onbodytap() {
    FocusScope.of(context).unfocus();
  }

  void _onSendPressed() {
    final text = _editingController.text;
    if (text.isEmpty) {
      return;
    }
    ref.read(messageProvider.notifier).sendMessage(text, context);
    // send message logic here

    _editingController.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 0,
          leading: Stack(
            children: [
              CircleAvatar(
                radius: 30,
                child: Text("park${widget.chatNum}", maxLines: 1),
              ),
              Positioned(
                right: 1,
                bottom: 2,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                ),
              ),
            ],
          ),
          subtitle: Text("park"),
          title: Text("${widget.chatNum} chat loom"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(FontAwesomeIcons.flag),
              Gaps.h11,
              FaIcon(FontAwesomeIcons.ellipsis),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: _onbodytap,
        child: ref
            .watch(chatProvider)
            .when(
              data: (data) => Stack(
                children: [
                  ListView.separated(
                    itemBuilder: (BuildContext, index) {
                      final message = data[index];
                      final isMine =
                          message.userId == ref.read(authRepo).user!.uid;
                      return Row(
                        mainAxisAlignment: isMine
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color:
                                  message.userId == ref.read(authRepo).user!.uid
                                  ? Colors.blue
                                  : Colors.red,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(isMine ? 10 : 0),
                                bottomRight: Radius.circular(isMine ? 0 : 10),
                              ),
                            ),
                            child: Text(
                              message.text,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext, index) => Gaps.v10,
                    itemCount: data.length,
                  ),
                  Positioned(
                    bottom: 0,
                    width: MediaQuery.of(context).size.width,
                    child: BottomAppBar(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              maxLines: null,
                              minLines: null,
                              expands: true,

                              autofocus: true,
                              controller: _controller,
                              focusNode: _focusNode,
                              decoration: InputDecoration(
                                hintText: "enter comments",
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      FaIcon(FontAwesomeIcons.faceSmile),
                                      Gaps.h10,
                                      FaIcon(FontAwesomeIcons.gift),
                                      Gaps.h10,
                                      FaIcon(FontAwesomeIcons.at),
                                      Gaps.h10,

                                      GestureDetector(
                                        onTap: () {},
                                        child: FaIcon(
                                          FontAwesomeIcons.circleArrowUp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Gaps.h2,
                          Container(child: FaIcon(FontAwesomeIcons.paperPlane)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              error: (error, stacktrace) =>
                  Center(child: Text(error.toString())),
              loading: () =>
                  Center(child: CircularProgressIndicator.adaptive()),
            ),
      ),
    );
  }
}
