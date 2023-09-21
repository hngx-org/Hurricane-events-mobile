import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hurricane_events/app/presentation/home/my_group/widgets/group_chip.dart';
import 'package:hurricane_events/app/router/base_navigator.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/constants/images.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/component/widgets/click_button.dart';
import 'package:hurricane_events/component/widgets/event_card.dart';
import 'package:hurricane_events/data/models/events/event_mock_up.dart';

final sampleEvent = EventsMockUp(
  name: "Hurricane Slack meeting",
  groupName: "Hangouts",
  startDate: DateTime.parse("2023-09-16 14:00:00Z"),
  endDate: DateTime.parse("2023-09-18 00:00:00Z"),
  startDateStartTime: const TimeOfDay(hour: 12, minute: 00),
  startDateEndTime: const TimeOfDay(hour: 12, minute: 00),
  location: "Slack",
  comments: [
    Comment(
      comment: "Team hurricane here we come",
      createdAt: DateTime.parse("2023-09-16 10:20:00Z"),
      hasImage: false,
      userName: "Oladipupo",
    ),
    Comment(
      comment: "I'll be there and i'll bring my Banana",
      createdAt: DateTime.parse("2023-09-16 10:50:00Z"),
      hasImage: true,
      image:
          "https://images.unsplash.com/photo-1481349518771-20055b2a7b24?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cmFuZG9tfGVufDB8fDB8fHww&w=1000&q=80",
      userName: "Oladipupo",
    ),
    Comment(
      comment: "Finally, my hangout time",
      createdAt: DateTime.parse("2023-09-16 11:30:00Z"),
      hasImage: false,
      userName: "Oladipupo",
    ),
    Comment(
      comment: "Leggo, Team hurricane here we come",
      createdAt: DateTime.parse("2023-09-16 11:50:00Z"),
      hasImage: false,
      userName: "Oladipupo",
    ),
    Comment(
      comment: "See my lightbulb, that was how my mind felt, I was enlightened",
      createdAt: DateTime.parse("2023-09-19 01:50:00Z"),
      hasImage: true,
      userImage:
          "https://images.unsplash.com/photo-1493612276216-ee3925520721?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE5fHx8ZW58MHx8fHx8&w=1000&q=80",
      image:
          "https://images.unsplash.com/photo-1493612276216-ee3925520721?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE5fHx8ZW58MHx8fHx8&w=1000&q=80",
      userName: "Oladipupo",
    ),
    Comment(
      comment: "Team hurricane let's do this again",
      createdAt: DateTime.parse("2023-09-19 11:50:00Z"),
      hasImage: false,
      userName: "Oladipupo",
    ),
    Comment(
      comment: "It was nice",
      createdAt: DateTime.parse("2023-09-20 11:50:00Z"),
      hasImage: false,
      userName: "Oladipupo",
    ),
  ],
);

final sampleEvent2 = EventsMockUp(
  name: "Hurricane Slack meeting",
  groupName: "Hangouts",
  startDate: DateTime.parse("2023-09-23 14:00:00Z"),
  startDateStartTime: const TimeOfDay(hour: 12, minute: 00),
  startDateEndTime: const TimeOfDay(hour: 12, minute: 00),
  location: "Slack",
  comments: [
    Comment(
      comment: "I'll be there",
      createdAt: DateTime.parse("2023-09-16 10:20:00Z"),
      hasImage: false,
      userName: "Oladipupo",
    ),
    Comment(
      comment: "I'll be there and i'll bring my Banana and my friends",
      createdAt: DateTime.parse("2023-09-16 10:50:00Z"),
      hasImage: true,
      image:
          "https://images.unsplash.com/photo-1481349518771-20055b2a7b24?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cmFuZG9tfGVufDB8fDB8fHww&w=1000&q=80",
      userName: "Oladipupo",
    ),
    Comment(
      comment: "Finally, my hangout time",
      createdAt: DateTime.parse("2023-09-16 11:30:00Z"),
      hasImage: false,
      userName: "Oladipupo",
    ),
    Comment(
      comment: "Leggo, Team hurricane here we come",
      createdAt: DateTime.parse("2023-09-16 11:50:00Z"),
      hasImage: false,
      userName: "Oladipupo",
    ),
    Comment(
      comment: "Time to light up",
      createdAt: DateTime.parse("2023-09-19 01:50:00Z"),
      hasImage: true,
      userImage:
          "https://images.unsplash.com/photo-1493612276216-ee3925520721?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE5fHx8ZW58MHx8fHx8&w=1000&q=80",
      image:
          "https://images.unsplash.com/photo-1493612276216-ee3925520721?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE5fHx8ZW58MHx8fHx8&w=1000&q=80",
      userName: "Oladipupo",
    ),
    Comment(
      comment: "Team hurricane let's do this again",
      createdAt: DateTime.parse("2023-09-19 11:50:00Z"),
      hasImage: false,
      userName: "Oladipupo",
    ),
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
              style: context.body1
                  .copyWith(fontSize: 16, color: AppColors.darkGrey),
            ),
            24.height,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    4,
                    (index) {
                      final event = index.isEven ? sampleEvent : sampleEvent2;
                      return EventCard(
                        event: event,
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
