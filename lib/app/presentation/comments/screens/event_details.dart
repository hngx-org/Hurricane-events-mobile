import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hurricane_events/app/presentation/home/calendar/widgets/comment_tile.dart';
import 'package:hurricane_events/app/router/base_navigator.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/component/widgets/click_button.dart';
import 'package:hurricane_events/component/widgets/custom_textfield.dart';
import 'package:hurricane_events/component/widgets/event_card.dart';
import 'package:hurricane_events/data/models/events/event_mock_up.dart';
import 'dart:math' as math;

class PreCommentEventDetails extends StatefulWidget {
  static const String routeName = "pre_comment";

  final EventsMockUp event;

  const PreCommentEventDetails({
    super.key,
    required this.event,
  });

  @override
  State<PreCommentEventDetails> createState() => _PreCommentEventDetailsState();
}

class _PreCommentEventDetailsState extends State<PreCommentEventDetails> {
  DateTime nowDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  TextEditingController commentController = TextEditingController();

  List<Comment> preEventComment = [];
  List<Comment> postEventComment = [];

  ValueNotifier preSelected = ValueNotifier(false);
  ValueNotifier postSelected = ValueNotifier(false);

  final focus = FocusNode();

  eventCommentsCheck() async {
    if (widget.event.endDate != null) {
      if (widget.event.endDate!.difference(nowDate).inDays.isNegative) {
        if (widget.event.comments != null) {
          if (widget.event.comments!.isNotEmpty) {
            for (var i = 0; i < widget.event.comments!.length; i++) {
              final comment = widget.event.comments![i];
              if (comment.createdAt!.difference(widget.event.startDate!).inMinutes.isNegative) {
                preEventComment.add(comment);
              } else {
                postEventComment.add(comment);
              }
            }
          }
        }
      } else {
        if (widget.event.comments != null) {
          if (widget.event.comments!.isNotEmpty) {
            for (var i = 0; i < widget.event.comments!.length; i++) {
              final comment = widget.event.comments![i];
              preEventComment.add(comment);
            }
          }
        }
      }
    } else {
      if (widget.event.startDate!.difference(nowDate).inDays.isNegative) {
        if (widget.event.comments != null) {
          if (widget.event.comments!.isNotEmpty) {
            for (var i = 0; i < widget.event.comments!.length; i++) {
              final comment = widget.event.comments![i];
              if (comment.createdAt!.difference(widget.event.startDate!).inMinutes.isNegative) {
                preEventComment.add(comment);
              } else {
                postEventComment.add(comment);
              }
            }
          }
        }
      } else {
        if (widget.event.comments != null) {
          if (widget.event.comments!.isNotEmpty) {
            for (var i = 0; i < widget.event.comments!.length; i++) {
              final comment = widget.event.comments![i];
              preEventComment.add(comment);
            }
          }
        }
      }
    }
  }

  // void postComment(String comment) {
  //   comments.add(
  //     CommentModel(
  //       fullName: 'Current user',
  //       comment: comment,
  //       duration: 'Now',
  //     ),
  //   );
  //   setState(() {});

  //   // Remove the keyboard focus after sending the comment.
  //   FocusScope.of(context).unfocus();

  //   Future.delayed(const Duration(milliseconds: 100), () {
  //     scrollController.animateTo(
  //       scrollController.position.maxScrollExtent,
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeOut,
  //     );
  //   });
  // }

  @override
  void initState() {
    super.initState();
    eventCommentsCheck();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      log(preEventComment.toString());
      log(postEventComment.toString());

      if (preEventComment.isNotEmpty) {
        preSelected.value = true;
        setState(() {});
      } else if (postEventComment.isNotEmpty) {
        postSelected.value = true;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        scrolledUnderElevation: 0,
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              12.height,
              EventCard(
                event: widget.event,
              ),
              30.height,
              ClickWidget(
                onTap: () {
                  preSelected.value = !preSelected.value;
                  postSelected.value = false;
                  setState(() {});
                },
                child: ValueListenableBuilder(
                  valueListenable: preSelected,
                  builder: (context, value, _) {
                    return Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: value ? Colors.white : AppColors.lightBlue1,
                        border: const Border(
                          top: BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                          bottom: BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pre-event comments",
                            style: context.body2.copyWith(
                              fontSize: 16,
                              color: AppColors.designBlack1,
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              if (value) {
                                return Transform.rotate(
                                  angle: math.pi / 2,
                                  child: const Center(
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 16,
                                    ),
                                  ),
                                );
                              }

                              return const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              ClickWidget(
                onTap: () {
                  postSelected.value = !postSelected.value;
                  preSelected.value = false;
                  setState(() {});
                },
                child: ValueListenableBuilder(
                  valueListenable: postSelected,
                  builder: (context, value, _) {
                    return Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: value ? Colors.white : AppColors.lightBlue1,
                        border: const Border(
                          top: BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                          bottom: BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Post-event comments",
                            style: context.body2.copyWith(
                              fontSize: 16,
                              color: AppColors.designBlack1,
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              if (value) {
                                return Transform.rotate(
                                  angle: math.pi / 2,
                                  child: const Center(
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 16,
                                    ),
                                  ),
                                );
                              }

                              return const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              16.height,
              Expanded(
                child: Builder(builder: (context) {
                  if (preSelected.value) {
                    return Builder(builder: (context) {
                      if (preEventComment.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.comments_disabled_outlined,
                              size: 80,
                              color: AppColors.designBlack1,
                            ),
                            const SizedBox(height: 24),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Text(
                                "There are no comments to view for this event timeline.",
                                textAlign: TextAlign.center,
                                style: context.body1.copyWith(
                                  color: AppColors.designBlack1,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 48),
                          ],
                        );
                      }
                      return FadeInDown(
                        duration: const Duration(milliseconds: 200),
                        child: GroupedListView<Comment, String>(
                          padding: EdgeInsets.zero,
                          elements: preEventComment,
                          groupBy: (element) => element.createdAt!.toIso8601String(),
                          itemComparator: (item1, item2) => item2.createdAt!.compareTo(item1.createdAt!),
                          groupComparator: (value1, value2) => value2.compareTo(value1),
                          order: GroupedListOrder.ASC,
                          useStickyGroupSeparators: false,
                          groupSeparatorBuilder: (value) {
                            return 16.height;
                          },
                          itemBuilder: (context, Comment element) {
                            return CommentTile(
                              comment: element,
                            );
                          },
                        ),
                      );
                    });
                  }

                  if (postSelected.value) {
                    return Builder(builder: (context) {
                      if (postEventComment.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.comments_disabled_outlined,
                              size: 80,
                              color: AppColors.designBlack1,
                            ),
                            const SizedBox(height: 24),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Text(
                                "There are no comments to view for this event timeline.",
                                textAlign: TextAlign.center,
                                style: context.body1.copyWith(
                                  color: AppColors.designBlack1,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 48),
                          ],
                        );
                      }
                      return FadeInDown(
                        duration: const Duration(milliseconds: 200),
                        child: GroupedListView<Comment, String>(
                          padding: EdgeInsets.zero,
                          elements: postEventComment,
                          groupBy: (element) => element.createdAt!.toIso8601String(),
                          itemComparator: (item1, item2) => item2.createdAt!.compareTo(item1.createdAt!),
                          groupComparator: (value1, value2) => value2.compareTo(value1),
                          order: GroupedListOrder.ASC,
                          useStickyGroupSeparators: false,
                          groupSeparatorBuilder: (value) {
                            return 16.height;
                          },
                          itemBuilder: (context, Comment element) {
                            return CommentTile(
                              comment: element,
                            );
                          },
                        ),
                      );
                    });
                  }
                  return const SizedBox.shrink();
                }),
              ),
              12.height,
              CustomTextField2(
                focus: focus,
                filled: true,
                controller: commentController,
                fillColor: const Color(0xFFF2F2F2),
                hintText: 'Type your comment',
                textInputType: TextInputType.multiline,
                maxLines: null,
                suffixIcon: ClickWidget(
                  onTap: () {
                    commentController.clear();
                  },
                  child: Container(
                    height: 28,
                    width: 28,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.darkBlue1,
                    ),
                    padding: const EdgeInsets.all(5),
                    child: SvgPicture.asset(
                      'assets/icons/icon_send.svg',
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
