import 'package:flutter/material.dart';
import 'package:hurricane_events/app/presentation/add_event/screens/add_event.dart';
import 'package:hurricane_events/app/router/base_navigator.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/data/models/timeline/timeline_data.dart';

import '../../../../../component/constants/images.dart';
import '../widgets/custom_tab_widget.dart';
import '../widgets/timeline_card.dart';

final sampleData = [
  TimelineData(
      title: "400m Race",
      location: 'Teslim Balogun Stadium',
      startTime: DateTime(2023, 9, 25, 16),
      endTime: DateTime(2023, 9, 25, 18),
      eventType: 'Sport Event'),
  TimelineData(
      title: "800m Race",
      location: 'Teslim Balogun Stadium',
      startTime: DateTime(2023, 9, 30, 16),
      endTime: DateTime(2023, 9, 30, 18),
      eventType: 'Sport Event'),
  TimelineData(
      title: "Techies hangout",
      location: 'Amusement Park, Abuja',
      startTime: DateTime(2023, 9, 20, 12),
      endTime: DateTime(2023, 9, 20, 18),
      eventType: 'Hangout'),
];

class TimelineScreen extends StatefulWidget {
  static const String routeName = "my_group";
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          12.height,
          Text(
            "Timeline",
            textAlign: TextAlign.center,
            style: context.headline3.copyWith(
              fontSize: 16,
            ),
          ),
          40.height,
          DefaultTabController(
            length: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  TabBar(
                    onTap: (value) {
                      currentIndex = value;
                      setState(() {});
                    },
                    indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide.none),
                    indicatorSize: TabBarIndicatorSize.label,
                    padding: EdgeInsets.zero,
                    labelPadding: const EdgeInsets.all(0),
                    tabs: [
                      CustomTab(
                        currentIndex: currentIndex,
                        title: 'Friends',
                        index: 0,
                      ),
                      CustomTab(
                        currentIndex: currentIndex,
                        title: 'Everyone',
                        index: 1,
                      ),
                    ],
                  ),
                  32.height,
                  SingleChildScrollView(
                    child: Column(
                        children: sampleData
                            .map((data) => TimelineCard(
                                title: data.title,
                                onTap: () {},
                                moreButtonFunction: () {},
                                eventType: data.eventType,
                                endTime: data.endTime,
                                startTime: data.startTime,
                                location: data.location,
                                iconString: data.eventType == 'Sport Event'
                                    ? AppImages.raceIcon
                                    : AppImages.hangoutIcon))
                            .toList()),
                  )
                ],
              ),
            ),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            BaseNavigator.pushNamed(AddEvent.routeName);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          elevation: 0.0,
          backgroundColor: AppColors.darkBlue1,
          extendedPadding:
              const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          label: Row(
            children: [
              const Icon(
                Icons.add,
                color: Colors.white,
              ),
              10.width,
              Text(
                "Add Event",
                style: context.button2.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
              )
            ],
          )),
    );
  }
}
