import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ticktokclone/setting/breakpoint.dart';
import 'package:ticktokclone/setting/sizes.dart';
import 'package:ticktokclone/widgets/utils.dart';

class DiscovoerScreen extends StatelessWidget {
  DiscovoerScreen({super.key});
  final TextEditingController _controller = TextEditingController();
  List tabs = ["video", "photo", "id", "inviting", "celebration"];

  @override
  Widget build(BuildContext context) {
    final wi = MediaQuery.of(context).size.width;
    print(wi);
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: Breakpoint.md,
              minWidth: Breakpoint.sm,
            ),
            child: CupertinoSearchTextField(
              controller: _controller,
              style: TextStyle(
                color: isDarkMode(context) ? Colors.white : Colors.black,
              ),
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(Sizes.size32),
            child: TabBar(
              padding: EdgeInsets.symmetric(horizontal: Sizes.size10),
              unselectedLabelColor: Colors.grey,
              dividerColor: Colors.grey,
              textScaler: TextScaler.linear(1.3),
              tabAlignment: TabAlignment.center,
              indicatorColor: Colors.black,
              splashFactory: NoSplash.splashFactory,
              isScrollable: true,
              tabs: [
                for (var tab in tabs)
                  SizedBox(width: 100, child: Tab(text: tab)),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              itemCount: 20,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 9 / 10,
                crossAxisCount: wi > Breakpoint.lg ? 5 : 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
              itemBuilder: (context, index) => AspectRatio(
                aspectRatio: 9 / 10,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Column(
                      children: [
                        Image.asset("assets/kwon.jpg", fit: BoxFit.cover),
                        Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          "this is very long caption for my ticktok photo, and for every things in the app",
                          style: TextStyle(
                            fontSize: Sizes.size16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: constraints.maxWidth < 360
                              ? Text("")
                              : Row(
                                  children: [
                                    CircleAvatar(
                                      child: Text("mrpark", maxLines: 1),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "my avatar is awasome!!${constraints.maxWidth}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    FaIcon(FontAwesomeIcons.heart),
                                    Text("2.5M"),
                                  ],
                                ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            for (var tab in tabs.skip(1))
              Center(
                child: Text(tab, style: TextStyle(fontSize: Sizes.size20)),
              ),
          ],
        ),
      ),
    );
  }
}
