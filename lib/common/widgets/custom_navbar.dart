import 'package:flutter/material.dart';

class KCustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const KCustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      iconSize: 28,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Saved'),
        BottomNavigationBarItem(icon: Icon(Icons.download), label: 'Downloads'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
