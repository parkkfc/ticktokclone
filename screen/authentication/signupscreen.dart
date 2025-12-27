import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ticktokclone/screen/authentication/usernamescreen.dart';
import 'package:ticktokclone/widgets/button/signupcatbutton.dart';
import 'package:ticktokclone/screen/authentication/loginsreen.dart';
import 'package:ticktokclone/setting/gaps.dart';
import 'package:ticktokclone/setting/sizes.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});
  static final routeUrl = "/";
  static final routeName = "signup";

  void onLoginTap(BuildContext context) {
    context.pushNamed(LoginScreen.routeName);
  }

  void onButtonTap(BuildContext context) {
    context.pushNamed(UsernameScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account?",
              style: TextStyle(fontSize: Sizes.size20),
            ),
            Gaps.h10,
            GestureDetector(
              onTap: () => onLoginTap(context),
              child: Text(
                "login",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gaps.v14,
              Text(
                "Signup for ticktok",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Gaps.v12,
              Text(
                maxLines: 2,
                textAlign: TextAlign.center,
                "Create a profile, follow other accounts,make your own videos, and more.",

                style: TextStyle(fontSize: 19, color: Colors.black45),
              ),
              Gaps.v20,
              signupcatbutton(
                func: onButtonTap,
                signUpCat: "Use Phone or email",
                icon: FontAwesomeIcons.peopleGroup,
              ),
              Gaps.v20,
              signupcatbutton(
                func: (context) {},
                signUpCat: "Continue with Facebook",
                icon: FontAwesomeIcons.facebook,
                colorData: Colors.blue,
              ),
              Gaps.v20,
              signupcatbutton(
                func: (context) {},
                signUpCat: "Continue with Apple",
                icon: FontAwesomeIcons.apple,
              ),
              Gaps.v32,
              signupcatbutton(
                func: (context) {},
                signUpCat: "Continue with Google",
                icon: FontAwesomeIcons.google,
              ),
              Gaps.v16,
              Icon(FontAwesomeIcons.chevronDown),
            ],
          ),
        ),
      ),
    );
  }
}
