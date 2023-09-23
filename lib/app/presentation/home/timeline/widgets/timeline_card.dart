// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hurricane_events/component/constants/images.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/component/widgets/click_button.dart';
import 'package:hurricane_events/data/models/events/event_normal.dart';
import 'package:hurricane_events/domain/providers/events_provider.dart';
import 'package:hurricane_events/domain/providers/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../../../component/constants/color.dart';

class TimelineCard extends StatelessWidget {
  const TimelineCard({
    super.key,
    required this.onTap,
    required this.moreButtonFunction,
    required this.event,
  });

  final EventNorm event;
  final VoidCallback onTap;
  final VoidCallback moreButtonFunction;

  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(
      builder: (context, provider, _) {
        return Dismissible(
          background: Container(
            color: AppColors.designRed, // Set the background color
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          key: UniqueKey(),
          onDismissed: (direction) async {
            await provider.deleteEvent(
              eventId: event.id!,
            );
          },
          confirmDismiss: (direction) async {
            if (context.read<UserProvider>().user?.id != event.creatorId) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Access Denied'),
                backgroundColor: AppColors.designRed,
                duration: Duration(seconds: 1),
              ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Deleting Event'),
                duration: Duration(seconds: 1),
                backgroundColor: AppColors.darkBlue1,
              ));
            }
            return context.read<UserProvider>().user?.id == event.creatorId;
          },
          child: ClickWidget(
            onTap: onTap,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: ShapeDecoration(
                          color: AppColors.lightBlue1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: SvgPicture.asset(
                          AppImages.hangoutIcon,
                          height: 56,
                          color: AppColors.darkBlue2,
                        ),
                      ),
                      16.width,
                      Expanded(
                        child: Column(
                          // expanded was here
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event.description ?? "",
                              style: context.body2.copyWith(
                                fontSize: 10,
                                color: AppColors.designOrange,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Builder(
                                  builder: (context) {
                                    if (calculateTimeStatus(
                                              event.startDate!,
                                            )[0]
                                                .toString()
                                                .toLowerCase() ==
                                            "live" ||
                                        calculateTimeStatus(
                                              event.startDate!,
                                            )[0]
                                                .toString()
                                                .toLowerCase() ==
                                            "happening today") {
                                      return Row(
                                        children: [
                                          Container(
                                            height: 6,
                                            width: 6,
                                            decoration: const BoxDecoration(
                                              color: AppColors.designOrange,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          5.width,
                                        ],
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  },
                                ),
                                Text(
                                  calculateTimeStatus(
                                    event.startDate!,
                                  )[0],
                                  style: context.body1.copyWith(
                                    fontSize: 12,
                                    color:
                                        calculateTimeStatus(event.startDate!)[1]
                                            ? AppColors.darkBlue2
                                            : AppColors.designBlack3,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              event.title ?? "",
                              style: context.body1.copyWith(
                                fontSize: 23,
                                color: AppColors.designBlack1,
                              ),
                            ),
                            const SizedBox(height: 8),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Date",
                                    style: context.body2.copyWith(
                                      fontSize: 11,
                                      color: AppColors.designBlack2,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        " ${DateFormat("EEEE dd, MMM").format(event.startDate ?? DateTime.now())}",
                                    style: context.body2.copyWith(
                                      fontSize: 11,
                                      color: AppColors.designBlack1,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(
                            Icons.more_vert,
                            color: AppColors.designBlack1,
                            size: 16,
                          ),
                          onPressed: moreButtonFunction,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List calculateTimeStatus(
    DateTime startDateTime,
  ) {
    DateTime now = DateTime.now();
    String statusString = '';
    bool isHappeningNow = false;

    // Check if the event is happening now
    if (startDateTime.difference(now).inDays.isNegative) {
      statusString = "LIVE";
      isHappeningNow = true;
    } else if (startDateTime.isAfter(now)) {
      // Calculate the time difference
      Duration difference = startDateTime.difference(now);

      if (difference.inDays >= 7) {
        // More than 1 week in the future
        statusString = "In ${difference.inDays ~/ 7} week(s)";
      } else if (difference.inDays >= 1) {
        // 1 day to 1 week in the future
        statusString = "In ${difference.inDays} day(s)";
      } else if (difference.inHours >= 1) {
        // Less than 1 day but more than 1 hour in the future
        statusString = "In ${difference.inHours} hour(s)";
      } else {
        // Less than 1 hour in the future
        statusString = "In ${difference.inMinutes} minute(s)";
      }
    } else if (startDateTime.difference(now).inDays == 0) {
      statusString = "Happening Today";
      isHappeningNow = true;
    } else {
      // The event has already ended
      statusString = "Event Ended";
    }
    return [statusString, isHappeningNow];
  }

  String getAmOrPm(DateTime dateTime) {
    if (dateTime.hour < 12) {
      return "AM";
    } else {
      return "PM";
    }
  }

  int hourFormatter(DateTime time) {
    int hour = time.hour;
    return (hour % 12 == 0) ? 12 : hour % 12;
  }
}
