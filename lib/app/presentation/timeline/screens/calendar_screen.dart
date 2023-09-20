import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hurricane_events/app/presentation/timeline/widgets/event_card.dart';

import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/data/models/events/event_mock_up.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarSection extends StatefulWidget {
  static const String routeName = "calender";
  const CalendarSection({super.key});

  @override
  State<CalendarSection> createState() => _CalendarState();
}

class _CalendarState extends State<CalendarSection> {
  DateTime _selectedDate = DateTime.parse("2023-09-19 00:00:00Z");

  List<EventsMockUp> dayEvents = [];

  List<EventsMockUp> dummyEvents = [
    EventsMockUp(
      name: "Hurricane Slack group meeting",
      groupName: "Hangouts",
      startDate: DateTime(2023, 9, 17),
      endDate: DateTime(2023, 10, 1, 12),
      startDateStartTime: const TimeOfDay(hour: 12, minute: 00),
      startDateEndTime: const TimeOfDay(hour: 12, minute: 00),
      endDateStartTime: const TimeOfDay(hour: 12, minute: 00),
      endDateEndTime: const TimeOfDay(hour: 12, minute: 00),
      location: "Slack",
    ),
    EventsMockUp(
      name: "Hurricane Slack meeting",
      groupName: "Hangouts",
      startDate: DateTime.now(),
      startDateStartTime: const TimeOfDay(hour: 12, minute: 00),
      startDateEndTime: const TimeOfDay(hour: 12, minute: 00),
      location: "Slack",
    ),
    EventsMockUp(
      name: "Football meeting",
      groupName: "Hangouts",
      startDate: DateTime(2023, 9, 16, 00, 00, 00),
      startDateStartTime: const TimeOfDay(hour: 12, minute: 00),
      startDateEndTime: const TimeOfDay(hour: 12, minute: 00),
      location: "Slack",
    ),
    EventsMockUp(
      name: "Yes meeting",
      groupName: "Hangouts",
      startDate: DateTime(2023, 9, 1, 00, 00, 00),
      startDateStartTime: const TimeOfDay(hour: 12, minute: 00),
      startDateEndTime: const TimeOfDay(hour: 12, minute: 00),
      location: "Slack",
    ),
    EventsMockUp(
      name: "No meeting",
      groupName: "Hangouts",
      startDate: DateTime(2023, 9, 30, 00, 00, 00),
      startDateStartTime: const TimeOfDay(hour: 12, minute: 00),
      startDateEndTime: const TimeOfDay(hour: 12, minute: 00),
      location: "Slack",
    ),
    EventsMockUp(
      name: "Submission Date",
      groupName: "Submission",
      startDate: DateTime(2023, 9, 22, 00, 00, 00),
      startDateStartTime: const TimeOfDay(hour: 12, minute: 00),
      startDateEndTime: const TimeOfDay(hour: 12, minute: 00),
      location: "Slack",
    ),
  ];

  Map<DateTime, List<EventsMockUp>> events = {
    DateTime.parse("2023-09-17 00:00:00Z"): [
      EventsMockUp(
        name: "Hurricane Slack group meeting",
        groupName: "Hangouts",
        startDate: DateTime.parse("2023-09-17 00:00:00Z"),
        endDate: DateTime(2023, 10, 1),
        startDateStartTime: const TimeOfDay(hour: 12, minute: 00),
        startDateEndTime: const TimeOfDay(hour: 12, minute: 00),
        endDateStartTime: const TimeOfDay(hour: 12, minute: 00),
        endDateEndTime: const TimeOfDay(hour: 12, minute: 00),
        location: "Slack",
      )
    ],
    DateTime.parse("2023-09-19 00:00:00Z"): [
      EventsMockUp(
        name: "Hurricane Slack meeting",
        groupName: "Hangouts",
        startDate: DateTime.parse("2023-09-19 00:00:00Z"),
        startDateStartTime: const TimeOfDay(hour: 12, minute: 00),
        startDateEndTime: const TimeOfDay(hour: 12, minute: 00),
        location: "Slack",
      ),
      EventsMockUp(
        name: "Hurricane group",
        groupName: "Hangouts",
        startDate: DateTime.parse("2023-09-19 00:00:00Z"),
        startDateStartTime: const TimeOfDay(hour: 12, minute: 00),
        startDateEndTime: const TimeOfDay(hour: 12, minute: 00),
        location: "Lagos, Nigeria",
      ),
      EventsMockUp(
        name: "Bayern vs Manchester United",
        groupName: "Champions League",
        startDate: DateTime.parse("2023-09-20 00:00:00Z"),
        startDateStartTime: const TimeOfDay(hour: 20, minute: 00),
        startDateEndTime: const TimeOfDay(hour: 22, minute: 00),
        location: "Lagos, Nigeria",
      ),
    ],
    DateTime.parse("2023-09-16 00:00:00Z"): [
      EventsMockUp(
        name: "Football meeting",
        groupName: "Hangouts",
        startDate: DateTime.parse("2023-09-16 00:00:00Z"),
        startDateStartTime: const TimeOfDay(hour: 12, minute: 00),
        startDateEndTime: const TimeOfDay(hour: 12, minute: 00),
        location: "Slack",
      )
    ],
    DateTime.parse("2023-09-01 00:00:00Z"): [
      EventsMockUp(
        name: "Yes meeting",
        groupName: "Hangouts",
        startDate: DateTime.parse("2023-09-01 00:00:00Z"),
        startDateStartTime: const TimeOfDay(hour: 12, minute: 00),
        startDateEndTime: const TimeOfDay(hour: 12, minute: 00),
        location: "Slack",
      )
    ],
    DateTime.parse("2023-09-30 00:00:00Z"): [
      EventsMockUp(
        name: "No meeting",
        groupName: "Hangouts",
        startDate: DateTime.parse("2023-09-30 00:00:00Z"),
        startDateStartTime: const TimeOfDay(hour: 12, minute: 00),
        startDateEndTime: const TimeOfDay(hour: 12, minute: 00),
        location: "Slack",
      )
    ],
    DateTime.parse("2023-09-22 00:00:00Z"): [
      EventsMockUp(
        name: "Submission Date",
        groupName: "Submission",
        startDate: DateTime.parse("2023-09-22 00:00:00Z"),
        startDateStartTime: const TimeOfDay(hour: 12, minute: 00),
        startDateEndTime: const TimeOfDay(hour: 12, minute: 00),
        location: "Slack",
      )
    ]
  };

  @override
  void initState() {
    super.initState();
    _getEventsForDay(_selectedDate);
  }

  List<EventsMockUp> _getEventsForDay(DateTime day) {
    final s = events[day] ?? [];
    return s;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              Text(
                "Calendar",
                textAlign: TextAlign.center,
                style: context.headline3.copyWith(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TableCalendar(
                  eventLoader: _getEventsForDay,
                  focusedDay: _selectedDate,
                  currentDay: DateTime.now(),
                  firstDay: DateTime(1996),
                  lastDay: DateTime(2100),
                  calendarStyle: CalendarStyle(
                    markerDecoration: const BoxDecoration(
                      color: AppColors.darkBlue1,
                      shape: BoxShape.circle,
                    ),
                    canMarkersOverflow: false,
                    markerSize: 6,
                    markerMargin: const EdgeInsets.symmetric(horizontal: 1),
                    markersAnchor: 0,
                    markersAlignment: Alignment.bottomCenter,
                    markersMaxCount: 5,
                    weekendTextStyle: context.body1.copyWith(
                      fontSize: 14,
                      color: AppColors.designBlack4,
                      height: 0.12,
                    ),
                    todayDecoration: const BoxDecoration(
                      color: AppColors.lightBlue2,
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: context.body1.copyWith(
                      fontSize: 14,
                      color: AppColors.white,
                      height: 0.12,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: AppColors.darkBlue1,
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: context.body1.copyWith(
                      fontSize: 14,
                      color: AppColors.white,
                      height: 0.12,
                    ),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: context.body2.copyWith(
                      fontSize: 14,
                      color: AppColors.designBlack5,
                    ),
                    weekendStyle: context.body2.copyWith(
                      fontSize: 14,
                      color: AppColors.designBlack5,
                    ),
                  ),
                  selectedDayPredicate: (day) {
                    return (isSameDay(_selectedDate, day));
                  },
                  onPageChanged: (focusedDay) {
                    setState(() {
                      _selectedDate = focusedDay;
                    });
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDate, selectedDay)) {
                      setState(() {
                        _selectedDate = selectedDay;
                      });
                      _getEventsForDay(selectedDay);
                    }
                  },
                  headerStyle: HeaderStyle(
                    headerMargin: EdgeInsets.zero,
                    headerPadding: const EdgeInsets.symmetric(vertical: 8),
                    titleCentered: true,
                    formatButtonVisible: false,
                    titleTextStyle: context.headline3.copyWith(
                      fontSize: 16,
                    ),
                    leftChevronMargin: const EdgeInsets.only(left: 0),
                    rightChevronMargin: const EdgeInsets.only(right: 0),
                    leftChevronIcon: const Icon(
                      Icons.chevron_left_rounded,
                      color: AppColors.darkBlue1,
                      size: 24,
                    ),
                    rightChevronIcon: const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.darkBlue1,
                      size: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                DateFormat.yMMMM().format(_selectedDate),
                style: context.headline3.copyWith(
                  fontSize: 16,
                  color: AppColors.designBlack1,
                ),
              ),
              const SizedBox(height: 12),
              Builder(builder: (context) {
                if (_getEventsForDay(_selectedDate).isEmpty) {
                  return const SizedBox.shrink();
                }

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.opacityOrange,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            "${_getEventsForDay(_selectedDate).length} Events remaining",
                            textAlign: TextAlign.left,
                            style: context.body2.copyWith(
                              color: AppColors.designOrange,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                );
              }),
              Expanded(
                child: Builder(builder: (context) {
                  if (_getEventsForDay(_selectedDate).isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.free_cancellation_rounded,
                          size: 100,
                          color: AppColors.designBlack1,
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            "There are no events for this selected date",
                            textAlign: TextAlign.center,
                            style: context.body1.copyWith(
                              color: AppColors.designBlack1,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),
                      ],
                    );
                  }
                  return GroupedListView<EventsMockUp, String>(
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    elements: _getEventsForDay(_selectedDate),
                    groupBy: (element) => element.startDate!.toIso8601String(),
                    itemComparator: (item1, item2) =>
                        item2.startDate!.compareTo(item1.startDate!),
                    groupComparator: (value1, value2) =>
                        value2.compareTo(value1),
                    order: GroupedListOrder.DESC,
                    useStickyGroupSeparators: false,
                    groupSeparatorBuilder: (value) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Builder(builder: (context) {
                            if (DateTime.parse(value).month ==
                                    DateTime.now().month &&
                                DateTime.parse(value).day ==
                                    DateTime.now().day) {
                              return Text(
                                "Today",
                                style: context.body2.copyWith(
                                  fontSize: 12,
                                  color: AppColors.designBlack3,
                                ),
                              );
                            }
                            return Text(
                              DateFormat("EEEE dd, MMM")
                                  .format(DateTime.parse(value)),
                              style: context.body2.copyWith(
                                fontSize: 12,
                                color: AppColors.designBlack3,
                              ),
                            );
                          }),
                          const SizedBox(height: 12)
                        ],
                      );
                    },
                    itemBuilder: (context, EventsMockUp element) {
                      return EventCard(
                        event: element,
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
