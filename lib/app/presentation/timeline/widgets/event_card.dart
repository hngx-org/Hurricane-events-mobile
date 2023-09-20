import 'package:flutter/material.dart';
import 'package:hurricane_events/app/presentation/timeline/screens/event_details.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/component/widgets/custom_button.dart';
import 'package:hurricane_events/data/models/events/event_mock_up.dart';
import 'package:intl/intl.dart';

class EventCard extends StatefulWidget {
  final EventsMockUp event;

  const EventCard({super.key, required this.event});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EventDetails(event: widget.event)));
            },
            child: Container(
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
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.event.groupName ?? 'Group Name',
                          style: context.body2.copyWith(
                            fontSize: 10,
                            color: AppColors.designOrange,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Builder(builder: (context) {
                          if (!widget.event.startDate!
                                  .difference(DateTime.now())
                                  .inDays
                                  .isNegative &&
                              widget.event.startDate!
                                      .difference(DateTime.now())
                                      .inDays >
                                  0) {
                            return Text(
                              "In ${widget.event.startDate!.difference(DateTime.now()).inDays} days",
                              style: context.body1.copyWith(
                                fontSize: 12,
                                color: AppColors.designBlack3,
                              ),
                            );
                          }
                          return Text(
                            widget.event.groupName ?? 'Group',
                            style: context.body1.copyWith(
                              fontSize: 12,
                              color: AppColors.designBlack3,
                            ),
                          );
                        }),
                        const SizedBox(height: 4),
                        Text(
                          widget.event.groupName ?? 'Group',
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
                                    " ${DateFormat("EEEE dd, MMM").format(widget.event.startDate!)}",
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
                                    " ${widget.event.startDateStartTime?.hour} - ${widget.event.startDateEndTime?.hour}${widget.event.startDateEndTime?.period.name.toUpperCase()}",
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
                                text: " ${widget.event.location}",
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
                  )
                ],
              ),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.message,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  "Leave a comment",
                  style: context.body2.copyWith(
                    fontSize: 12,
                    color: AppColors.designBlack1,
                  ),
                ),
                const Spacer(),
                CustomButton(
                  onPressed: () {},
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                  radius: 32,
                  backgroundColor: AppColors.lightBlue2,
                  buttonWidget: Row(
                    children: [
                      const Icon(
                        Icons.check,
                        color: AppColors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "RSVP",
                        style: context.headline2
                            .copyWith(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
