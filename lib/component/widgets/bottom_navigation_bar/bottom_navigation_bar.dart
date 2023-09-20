import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hurricane_events/component/constants/images.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key, required this.onTap, required this.currentIndex}) : super(key: key);
  final Function(int) onTap;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: currentIndex,

      items: [
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              currentIndex == 0 ? AppImages.timelineIconColored : AppImages.timelineIcon,
            ),
            label: 'Timeline'),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              currentIndex == 1 ? AppImages.groupIconColored : AppImages.groupIcon,
            ),
            label: 'Groups'),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              currentIndex == 2 ? AppImages.calendarIconStarColored : AppImages.calendarStarIcon,
            ),
            label: 'Calendar'),
        BottomNavigationBarItem(icon: SvgPicture.asset(currentIndex == 3 ? AppImages.settingsIconColored : AppImages.settingsIcon), label: 'Settings'),
      ],
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue, // COULD BE MORE DYNAMIC
      unselectedItemColor: Colors.black, // COULD ALSO BE MORE DYNAMIC
      type: BottomNavigationBarType.fixed,
    );
  }
}
