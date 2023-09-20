import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/utils/extensions.dart';

import '../timeline/widgets/event_card.dart';
import 'component/post.dart';

class PostComment extends StatefulWidget {
  const PostComment({Key? key}) : super(key: key);

  @override
  State<PostComment> createState() => _PostCommentState();
  static const String routeName = "post_comments";

}

class _PostCommentState extends State<PostComment> {

  String selectedCommentType = "Pre-events comments"; // Initially no commentType is selected

  List<dynamic> postEvent = [
    Post(comment: 'Wahala fon come', name: "Unknown"),
    Post(comment: 'Wahala fon come', name: "Unknown"),
    Post(comment: 'Wahala fon come', name: "Unknown"),
    Post(comment: 'Wahala fon come', name: "Unknown"),
    Post(comment: 'Wahala fon come', name: "Unknown"),
  ];
  List<dynamic> preEvent = [
    Post(comment: 'Wahala fon come', name: "Unknown"),
    Post(comment: 'Wahala fon come', name: "Unknown"),
    Post(comment: 'Wahala fon come', name: "Unknown"),
  ];

  void selectCommentType(String commentType) {
    setState(() {
      selectedCommentType = commentType;
    });
  }

  final TextEditingController comment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,

      child: Scaffold(
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.designBlack9,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(right: 5),
                child: SvgPicture.asset("assets/icons/icon_camera.svg"),
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                  width: 0.2,
                  color: AppColors.designBlack1,
                ))),
              ),
              Expanded(
                child: TextField(
                  controller: comment,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type your comment",
                      contentPadding: EdgeInsets.all(5.0),
                      // enabledBorder: ,
                      hintStyle: context.body3.copyWith(
                        color: AppColors.designBlack2,
                      )),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(left: 5),
                child: SvgPicture.asset("assets/icons/icon_arrow_left.svg"),
                decoration: BoxDecoration(
                  color: AppColors.lightBlue1,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            EventCard(
                group: "test",
                startDate: DateTime.now(),
                name: "test",
                location: "test"),
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
      ),
    );
  }
}

class CommentType extends StatelessWidget {
  final String commentType;
  final bool isSelected;
  final VoidCallback onTap;

  CommentType({
    required this.commentType,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lightBlue2 : Colors.transparent,
          border: isSelected
              ? Border(
                  top: BorderSide(
                    width: 2,
                    color: AppColors.designBlack3,
                  ),
                  bottom: BorderSide(
                    width: 2,
                    color: AppColors.designBlack3,
                  ),
                )
              : Border.all(width: 0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              commentType,
              style: context.body3.copyWith(
                color: isSelected ? AppColors.designBlack1 : Colors.black,
                fontSize: 18,
              ),
            ),
            SvgPicture.asset(
              isSelected?"assets/icons/icon_drop_down.svg":"assets/icons/icon_forward_arrow.svg",
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
