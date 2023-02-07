import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/screens/history_page.dart';
import 'package:movie_app/screens/home_page.dart';
import 'package:movie_app/temp.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Pages extends StatelessWidget {
  Pages({Key? key}) : super(key: key);

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: indexPage);

  List<Widget> _buildScreens() {
    return [const HomePage(), const HistoryPage()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.house_fill),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: Colors.grey.shade600,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.ticket_fill),
        title: ("Ticket"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: Colors.grey.shade600,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: const Color.fromARGB(255, 34, 34, 37), // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: const NavBarDecoration(
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style3, // Choose the nav bar style with this property.
    );
  }
}
