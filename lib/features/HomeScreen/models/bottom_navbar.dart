import 'package:flutter/material.dart';

class KBottomNavbar {
  KBottomNavbar._();
  static int activeIndex = 0;
  static BottomNavigationBar bottomNavBar() {
    return BottomNavigationBar(
      onTap: (value) {
        activeIndex = value;
      },
      currentIndex: activeIndex,
      type: BottomNavigationBarType.fixed,
      iconSize: 28,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: "Home",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark_outline_rounded,
            ),
            label: "Saved"),
        BottomNavigationBarItem(
            icon: Icon(Icons.download_rounded), label: "Downloads"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_sharp), label: "Profile"),
      ],
    );
  }
}
