import 'package:flutter/material.dart';
import 'package:hurricane_events/app/presentation/home/calendar/widgets/stacked_images.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/constants/images.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/component/widgets/click_button.dart';
import 'package:hurricane_events/component/widgets/custom_button.dart';
import 'package:hurricane_events/component/widgets/svg_picture.dart';
import 'package:hurricane_events/data/models/comments/comment.dart';
import 'package:hurricane_events/data/models/events/events_full_model.dart';
import 'package:hurricane_events/domain/providers/events_provider.dart';
import 'package:hurricane_events/domain/providers/global_provider.dart';
import 'package:hurricane_events/domain/providers/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventCard extends StatefulWidget {
  final EventFull? eventFull;
  final List<Comment>? comments;

  const EventCard({
    super.key,
    this.eventFull,
    this.comments,
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  DateTime nowDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserProvider>(context).user?.id;
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: const BoxDecoration(
              color: AppColors.white,
              border: Border(
                top: BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                bottom: BorderSide(width: 1, color: Color(0xFFD9D9D9)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 76,
                  width: 76,
                  decoration: BoxDecoration(
                    color: AppColors.lightBlue1,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.all(14),
                  child: const Svg(
                    image: AppImages.hangoutIcon,
                    color: AppColors.darkBlue1,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hangouts',
                        style: context.body1.copyWith(
                          fontSize: 12,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Builder(builder: (context) {
                        return Text(
                          calculateTimeStatus(widget.eventFull!.startDate!)[0],
                          style: context.body1.copyWith(
                            fontSize: 13,
                            color: AppColors.designBlack3,
                          ),
                        );
                      }),
                      const SizedBox(height: 4),
                      Text(
                        widget.eventFull?.title ?? 'Group',
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
                              text: " ${DateFormat("EEEE dd, MMM").format(widget.eventFull!.startDate!)}",
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
                              text:
                                  " ${parseTimeOfDay(widget.eventFull!.startTime!).hour}:${parseTimeOfDay(widget.eventFull!.startTime!).minute}${parseTimeOfDay(widget.eventFull!.startTime!).period.name.toUpperCase()} - ${parseTimeOfDay(widget.eventFull!.endTime!).hour}:${parseTimeOfDay(widget.eventFull!.endTime!).minute}${parseTimeOfDay(widget.eventFull!.endTime!).period.name.toUpperCase()}",
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
                              text: " ${widget.eventFull?.location}",
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
                ClickWidget(
                  onTap: () {},
                  child: const Icon(
                    Icons.more_vert,
                    size: 20,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            decoration: const BoxDecoration(
              color: AppColors.white,
              border: Border(
                bottom: BorderSide(width: 1, color: Color(0xFFD9D9D9)),
              ),
            ),
            child: Builder(builder: (context) {
              if (widget.comments != null && widget.comments!.isNotEmpty) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const StackedImages(
                      numOfAvatars: 3,
                    ),
                    4.width,
                    Text(
                      "${widget.comments?.length} ${widget.comments?.length == 1 ? 'comment' : 'comments'}",
                      style: context.body2.copyWith(
                        fontSize: 12,
                        color: AppColors.designBlack1,
                      ),
                    ),
                    const Spacer(),
                    Builder(builder: (context) {
                      if (widget.eventFull?.endDate != null) {
                        if (widget.eventFull!.endDate!.difference(nowDate).inDays.isNegative) {
                          return const CustomButton(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                            radius: 32,
                            backgroundColor: AppColors.designGrey,
                            buttonText: "EVENT ENDED",
                          );
                        }
                      }
                      // else {
                      //   if (widget.eventFull!.startDate!
                      //       .difference(nowDate)
                      //       .inDays
                      //       .isNegative) {
                      //     return const CustomButton(
                      //       padding: EdgeInsets.symmetric(
                      //           vertical: 8, horizontal: 32),
                      //       radius: 32,
                      //       backgroundColor: AppColors.designGrey,
                      //       buttonText: "EVENT ENDED",
                      //     );
                      //   }
                      // }
                      return RSVPButton(
                        userId: userId!,
                        eventId: widget.eventFull!.id!,
                      );
                    })
                  ],
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Svg(image: AppImages.commentIcon),
                  const SizedBox(width: 4),
                  Text(
                    "Leave a comment",
                    style: context.body2.copyWith(
                      fontSize: 12,
                      color: AppColors.designBlack1,
                    ),
                  ),
                  const Spacer(),
                  Builder(builder: (context) {
                    if (widget.eventFull?.endDate != null) {
                      if (widget.eventFull!.endDate!.difference(nowDate).inDays.isNegative) {
                        return const CustomButton(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                          radius: 32,
                          backgroundColor: AppColors.designGrey,
                          buttonText: "EVENT ENDED",
                        );
                      }
                    } else {
                      if (widget.eventFull!.startDate!.difference(nowDate).inDays.isNegative) {
                        return const CustomButton(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                          radius: 32,
                          backgroundColor: AppColors.designGrey,
                          buttonText: "EVENT ENDED",
                        );
                      }
                    }
                    return RSVPButton(userId: userId!, eventId: widget.eventFull!.id!);
                  })
                ],
              );
            }),
          )
        ],
      ),
    );
  }

  TimeOfDay parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    if (parts.length == 3) {
      final hour = int.tryParse(parts[0]);
      final minute = int.tryParse(parts[1]);

      if (hour != null && minute != null) {
        return TimeOfDay(hour: hour, minute: minute);
      }
    }

    // Handle invalid input here or return a default value if needed
    throw FormatException("Invalid time format: $timeString");
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
}

class RSVPButton extends StatefulWidget {
  const RSVPButton({
    super.key,
    required this.userId,
    required this.eventId,
  });

  final String userId;
  final String eventId;

  @override
  State<RSVPButton> createState() => _RSVPButtonState();
}

class _RSVPButtonState extends State<RSVPButton> {
  bool interested = false;

  checkForInterest() {
    final event = GlobalProvider.instance.userEvents.where((element) => element!.id == widget.eventId).isNotEmpty;
    if (event) {
      setState(() {
        interested = true;
      });
    }
  }

  @override
  void didChangeDependencies() {
    checkForInterest();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(builder: (context, eventProvider, child) {
      return CustomButton(
        onPressed: () async {
          if (interested) {
            final deletedInterest = await eventProvider.deleteInterest(
              widget.userId,
              widget.eventId,
            );

            setState(() {
              interested = !deletedInterest;
            });
          } else {
            final expressedInterest = await eventProvider.expressInterest(
              widget.userId,
              widget.eventId,
            );

            setState(() {
              interested = expressedInterest;
            });
          }
        },
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
        radius: 32,
        backgroundColor: interested ? AppColors.lightBlue2 : AppColors.darkBlue1,
        buttonWidget: Row(
          children: [
            interested
                ? Builder(builder: (context) {
                    return const Icon(
                      Icons.check,
                      color: AppColors.white,
                      size: 20,
                    );
                  })
                : const SizedBox(),
            const SizedBox(width: 10),
            Text(
              "RSVP",
              style: context.headline2.copyWith(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    });
  }
}
