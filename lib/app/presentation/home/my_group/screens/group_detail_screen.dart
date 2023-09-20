import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hurricane_events/app/presentation/home/my_group/widgets/group_chip.dart';
import 'package:hurricane_events/app/presentation/home/calendar/widgets/event_card.dart';
import 'package:hurricane_events/app/router/base_navigator.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/constants/images.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/component/widgets/click_button.dart';
import 'package:hurricane_events/data/models/events/event_mock_up.dart';

final sampleEvent = EventsMockUp(
  name: "Hurricane Slack meeting",
  groupName: "Hangouts",
  startDate: DateTime.now(),
  startDateStartTime: const TimeOfDay(hour: 12, minute: 00),
  startDateEndTime: const TimeOfDay(hour: 12, minute: 00),
  location: "Slack",
   comments: [
      Comment(comment: "testing"),
      Comment(comment: "testing"),
      Comment(comment: "testing"),
      Comment(comment: "testing"),
      Comment(comment: "testing"),
      Comment(comment: "testing"),
      Comment(comment: "testing"),
      Comment(comment: "testing"),
      Comment(comment: "testing"),
   ],
);

class GroupDetailsScreen extends StatelessWidget {
  static const String routeName = "group_details";
  const GroupDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: ClickWidget(
            onTap: () {
              BaseNavigator.pop();
            },
            child: const SizedBox(
              height: 30,
              width: 30,
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
              ),
            ),
          ),
        ),
        title: Text(
          "My Group",
          style: context.headline3.copyWith(
            fontSize: 16,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            40.height,
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(width: 1, color: Color(0xFFCCE6FF)),
                  bottom: BorderSide(width: 1, color: Color(0xFFCCE6FF)),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: ShapeDecoration(
                      color: AppColors.lightBlue1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                      //Group name
                      Text(
                        "Hangout",
                        style: context.body1.copyWith(fontSize: 16),
                      ),
                      12.height,
                      Row(
                        children: [
                          //Number of people
                          const MyGroupChip(
                            title: "33 people",
                          ),
                          12.width,

                          //Number of events
                          const MyGroupChip(
                            title: "3 Upcoming events",
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            40.height,
            Text(
              "Upcoming events",
              style: context.body1.copyWith(fontSize: 16, color: AppColors.darkGrey),
            ),
            24.height,
            EventCard(
               event: sampleEvent,
            ),
          ],
        ),
      ),
    );
  }
}
