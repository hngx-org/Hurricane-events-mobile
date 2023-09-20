import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hurricane_events/app/presentation/timeline/widgets/comment_tile.dart';
import 'package:hurricane_events/app/presentation/timeline/widgets/event_card.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/data/models/events/event_mock_up.dart';

class EventDetails extends StatefulWidget {
  final EventsMockUp event;
  static const String routeName = "event_details";
  const EventDetails({super.key, required this.event});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding:
            const EdgeInsets.only(left: 36.0, right: 36.0, top: 56, bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                        )),
                    const Text('Event',
                        style: TextStyle(
                          color: AppColors.designBlack1,
                          fontSize: 16,
                        )),
                    const SizedBox()
                  ],
                ),
                const Gap(42.5),
                EventCard(
                  event: widget.event,
                ),
                const Gap(20),
                SingleChildScrollView(
                  child: Column(
                    children: List.generate(2, (index) => const CommentTile()),
                  ),
                ),
                const Divider(),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.textFieldBackground,
                  borderRadius: BorderRadius.circular(5)),
              width: double.infinity,
              height: 40,
              child: Row(
                children: [
                  const Gap(10),
                  const Icon(Icons.camera_alt),
                  const Gap(10),
                  const VerticalDivider(),
                  const Gap(10),
                  const Flexible(
                      child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type your comment',
                        hintStyle: TextStyle(
                          color: AppColors.designBlack5,
                        )),
                  )),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue,
                      ),
                      padding: const EdgeInsets.all(5),
                      child: SvgPicture.asset('assets/icons/icon_send.svg')),
                  const Gap(10)
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
