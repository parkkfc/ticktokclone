import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ticktokclone/repos/signup_view_model.dart';
import 'package:ticktokclone/screen/authentication/passwordscreen.dart';
import 'package:ticktokclone/setting/gaps.dart';
import 'package:ticktokclone/setting/sizes.dart';
import 'package:ticktokclone/widgets/button/formbutton.dart';

class EmailScreenArgs {
  final String username;
  EmailScreenArgs({required this.username}); //this is for gorout method
}

class EmailScreen extends ConsumerStatefulWidget {
  const EmailScreen({super.key, required this.username});
  final String username;
  static final routeUrl = "/email";
  static final routeName = "email";
  @override
  ConsumerState<EmailScreen> createState() => EmailScreenState();
}

class EmailScreenState extends ConsumerState<EmailScreen> {
  void onBackgroundTap(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  String? _isEmailValid() {
    final regExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$');
    if (_email.isEmpty) return "Email is Required";
    if (!regExp.hasMatch(_email)) return "email is not valid";
    return null;
  }

  void _onsubmit() {
    if (_email.isEmpty) {
      return;
    } else {
      final state = ref.read(signupForm.notifier).state;
      ref.read(signupForm.notifier).state = {...state, "email": _email};
      context.pushNamed(PasswordScreen.routeName);
    }
  }

  final TextEditingController _controller = TextEditingController();

  String _email = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller.addListener(() {
      setState(() {
        _email = _controller.text;
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
    print(_email);
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "What is your email address?${widget.username}",
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
                  ),
                  Gaps.h36,
                ],
              ),
              TextField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  errorText: _isEmailValid(),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  labelText: "email address",
                  hintText: "input your email address",
                ),
                controller: _controller,
              ),
              Gaps.v28,
              GestureDetector(
                onTap: () => _onsubmit(),
                child: FormButton(
                  disabled: false,
                  isInput: _email.isNotEmpty && _isEmailValid() == null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
