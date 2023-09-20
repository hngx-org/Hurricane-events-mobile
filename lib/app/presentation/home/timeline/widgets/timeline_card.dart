import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:intl/intl.dart';
import '../../../../../../component/constants/color.dart';

class TimelineCard extends StatelessWidget {
  const TimelineCard({
    super.key,
    required this.title,
    required this.onTap,
    required this.eventType,
    required this.endTime,
    required this.startTime,
    required this.location,
    required this.moreButtonFunction,
    required this.iconString
  });
  final String title;
  final String eventType;
  final VoidCallback onTap;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final VoidCallback moreButtonFunction;
  final String iconString;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        padding: const EdgeInsets.all(12),
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
                    iconString,
                    height: 56,
                    color: AppColors.darkBlue1,
                  ),
                ),
                16.width,
                Column( // expanded was here
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventType,
                      style: context.body2.copyWith(
                        fontSize: 10,
                        color: AppColors.designOrange,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      calculateTimeStatus(startTime, endTime)[0],
                      style: context.body1.copyWith(
                        fontSize: 12,
                        color: calculateTimeStatus(startTime, endTime)[1]
                            ? AppColors.darkBlue2
                            : AppColors.designBlack3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title,
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
                            text: " ${DateFormat("EEEE dd, MMM").format(startTime)}",
                            style: context.body2.copyWith(
                              fontSize: 11,
                              color: AppColors.designBlack1,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Time",
                            style: context.body2.copyWith(
                              fontSize: 11,
                              color: AppColors.designBlack2,
                            ),
                          ),
                          TextSpan(
                            text: " ${hourFormatter(startTime)} - ${hourFormatter(endTime)}${getAmOrPm(endTime)}",
                            style: context.body2.copyWith(
                              fontSize: 11,
                              color: AppColors.designBlack1,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Location",
                            style: context.body2.copyWith(
                              fontSize: 11,
                              color: AppColors.designBlack2,
                            ),
                          ),
                          TextSpan(
                            text: " $location",
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
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.more_vert, color: AppColors.darkGrey,),
                      onPressed: moreButtonFunction,
                    ),
                  ),
                )
              ],
            ),
            const Divider()
          ],
        ),
      ),
    );
  }

  List calculateTimeStatus(DateTime startDateTime, DateTime endDateTime) {
    DateTime now = DateTime.now();
    String statusString = '';
    bool isHappeningNow = false;

    // Check if the event is happening now
    if (startDateTime.isBefore(now) && endDateTime.isAfter(now)) {
      statusString =  "LIVE";
      isHappeningNow = true;
    } else if (startDateTime.isAfter(now)) {
      // Calculate the time difference
      Duration difference = startDateTime.difference(now);

      if (difference.inDays >= 7) {
        // More than 1 week in the future
        statusString =  "In ${difference.inDays~/7} week(s)";
      } else if (difference.inDays >= 1) {
        // 1 day to 1 week in the future
        statusString =  "In ${difference.inDays} day(s)";
      } else if (difference.inHours >= 1) {
        // Less than 1 day but more than 1 hour in the future
        statusString =  "In ${difference.inHours} hour(s)";
      } else {
        // Less than 1 hour in the future
        statusString =  "In ${difference.inMinutes} minute(s)";
      }
    } else {
      // The event has already ended
      statusString =  "Event Ended";
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
  int hourFormatter(DateTime time){
    int hour = time.hour;
    return (hour % 12 == 0) ? 12 : hour % 12;
  }

}