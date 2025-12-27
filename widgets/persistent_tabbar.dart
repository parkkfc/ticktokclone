import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ticktokclone/setting/breakpoint.dart';

class PersistentTabbar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final wi = MediaQuery.of(context).size.width;
    print(wi);
    return Container(
      decoration: BoxDecoration(color: Colors.white),

      child: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.center,
        splashFactory: NoSplash.splashFactory,
        dividerColor: Colors.grey,
        indicatorColor: Theme.of(context).primaryColor,
        tabs: [
          SizedBox(
            width: wi / 4,
            child: Tab(icon: FaIcon(FontAwesomeIcons.table)),
          ),
          SizedBox(
            width: wi / 4,
            child: Tab(icon: FaIcon(FontAwesomeIcons.heart)),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 48;

  @override
  // TODO: implement minExtent
  double get minExtent => 48;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
