import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticktokclone/firebase_options.dart';
import 'package:ticktokclone/intl/intl_generated.dart';
import 'package:ticktokclone/notification/notifications_provider.dart';
import 'package:ticktokclone/repos/autentication_repo.dart';
import 'package:ticktokclone/repos/video_playback_repo.dart';
import 'package:ticktokclone/router.dart';
import 'package:ticktokclone/screen/authentication/emailscreen.dart';
import 'package:ticktokclone/screen/authentication/loginsreen.dart';
import 'package:ticktokclone/screen/authentication/signupscreen.dart';
import 'package:ticktokclone/screen/authentication/usernamescreen.dart';
import 'package:ticktokclone/screen/discover.dart';
import 'package:ticktokclone/screen/inbox.dart';
import 'package:ticktokclone/screen/mainnavigation.dart';

import 'package:ticktokclone/videos/video_timeline_screen.dart';
import 'package:ticktokclone/videos/widgets/video_post.dart';
import 'package:ticktokclone/viewmodel/playback_config_vm.dart';
import 'package:ticktokclone/widgets/inheritige.dart';
import 'package:ticktokclone/widgets/talktab.dart';
import 'package:ticktokclone/intl/intl_generated.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //this is to initialize firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //this is to make sure the app runs only in portrait mode
  // code-  WidgetsFlutterBinding.ensureInitialized();
  // code-  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //factory user.fromjson(Map<String,dynamic> json){return User(id:json[id])}

  //shared preferences instance is for data to be stored locally on the device
  final preferences =
      await SharedPreferences.getInstance(); //this is for storing the user preferences like autoplay and muted
  final repository = VideoPlaybackConfigRepository(preferences);
  runApp(
    // MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(
    //       create: (context) => PlaybackConfigViewModel(repository),
    //     ),
    //   ],
    //   child:
    ProviderScope(
      overrides: [
        playbackConfigProvider.overrideWith(
          () => PlaybackConfigViewModel(repository),
        ),
      ],

      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(notificationsProvider(context));
    ref.watch(authStateStream);
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => VideoConfig())],
      child: MaterialApp.router(
        routerConfig: ref.watch(routerProvider),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('ko'), // Korean
        ],
        themeMode: ThemeMode.system,
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
        ),

        theme: ThemeData(
          textTheme: Typography.blackMountainView,
          primaryColor: Colors.red[400],
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ),
    );
  }
}
