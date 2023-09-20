import 'package:flutter/material.dart';
import 'package:hurricane_events/component/constants/color.dart';

class StackedImages extends StatelessWidget {
  final int? numOfAvatars;
  const StackedImages({super.key, this.numOfAvatars});

  @override
  Widget build(BuildContext context) {
    int numOfAvatr = numOfAvatars ?? 5;
    return SizedBox(
      height: 25,
      width: 16 * numOfAvatr.toDouble(),
      child: Stack(
        children: List.generate(
          numOfAvatr,
          (index) => Positioned(
            left: switch (index) {
              0 => 0,
              _ => (10 * index).toDouble(),
            },
            child: const CircleAvatar(
              radius: 12,
              backgroundColor: AppColors.white,
              child: CircleAvatar(
                radius: 11,
                backgroundColor: AppColors.lightBlue1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
