import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ticktokclone/repos/autentication_repo.dart';
import 'package:ticktokclone/viewmodel/playback_config_vm.dart';
import 'package:ticktokclone/widgets/inheritige.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const String routeUrl = "/settings";
  static const String routeName = "settings";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Localizations.override(
      context: context,
      locale: Locale('ko'),
      child: Scaffold(
        appBar: AppBar(title: Text("Settings"), centerTitle: true),
        body: ListView(
          children: [
            Switch.adaptive(
              hoverColor: Colors.red,
              value: ref.watch(playbackConfigProvider).muted,
              onChanged: (Value) =>
                  ref.read(playbackConfigProvider.notifier).setMuted(Value),
            ),

            CheckboxListTile.adaptive(
              activeColor: Theme.of(context).primaryColor,
              title: Text("Enable Notifications"),
              value: ref.watch(playbackConfigProvider).autoplay,
              onChanged: (newvalue) => {},
            ),
            AboutListTile(
              applicationName: "TikTok Clone",
              applicationVersion: "1.0.0",
              applicationIcon: Icon(Icons.local_fire_department),
              icon: Icon(Icons.info_outline),
              aboutBoxChildren: [
                Text("This is a TikTok clone app made by Flutter."),
                Text("The purpose of this app is to learn Flutter."),
              ],
            ),
            ListTile(
              onTap: () async {
                final today = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(Duration(days: 365 * 10)),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                print(today);
              },
              title: Text("Show Date Picker"),
            ),
            ListTile(
              onTap: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                print(time);
              },
              title: Text("Show Time Picker"),
            ),
            ListTile(
              onTap: () async {
                final timearrange = await showDateRangePicker(
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: Colors.black,
                          onPrimary: Colors.white,
                          surface: Colors.white,
                          onSurface: Colors.black,
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                  context: context,
                  firstDate: DateTime.now().subtract(Duration(days: 365 * 10)),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
              },
              title: Text("Show Date Range Picker"),
            ),
            ListTile(
              title: Text("Logout"),
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoActionSheet(
                      title: Text("Are you sure?"),
                      message: Text("Do you want to logout?"),
                      actions: [
                        CupertinoActionSheetAction(
                          onPressed: () {
                            ref.read(authRepo).signOut();
                            context.go("/");
                          },
                          isDestructiveAction: true,
                          child: Text("Logout"),
                        ),
                        CupertinoActionSheetAction(
                          onPressed: () => Navigator.of(context).pop(),
                          isDefaultAction: true,
                          child: Text("Stay"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
