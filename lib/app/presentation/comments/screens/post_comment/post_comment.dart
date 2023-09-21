import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hurricane_events/app/presentation/comments/screens/post_comment/widgets/comment_type.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/data/models/events/event_mock_up.dart';

import '../../../../../component/widgets/event_card.dart';
import 'widgets/post.dart';

final sampleEvent = EventsMockUp(
  name: "Hurricane Slack meeting",
  groupName: "Hangouts",
  startDate: DateTime.now(),
  startDateStartTime: const TimeOfDay(hour: 12, minute: 00),
  startDateEndTime: const TimeOfDay(hour: 12, minute: 00),
  location: "Slack",
);

class PostCommentEventDetails extends StatefulWidget {
  const PostCommentEventDetails({Key? key}) : super(key: key);

  @override
  State<PostCommentEventDetails> createState() =>
      _PostCommentEventDetailsState();
  static const String routeName = "post_comments";
}

class _PostCommentEventDetailsState extends State<PostCommentEventDetails> {
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
            const Flexible(
                child: TextField(
              //controller: commentController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type your comment',
                  hintStyle: TextStyle(
                    color: AppColors.designBlack5,
                  )),
            )),
            InkWell(
              onTap: () {
                // postComment(commentController.text);
                // commentController.clear();
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            40.height,
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
      ),
      backgroundColor: Colors.white,
    );
  }
}
