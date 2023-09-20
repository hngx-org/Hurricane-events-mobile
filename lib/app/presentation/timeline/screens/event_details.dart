import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hurricane_events/app/presentation/timeline/widgets/comment_tile.dart';
import 'package:hurricane_events/app/presentation/timeline/widgets/event_card.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/data/models/comment_model.dart';
import 'package:hurricane_events/data/models/events/event_mock_up.dart';

class EventDetails extends StatefulWidget {
  final EventsMockUp event;
  static const String routeName = "event_details";
  const EventDetails({super.key, required this.event});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  ScrollController scrollController = ScrollController();
// TODO: This should be in the provider somewhere...
//? From here
  List<CommentModel> comments = [
    CommentModel(
        avatar: 'avatar',
        fullName: 'Alpha Beta',
        comment: 'Test Comment 1',
        duration: '10 minutes'),
    CommentModel(
        fullName: 'Test User',
        comment: 'Test Comment 1',
        duration: '10 minutes'),
    CommentModel(
        fullName: 'Foxtrot Exho',
        comment: 'Test Comment 1',
        duration: '10 minutes',
        image:
            'https://miro.medium.com/v2/resize:fit:400/1*_6Dh7jYd1Rh4GjFymFUA8w.png')
  ];

  void postComment(String comment) {
    comments.add(CommentModel(
        fullName: 'Current user', comment: comment, duration: 'Now'));
    setState(() {});

    // Remove the keyboard focus after sending the comment.
    FocusScope.of(context).unfocus();

    Future.delayed(const Duration(milliseconds: 100), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
  //? To here

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  TextEditingController commentController = TextEditingController();
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
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
                    SizedBox(
                      height: 300,
                      child: ListView(
                        controller: scrollController,
                        children: List.generate(
                            comments.length,
                            (index) => CommentTile(
                                  comment: comments[index],
                                )),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ),
            // Gap(100),
            Container(
              alignment: Alignment.bottomCenter,
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
                  Flexible(
                      child: TextField(
                    controller: commentController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type your comment',
                        hintStyle: TextStyle(
                          color: AppColors.designBlack5,
                        )),
                  )),
                  InkWell(
                    onTap: () {
                      postComment(commentController.text);
                      commentController.clear();
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue,
                        ),
                        padding: const EdgeInsets.all(5),
                        child: SvgPicture.asset('assets/icons/icon_send.svg')),
                  ),
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
