import 'package:flutter/material.dart';
import 'package:hurricane_events/component/utils/extensions.dart';

import '../../../../../../component/constants/color.dart';

class CustomTab extends StatelessWidget {
  const CustomTab(
      {super.key,
      required this.currentIndex,
      required this.title,
      required this.index});

  final int currentIndex;
  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                color: currentIndex == index
                    ? AppColors.darkBlue1
                    : AppColors.darkGrey),
            top: BorderSide(
                color: currentIndex == index
                    ? AppColors.darkBlue1
                    : AppColors.darkGrey),
          ),
          color: currentIndex == index ? AppColors.p10 : Colors.white),
      child: Center(
        child: Text(
          title,
          style: context.body2.copyWith(
              fontSize: 16,
              color: currentIndex == index
                  ? AppColors.darkBlue1
                  : AppColors.designBlack3),
        ),
      ),
    );
  }
}
