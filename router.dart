import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ticktokclone/notification/notifications_provider.dart';
import 'package:ticktokclone/repos/autentication_repo.dart';
import 'package:ticktokclone/screen/activityscreen.dart';
import 'package:ticktokclone/screen/authentication/emailscreen.dart';
import 'package:ticktokclone/screen/authentication/loginsreen.dart';
import 'package:ticktokclone/screen/authentication/passwordscreen.dart';
import 'package:ticktokclone/screen/authentication/signupscreen.dart';
import 'package:ticktokclone/screen/authentication/usernamescreen.dart';
import 'package:ticktokclone/screen/chatloom.dart';
import 'package:ticktokclone/screen/chatscreen.dart';
import 'package:ticktokclone/screen/interests.dart';
import 'package:ticktokclone/screen/mainnavigation.dart';
import 'package:ticktokclone/screen/settings_screen.dart';
import 'package:ticktokclone/videorecording.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: "/home",

    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepo).isLoggedIn;
      final allowed = [
        SignupScreen.routeUrl,
        LoginScreen.routeUrl,
        UsernameScreen.routeUrl,
        EmailScreen.routeUrl,
        PasswordScreen.routeUrl,
        Interests.routeUrl,
      ];
      if (!isLoggedIn && !allowed.contains(state.subloc)) {
        return SignupScreen.routeUrl;
      }
      if (isLoggedIn && state.subloc == SignupScreen.routeUrl) {
        return "/home";
      }

      return null;
    },
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          ref.read(notificationsProvider(context));
          return child;
        },
        routes: [
          GoRoute(
            path: UsernameScreen.routeUrl,
            name: UsernameScreen.routeName,
            builder: (context, state) {
              print(state.subloc);
              return UsernameScreen();
            },
          ),
          GoRoute(
            path: SettingsScreen.routeUrl,
            name: SettingsScreen.routeName,
            builder: (context, state) {
              return SettingsScreen();
            },
          ),
          GoRoute(
            path: SignupScreen.routeUrl,
            name: SignupScreen.routeName,
            builder: (context, state) {
              print(state.subloc);
              return SignupScreen();
            },
          ),
          GoRoute(
            path: PasswordScreen.routeUrl,
            name: PasswordScreen.routeName,
            builder: (context, state) {
              return PasswordScreen();
            },
          ),
          GoRoute(
            path: LoginScreen.routeUrl,
            name: LoginScreen.routeName,
            builder: (context, state) {
              return LoginScreen();
            },
          ),
          GoRoute(
            path: Interests.routeUrl,
            name: Interests.routeName,
            builder: (context, state) {
              return Interests();
            },
          ),
          GoRoute(
            path: "/:tab(home|discover|inbox|profile)",
            name: MainnavigationScreen.routeName,
            builder: (context, state) {
              final tab = state.params["tab"];
              return MainnavigationScreen(tab: tab ?? "home");
            },
          ),

          GoRoute(
            path: ActivityScreen.routeUrl,
            name: ActivityScreen.routeName,
            builder: (context, state) {
              return ActivityScreen();
            },
          ),
          GoRoute(
            path: EmailScreen.routeUrl,
            name: EmailScreen.routeName,
            builder: (context, state) {
              print(state.subloc);
              final args = state.extra as EmailScreenArgs;
              return EmailScreen(username: args.username);
            },
          ),
          GoRoute(
            path: Chatscreen.routeUrl,
            name: Chatscreen.routeName,
            builder: (context, state) {
              return Chatscreen();
            },
            routes: [
              GoRoute(
                path: Chatloom.routeUrl,
                name: Chatloom.routeName,
                builder: (context, state) {
                  final loomnum = state.params["id"];
                  return Chatloom(chatNum: loomnum!);
                },
              ),
            ],
          ),
          GoRoute(
            path: VideoRecordingScreen.routeUrl,
            name: VideoRecordingScreen.routeName,
            pageBuilder: (context, state) => CustomTransitionPage(
              child: VideoRecordingScreen(),
              transitionsBuilder: (context, animation, secondanimation, child) {
                final position = Tween(
                  begin: Offset(0, 1),
                  end: Offset.zero,
                ).animate(animation);

                return SlideTransition(position: position);
              },
            ),
          ),
        ],
      ),
    ],
  );
});
