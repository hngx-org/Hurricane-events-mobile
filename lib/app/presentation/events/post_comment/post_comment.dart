import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hurricane_events/app/presentation/events/post_comment/widgets/comment_type.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/data/models/events/event_mock_up.dart';

import '../../home/calendar/widgets/event_card.dart';
import 'widgets/post.dart';

final sampleEvent = EventsMockUp(
  name: "Hurricane Slack meeting",
  groupName: "Hangouts",
  startDate: DateTime.now(),
  startDateStartTime: const TimeOfDay(hour: 12, minute: 00),
  startDateEndTime: const TimeOfDay(hour: 12, minute: 00),
  location: "Slack",
);

class PostComment extends StatefulWidget {
  const PostComment({Key? key}) : super(key: key);

  @override
  State<PostComment> createState() => _PostCommentState();
  static const String routeName = "post_comments";
}

class _PostCommentState extends State<PostComment> {
  String selectedCommentType =
      "Pre-events comments"; // Initially no commentType is selected

  List<dynamic> postEvent = [
    const Post(comment: 'Wahala fon come', name: "Unknown"),
    const Post(comment: 'Wahala fon come', name: "Unknown"),
    const Post(comment: 'Wahala fon come', name: "Unknown"),
    const Post(comment: 'Wahala fon come', name: "Unknown"),
    const Post(comment: 'Wahala fon come', name: "Unknown"),
  ];
  List<dynamic> preEvent = [
    const Post(comment: 'Wahala fon come', name: "Unknown"),
    const Post(comment: 'Wahala fon come', name: "Unknown"),
    const Post(comment: 'Wahala fon come', name: "Unknown"),
  ];

  void selectCommentType(String commentType) {
    setState(() {
      selectedCommentType = commentType;
    });
  }

  final TextEditingController comment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: Padding(
          padding: const EdgeInsets.all(20),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          color: AppColors.designBlack9,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(right: 5),
                decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(
                  width: 0.2,
                  color: AppColors.designBlack1,
                ))),
                child: SvgPicture.asset("assets/icons/icon_camera.svg"),
              ),
              Expanded(
                child: TextField(
                  controller: comment,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type your comment",
                      contentPadding: const EdgeInsets.all(5.0),
                      // enabledBorder: ,
                      hintStyle: context.body3.copyWith(
                        color: AppColors.designBlack2,
                      )),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  color: AppColors.lightBlue1,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SvgPicture.asset("assets/icons/icon_arrow_left.svg"),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          EventCard(
            event: sampleEvent,
          ),
          CommentType(
            commentType: "Pre-events comments",
            isSelected: selectedCommentType == "Pre-events comments",
            onTap: () => selectCommentType("Pre-events comments"),
          ),
          CommentType(
            commentType: "Post-events comments",
            isSelected: selectedCommentType == "Post-events comments",
            onTap: () => selectCommentType("Post-events comments"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: selectedCommentType == "Pre-events comments"
                  ? preEvent.length
                  : postEvent.length,
              itemBuilder: (context, index) {
                return selectedCommentType == "Pre-events comments"
                    ? preEvent[index]
                    : postEvent[index];
              },
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
