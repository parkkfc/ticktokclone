import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ticktokclone/setting/gaps.dart';
import 'package:ticktokclone/setting/sizes.dart';

class TalkTab extends StatefulWidget {
  const TalkTab({super.key});
  @override
  State<TalkTab> createState() => _TalkTabState();
}

class _TalkTabState extends State<TalkTab> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();

  final FocusNode _focusNode = FocusNode();
  void _onPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusNode.dispose();
  }

  void _onBodyTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Talk"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () => _onPressed(context),
              icon: FaIcon(FontAwesomeIcons.xmark),
            ),
          ],
        ),
        body: GestureDetector(
          onTap: _onBodyTap,
          child: Stack(
            children: [
              Scrollbar(
                controller: _scrollController,
                thickness: 20,
                child: ListView.separated(
                  itemCount: 10,
                  separatorBuilder: (context, index) => Gaps.v16,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: Sizes.size10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.teal,
                          child: Text(
                            "Park",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Gaps.h11,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Park"),
                              Text(
                                "That's not it i've seen the same thing but also in a cave",
                              ),
                            ],
                          ),
                        ),
                        Gaps.h10,
                        Column(
                          children: [
                            FaIcon(FontAwesomeIcons.heart, color: Colors.grey),
                            Text("33k"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                width: MediaQuery.of(context).size.width,
                child: BottomAppBar(
                  color: Colors.white,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.teal,
                        child: Text(
                          "park",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Gaps.h10,
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
                                    onTap: _onBodyTap,
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
