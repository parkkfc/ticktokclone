import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ticktokclone/model/user_view_model.dart';
import 'package:ticktokclone/repos/autentication_repo.dart';
import 'package:ticktokclone/screen/settings_screen.dart';
import 'package:ticktokclone/setting/breakpoint.dart';
import 'package:ticktokclone/setting/gaps.dart';
import 'package:ticktokclone/setting/sizes.dart';
import 'package:ticktokclone/widgets/avartar.dart';
import 'package:ticktokclone/widgets/persistent_tabbar.dart';

class UserprofileScreen extends ConsumerStatefulWidget {
  const UserprofileScreen({super.key, required this.username});
  final String username;
  @override
  ConsumerState<UserprofileScreen> createState() => _UserprofileScreenState();
}

class _UserprofileScreenState extends ConsumerState<UserprofileScreen> {
  void _onTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final wi = MediaQuery.of(context).size.width;

    return ref
        .watch(usersProvider)
        .when(
          loading: () => Center(child: CircularProgressIndicator.adaptive()),
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          data: (data) => SafeArea(
            child: DefaultTabController(
              length: 2,
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      centerTitle: true,
                      title: Text(data.name),
                      actions: [
                        IconButton(
                          onPressed: () => _onTap(context),
                          icon: FaIcon(FontAwesomeIcons.gear),
                        ),
                      ],
                    ),

                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Avartar(
                            name: data.name,
                            hasAvatar: data.hasAvatar,
                            uid: data.uid,
                          ),
                          SizedBox(height: 8),
                          Text(
                            data.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Next Year Wordcup",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "100",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text("Following"),
                                  ],
                                ),
                                VerticalDivider(
                                  indent: 5,
                                  endIndent: 5,
                                  width: 30,
                                  thickness: 2,
                                  color: Colors.grey,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "200",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text("Followers"),
                                  ],
                                ),
                                VerticalDivider(
                                  indent: 5,
                                  endIndent: 5,
                                  width: 30,
                                  thickness: 2,
                                  color: Colors.grey,
                                ),

                                Column(
                                  children: [
                                    Text(
                                      "300",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text("Likes"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Theme.of(context).primaryColor,
                            ),
                            height: 50,
                            width: 200,
                            child: Text(
                              "Follow",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Gaps.v10,
                          Text("If you are like football, follow me"),
                        ],
                      ),
                    ),
                    SliverPersistentHeader(
                      delegate: PersistentTabbar(),
                      pinned: true,
                    ),
                  ];
                },
                body: TabBarView(
                  children: [
                    GridView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: 20,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 9 / 16,
                        crossAxisCount: wi > Breakpoint.sm ? 5 : 3,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemBuilder: (context, index) => AspectRatio(
                        aspectRatio: 9 / 16,
                        child: Stack(
                          fit: StackFit.expand,
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 100,
                              height: 200,
                              child: Image.asset(
                                "assets/kwon.jpg",
                                fit: BoxFit.fill,
                              ),
                            ),
                            Positioned(
                              left: 5,
                              bottom: 5,
                              child: Row(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.play,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "5.5M",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(child: Text("Second Tab View")),
                  ],
                ),
              ),
            ),
          ),
        );
  }
}
