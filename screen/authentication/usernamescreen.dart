import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ticktokclone/repos/signup_view_model.dart';
import 'package:ticktokclone/screen/authentication/emailscreen.dart';
import 'package:ticktokclone/setting/gaps.dart';
import 'package:ticktokclone/setting/sizes.dart';
import 'package:ticktokclone/widgets/button/change_bio_button.dart';
import 'package:ticktokclone/widgets/button/formbutton.dart';

class UsernameScreen extends ConsumerStatefulWidget {
  const UsernameScreen({super.key});
  static final routeUrl = "/username";
  static final routeName = "username";
  @override
  ConsumerState<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends ConsumerState<UsernameScreen> {
  bool isMan = true;
  void onBackgroundTap(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  final TextEditingController _controller = TextEditingController();

  void onNextTap() {
    if (_userName.isNotEmpty)
    // context.pushNamed(
    //   EmailScreen.routeName,
    //   extra: EmailScreenArgs(username: _userName),
    // ); this is Gorout method
    {
      final state = ref.read(signupForm.notifier).state;
      ref.read(signupForm.notifier).state = {...state, "bio": "$isMan"};

      context.pushNamed(
        EmailScreen.routeName,
        extra: EmailScreenArgs(username: _userName),
      );
    } else {
      return;
    }
  }

  void changeBio() {
    isMan = !isMan;
    setState(() {});
  }

  String _userName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      setState(() {
        _userName = _controller.text;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Sign up",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: Sizes.size24),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => onBackgroundTap(context),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.size20,
            vertical: Sizes.size16,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  /// start of birthday column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create username?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Sizes.size24,
                        ),
                      ),
                      Text(
                        maxLines: 2,
                        "You can always change this later.",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: Sizes.size16,
                        ),
                      ),
                    ],
                  ),
                  Gaps.h36,
                ],
              ),
              TextField(
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  labelText: "Username",
                  hintText: "input your name",
                ),
                controller: _controller,
              ),
              Gaps.v28,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => changeBio(),
                    child: change_bio_button(isMan: isMan, mytext: "man"),
                  ),
                  GestureDetector(
                    onTap: () => changeBio(),
                    child: change_bio_button(isMan: !isMan, mytext: "woman"),
                  ),
                ],
              ),

              GestureDetector(
                onTap: () => onNextTap(),
                child: FormButton(
                  isInput: _userName.isNotEmpty,
                  disabled: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
