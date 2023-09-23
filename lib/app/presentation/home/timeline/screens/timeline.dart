import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hurricane_events/app/presentation/add_event/screens/add_event.dart';
import 'package:hurricane_events/app/presentation/comments/screens/event_details.dart';
import 'package:hurricane_events/app/presentation/home/timeline/widgets/custom_tab_widget.dart';

import 'package:hurricane_events/app/router/base_navigator.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/enums/enums.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/component/widgets/shimmer/timeline_shimmer.dart';
import 'package:hurricane_events/data/models/events/event_normal.dart';
import 'package:hurricane_events/domain/providers/events_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/timeline_card.dart';

class TimelineScreen extends StatefulWidget {
  static const String routeName = "my_group";
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> with TickerProviderStateMixin {
  int currentIndex = 0;

  late TabController controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(
      length: 2,
      vsync: this,
    );

    controller.addListener(() {
      if (!controller.indexIsChanging) {
        setState(() {
          currentIndex = controller.index;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Consumer<EventProvider>(
        builder: (context, events, _) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
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
                  24.height,
                  DefaultTabController(
                    length: 2,
                    child: TabBar(
                      controller: controller,
                      onTap: (value) {
                        currentIndex = value;
                        setState(() {});
                      },
                      indicator: const UnderlineTabIndicator(borderSide: BorderSide.none),
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
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: controller,
                      children: [
                        Builder(builder: (context) {
                          if (events.timelineState == AppState.loading) {
                            return const Padding(
                              padding: EdgeInsets.only(top: 26),
                              child: TimelineShimmer(),
                            );
                          }

                          return GroupedListView<EventNorm, String>(
                            physics: const ClampingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            elements: events.events,
                            groupBy: (element) => element.startDate!.toIso8601String(),
                            itemComparator: (item1, item2) => item2.startDate!.compareTo(item1.startDate!),
                            groupComparator: (value1, value2) => value2.compareTo(value1),
                            order: GroupedListOrder.DESC,
                            useStickyGroupSeparators: false,
                            groupSeparatorBuilder: (value) {
                              return 16.height;
                            },
                            itemBuilder: (context, EventNorm element) {
                              return TimelineCard(
                                onTap: () {
                                  BaseNavigator.pushNamed(
                                    PreCommentEventDetails.routeName,
                                    args: element.id,
                                  );
                                },
                                moreButtonFunction: () {},
                                event: element,
                              );
                            },
                          );
                        }),
                        Container(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await BaseNavigator.pushNamed(AddEvent.routeName);

            if (!mounted) return;

            context.read<EventProvider>().refreshEvents();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          elevation: 0.0,
          backgroundColor: AppColors.darkBlue1,
          extendedPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
