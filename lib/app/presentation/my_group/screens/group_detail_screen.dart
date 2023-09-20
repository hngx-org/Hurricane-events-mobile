import 'package:flutter/material.dart';
import 'package:hurricane_events/app/presentation/my_group/widgets/group_chip.dart';
import 'package:hurricane_events/app/presentation/timeline/widgets/event_card.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/data/models/events/event_mock_up.dart';

final sampleEvent = EventsMockUp(
  name: "Hurricane Slack meeting",
  groupName: "Hangouts",
  startDate: DateTime.now(),
  startDateStartTime: const TimeOfDay(hour: 12, minute: 00),
  startDateEndTime: const TimeOfDay(hour: 12, minute: 00),
  location: "Slack",
);

class GroupDetailsScreen extends StatelessWidget {
  static const String routeName = "group_details";
  const GroupDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  left: BorderSide(color: Color(0xFFCCE6FF)),
                  top: BorderSide(width: 1, color: Color(0xFFCCE6FF)),
                  right: BorderSide(color: Color(0xFFCCE6FF)),
                  bottom: BorderSide(width: 1, color: Color(0xFFCCE6FF)),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.people,
                    size: 56,
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
            EventCard(
                group: sampleEvent.groupName!,
                startDate: sampleEvent.startDate!,
                name: sampleEvent.name!,
                location: sampleEvent.location!)
          ],
        ),
      ),
    );
  }
}
