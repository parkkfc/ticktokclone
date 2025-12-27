import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ticktokclone/repos/git_login_view.dart';
import 'package:ticktokclone/screen/authentication/loginformscreen.dart';
import 'package:ticktokclone/widgets/button/signupcatbutton.dart';
import 'package:ticktokclone/screen/authentication/signupscreen.dart';
import 'package:ticktokclone/setting/gaps.dart';
import 'package:ticktokclone/setting/sizes.dart';
import 'package:ticktokclone/widgets/utils.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  static final routeUrl = "/login";
  static final routeName = "login";
  void onSignupTap(BuildContext context) async {
    context.push(SignupScreen.routeUrl);
  }

  void onLoginFormTap(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => formScreen()));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OrientationBuilder(
      builder: (context, orientation) {
        print(orientation);
        return Scaffold(
          bottomNavigationBar: BottomAppBar(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Do you have an account?",
                    style: TextStyle(fontSize: Sizes.size20),
                  ),
                  Gaps.h10,
                  GestureDetector(
                    onTap: () => onSignupTap(context),
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: Sizes.size20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (orientation == Orientation.portrait) ...[
                        Gaps.v14,
                        Text(
                          "Login for ticktok",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
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
                          func: (context) => onLoginFormTap(context),
                          signUpCat: "Use Phone or email",
                          icon: FontAwesomeIcons.peopleGroup,
                          colorData: Colors.black,
                        ),

                        Gaps.v20,
                        signupcatbutton(
                          func: (context) => ref
                              .read(gitSigninProvider.notifier)
                              .githubSignin(context),
                          signUpCat: "Continue with GitHub",
                          icon: FontAwesomeIcons.github,
                          colorData: Colors.blue,
                        ),
                        Gaps.v20,

                        signupcatbutton(
                          func: (context) {},
                          signUpCat: "Continue with Google",
                          icon: FontAwesomeIcons.google,
                          colorData: Colors.black,
                        ),
                        Gaps.v16,
                        Icon(FontAwesomeIcons.chevronDown),
                      ],

                      if (orientation == Orientation.landscape) ...[
                        Gaps.v20,
                        Text(
                          "Login for ticktok",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gaps.v12,
                        Text(
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          "Create a profile, follow other accounts,make your own videos, and more.",

                          style: TextStyle(fontSize: 19, color: Colors.black45),
                        ),
                        Gaps.v20,
                        SizedBox(
                          width: 600,
                          child: Column(
                            children: [
                              signupcatbutton(
                                func: (context) => onLoginFormTap(context),
                                signUpCat: "Use Phone or email",
                                icon: FontAwesomeIcons.peopleGroup,
                                colorData: isDarkMode(context)
                                    ? Colors.grey[300]
                                    : Colors.black,
                              ),

                              Gaps.v20,
                              signupcatbutton(
                                func: (context) => (()),
                                signUpCat: "Continue with Facebook",
                                icon: FontAwesomeIcons.facebook,
                                colorData: Colors.blue,
                              ),
                              Gaps.v20,

                              signupcatbutton(
                                func: (context) => {},
                                signUpCat: "Continue with Google",
                                icon: FontAwesomeIcons.google,
                                colorData: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
