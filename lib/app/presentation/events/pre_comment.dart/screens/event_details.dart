import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hurricane_events/app/presentation/home/calendar/widgets/comment_tile.dart';
import 'package:hurricane_events/app/router/base_navigator.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/component/widgets/click_button.dart';
import 'package:hurricane_events/component/widgets/event_card.dart';
import 'package:hurricane_events/data/models/comment_model.dart';
import 'package:hurricane_events/data/models/events/event_mock_up.dart';

class PreCommentEventDetails extends StatefulWidget {
  final EventsMockUp event;
  static const String routeName = "pre_comment";
  const PreCommentEventDetails({
    super.key,
    required this.event,
  });

  @override
  State<PreCommentEventDetails> createState() => _PreCommentEventDetailsState();
}

class _PreCommentEventDetailsState extends State<PreCommentEventDetails> {
  ScrollController scrollController = ScrollController();
// TODO: This should be in the provider somewhere...
//? From here
  List<CommentModel> comments = [
    CommentModel(avatar: 'avatar', fullName: 'Alpha Beta', comment: 'Test Comment 1', duration: '10 minutes'),
    CommentModel(fullName: 'Test User', comment: 'Test Comment 1', duration: '10 minutes'),
    CommentModel(
        fullName: 'Foxtrot Exho',
        comment: 'Test Comment 1',
        duration: '10 minutes',
        image: 'https://miro.medium.com/v2/resize:fit:400/1*_6Dh7jYd1Rh4GjFymFUA8w.png')
  ];

  void postComment(String comment) {
    comments.add(CommentModel(fullName: 'Current user', comment: comment, duration: 'Now'));
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
    //final event = ModalRoute.of(context)!.settings.arguments as EventsMockUp;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: ClickWidget(
            onTap: () {
              BaseNavigator.pop();
            },
            child: const SizedBox(
              height: 30,
              width: 30,
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
              ),
            ),
          ),
        ),
        title: Text(
          "Event",
          style: context.headline3.copyWith(
            fontSize: 16,
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    40.height,
                    EventCard(event: widget.event),
                    const Gap(20),
                    SizedBox(
                      height: 300,
                      child: ListView(
                        controller: scrollController,
                        children: List.generate(
                          comments.length,
                          (index) => CommentTile(
                            comment: comments[index],
                          ),
                        ),
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
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(6),
              width: double.infinity,
              height: 40,
              child: Row(
                children: [
                  10.width,
                  const Icon(
                    Icons.camera_alt_outlined,
                    size: 16,
                    color: AppColors.darkBlue1,
                  ),
                  12.width,
                  const VerticalDivider(),
                  12.width,
                  Expanded(
                    child: TextField(
                      controller: commentController,
                      style: context.test.copyWith(),
                      cursorColor: AppColors.darkBlue1,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type your comment',
                        hintStyle: context.body2.copyWith(
                          fontSize: 12,
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      postComment(commentController.text);
                      commentController.clear();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.darkBlue1,
                      ),
                      padding: const EdgeInsets.all(5),
                      child: SvgPicture.asset('assets/icons/icon_send.svg'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
