import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ticktokclone/repos/signup_view_model.dart';
import 'package:ticktokclone/screen/authentication/emailscreen.dart';
import 'package:ticktokclone/screen/birthday.dart';
import 'package:ticktokclone/setting/gaps.dart';
import 'package:ticktokclone/setting/sizes.dart';
import 'package:ticktokclone/widgets/button/formbutton.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  const PasswordScreen({super.key});
  static final routeName = "password";
  static final routeUrl = "/password";
  @override
  ConsumerState<PasswordScreen> createState() => PasswordScreenState();
}

class PasswordScreenState extends ConsumerState<PasswordScreen> {
  void onBackgroundTap(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  final DateTime _selectedDate = DateTime.now();

  final TextEditingController _controller = TextEditingController();

  String? _isPasswordValid() {
    final regExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    if (_password.isEmpty) return null;
    if (!regExp.hasMatch(_password))
      return "at least 8 characters long,contain both letters and numbers.";
    return null;
  }

  void onNextTap() {
    if (_password.isNotEmpty) {
      final state = ref.read(signupForm.notifier).state;
      ref.read(signupForm.notifier).state = {...state, "password": _password};
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => BirthdayScreen()));
    } else {
      return;
    }
  }

  void _onDelete() {
    _controller.clear();
    setState(() {
      _password = "";
    });
  }

  String _password = "";

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _controller.addListener(() {
      setState(() {
        _password = _controller.text;
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
                        "Password",
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
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  errorText: _isPasswordValid(),
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _onDelete,
                        child: FaIcon(
                          FontAwesomeIcons.circleXmark,
                          color: Colors.red,
                        ),
                      ),
                      Gaps.h8,
                      FaIcon(FontAwesomeIcons.eye, color: Colors.green),
                    ],
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  labelText: "psssword",
                  hintText: "input your password",
                ),
                controller: _controller,
              ),
              Gaps.v28,
              GestureDetector(
                onTap: () => onNextTap(),
                child: FormButton(
                  disabled: false,
                  isInput: _password.isNotEmpty && _isPasswordValid() == null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
