import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hurricane_events/app/presentation/home/my_group/screens/group_detail_screen.dart';
import 'package:hurricane_events/app/presentation/home/my_group/widgets/group_chip.dart';
import 'package:hurricane_events/app/router/base_navigator.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/constants/images.dart';
import 'package:hurricane_events/component/utils/extensions.dart';

class MyGroupCard extends StatelessWidget {
  const MyGroupCard({
    super.key,
    required this.title,
    required this.numberOfPeople,
    required this.numberOfEvent,
  });
  final String title;
  final int numberOfPeople;
  final int numberOfEvent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BaseNavigator.pushNamed(GroupDetailsScreen.routeName);
      },
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              decoration: ShapeDecoration(
                color: AppColors.lightBlue1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              padding: const EdgeInsets.all(4),
              child: SvgPicture.asset(
                AppImages.techiesIcon,
                height: 56,
              ),
            ),
            16.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.body1.copyWith(fontSize: 16),
                ),
                12.height,
                Row(
                  children: [
                    MyGroupChip(
                      title: "$numberOfPeople people",
                    ),
                    12.width,
                    MyGroupChip(
                      title: "$numberOfEvent Upcoming events",
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
