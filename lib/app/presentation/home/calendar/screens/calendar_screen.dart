import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hurricane_events/app/presentation/comments/screens/event_details.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/component/widgets/click_button.dart';
import 'package:hurricane_events/component/widgets/event_card.dart';
import 'package:hurricane_events/data/models/events/events_full_model.dart';
import 'package:hurricane_events/domain/providers/events_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../router/base_navigator.dart';

class CalendarSection extends StatefulWidget {
  static const String routeName = "calender";
  const CalendarSection({super.key});

  @override
  State<CalendarSection> createState() => _CalendarState();
}

class _CalendarState extends State<CalendarSection> {
  DateTime _selectedDate = DateTime.parse("${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).toIso8601String()}Z");

  @override
  void initState() {
    super.initState();
  }

  List<EventFull> _getEventsForDay(DateTime day) {
    final s = context.read<EventProvider>().userEventsCalendar[day] ?? [];
    return s;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Consumer<EventProvider>(builder: (context, event, _) {
        return SafeArea(
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
                const SizedBox(height: 24),
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
                              style: context.body1.copyWith(
                                color: Colors.deepOrange,
                                fontSize: 13,
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
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.free_cancellation_rounded,
                                  size: 80,
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
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    return GroupedListView<EventFull, String>(
                      physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      elements: _getEventsForDay(_selectedDate),
                      groupBy: (element) => element.startDate!.toIso8601String(),
                      itemComparator: (item1, item2) => item2.startDate!.compareTo(item1.startDate!),
                      groupComparator: (value1, value2) => value2.compareTo(value1),
                      order: GroupedListOrder.DESC,
                      useStickyGroupSeparators: false,
                      groupSeparatorBuilder: (value) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Builder(builder: (context) {
                              if (DateTime.parse(value).month == DateTime.now().month && DateTime.parse(value).day == DateTime.now().day) {
                                return Text(
                                  "Today",
                                  style: context.body2.copyWith(
                                    fontSize: 12,
                                    color: AppColors.designBlack3,
                                  ),
                                );
                              }
                              return Text(
                                DateFormat("EEEE dd, MMM").format(DateTime.parse(value)),
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
                      itemBuilder: (context, EventFull element) {
                        return ClickWidget(
                          onTap: () {
                            BaseNavigator.pushNamed(
                              PreCommentEventDetails.routeName,
                              args: element.id,
                            );
                          },
                          child: EventCard(
                            eventFull: element,
                          ),
                        );
                        // return TimelineCard(
                        //   onTap: () {
                        //     BaseNavigator.pushNamed(
                        //       PreCommentEventDetails.routeName,
                        //       args: element.id,
                        //     );
                        //   },
                        //   moreButtonFunction: () {},
                        //   event: element,
                        // );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
