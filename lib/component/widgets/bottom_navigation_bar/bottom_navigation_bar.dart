import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key, required this.onTap, required this.currentIndex}) : super(key: key);
  final Function(int) onTap;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return  BottomNavigationBar(
      onTap: onTap,
      currentIndex: currentIndex,
      items:  const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Timeline'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Groups'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings'
        ),
      ],
      backgroundColor: Theme.of(context).colorScheme.background,
      selectedItemColor: Colors.blue, // COULD BE MORE DYNAMIC
      unselectedItemColor: Colors.black, // COULD ALSO BE MORE DYNAMIC
      type: BottomNavigationBarType.fixed,
    );
  }
}
