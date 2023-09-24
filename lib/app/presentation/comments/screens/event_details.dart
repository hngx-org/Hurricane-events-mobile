// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hurricane_events/app/presentation/home/calendar/widgets/comment_tile.dart';
import 'package:hurricane_events/app/router/base_navigator.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/enums/enums.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/component/widgets/click_button.dart';
import 'package:hurricane_events/component/widgets/custom_textfield.dart';
import 'package:hurricane_events/component/widgets/event_card.dart';
import 'package:hurricane_events/component/widgets/shimmer/event_shimmer.dart';
import 'package:hurricane_events/data/models/comments/create_comments.dart';
import 'package:hurricane_events/domain/providers/events_provider.dart';
import 'package:hurricane_events/domain/providers/user_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PreCommentEventDetails extends StatefulWidget {
  static const String routeName = "pre_comment";

  final String id;

  const PreCommentEventDetails({
    super.key,
    required this.id,
  });

  @override
  State<PreCommentEventDetails> createState() => _PreCommentEventDetailsState();
}

class _PreCommentEventDetailsState extends State<PreCommentEventDetails> {
  DateTime nowDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  TextEditingController commentController = TextEditingController();

  late ImagePicker _picker;

  bool sending = false;

  XFile? image;

  ValueNotifier preSelected = ValueNotifier(false);
  ValueNotifier postSelected = ValueNotifier(false);

  final focus = FocusNode();

  getEventsDetails() async {
    try {
      context.read<EventProvider>()
        ..getEventId(id: widget.id)
        ..getComments(widget.id);
    } catch (_) {
      BaseNavigator.pop();
    }
  }

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getEventsDetails();

      // if (preEventComment.isNotEmpty) {
      //   preSelected.value = true;
      //   setState(() {});
      // } else if (postEventComment.isNotEmpty) {
      //   postSelected.value = true;
      //   setState(() {});
      // }
    });
  }

  postComment() async {
    if (commentController.text.trim().isEmpty) {
      return;
    }

    sending = true;
    setState(() {});

    CreateComment comment = CreateComment(
      body: commentController.text,
      userId: context.read<UserProvider>().user?.id,
      image: "",
    );

    // TaskSnapshot taskSnapshot = await FirebaseStorage.instance
    //     .ref()
    //     .child('thumbnails')
    //     .child("hng")
    //     .child(context.read<UserProvider>().user?.id ?? "")
    //     .putFile(File(image?.path ?? ""));
    // String url = await taskSnapshot.ref.getDownloadURL();
    // if (url.isEmpty) {
    //   comment = CreateComment(
    //     body: commentController.text,
    //     userId: context.read<UserProvider>().user?.id,
    //     image: "",
    //   );
    // } else {
    //   comment = CreateComment(
    //     body: commentController.text,
    //     userId: context.read<UserProvider>().user?.id,
    //     image: url,
    //   );
    // }

    final s = await context.read<EventProvider>().createComment(
          widget.id,
          comment,
        );

    if (s == true) {
      commentController.clear();
      context.read<EventProvider>().refreshComments(widget.id);
      setState(() {});
    } else {}

    sending = false;
    setState(() {});
  }

  @override
  void dispose() {
    focus.dispose();
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
        child: Consumer<EventProvider>(
          builder: (context, eventProvider, _) {
            if (eventProvider.eventState == AppState.loading) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: EventShimmer(),
              );
            }

            if (eventProvider.event == null) {
              return const SizedBox.shrink();
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Builder(
                builder: (context) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      12.height,
                      EventCard(
                        eventFull: eventProvider.event,
                      ),
                      // 30.height,
                      // ClickWidget(
                      //   onTap: () {
                      //     preSelected.value = !preSelected.value;
                      //     postSelected.value = false;
                      //     setState(() {});
                      //   },
                      //   child: ValueListenableBuilder(
                      //     valueListenable: preSelected,
                      //     builder: (context, value, _) {
                      //       return Container(
                      //         padding: const EdgeInsets.all(24),
                      //         decoration: BoxDecoration(
                      //           color: value ? Colors.white : AppColors.lightBlue1,
                      //           border: const Border(
                      //             top: BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                      //             bottom: BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                      //           ),
                      //         ),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text(
                      //               "Pre-event comments",
                      //               style: context.body2.copyWith(
                      //                 fontSize: 16,
                      //                 color: AppColors.designBlack1,
                      //               ),
                      //             ),
                      //             Builder(
                      //               builder: (context) {
                      //                 if (value) {
                      //                   return Transform.rotate(
                      //                     angle: math.pi / 2,
                      //                     child: const Center(
                      //                       child: Icon(
                      //                         Icons.arrow_forward_ios_rounded,
                      //                         size: 16,
                      //                       ),
                      //                     ),
                      //                   );
                      //                 }

                      //                 return const Icon(
                      //                   Icons.arrow_forward_ios_rounded,
                      //                   size: 16,
                      //                 );
                      //               },
                      //             ),
                      //           ],
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                      // ClickWidget(
                      //   onTap: () {
                      //     postSelected.value = !postSelected.value;
                      //     preSelected.value = false;
                      //     setState(() {});
                      //   },
                      //   child: ValueListenableBuilder(
                      //     valueListenable: postSelected,
                      //     builder: (context, value, _) {
                      //       return Container(
                      //         padding: const EdgeInsets.all(24),
                      //         decoration: BoxDecoration(
                      //           color: value ? Colors.white : AppColors.lightBlue1,
                      //           border: const Border(
                      //             top: BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                      //             bottom: BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                      //           ),
                      //         ),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text(
                      //               "Post-event comments",
                      //               style: context.body2.copyWith(
                      //                 fontSize: 16,
                      //                 color: AppColors.designBlack1,
                      //               ),
                      //             ),
                      //             Builder(
                      //               builder: (context) {
                      //                 if (value) {
                      //                   return Transform.rotate(
                      //                     angle: math.pi / 2,
                      //                     child: const Center(
                      //                       child: Icon(
                      //                         Icons.arrow_forward_ios_rounded,
                      //                         size: 16,
                      //                       ),
                      //                     ),
                      //                   );
                      //                 }

                      //                 return const Icon(
                      //                   Icons.arrow_forward_ios_rounded,
                      //                   size: 16,
                      //                 );
                      //               },
                      //             ),
                      //           ],
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                      16.height,
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            // if (preSelected.value) {
                            //   return Builder(builder: (context) {
                            //     if (preEventComment.isEmpty) {
                            //       return Column(
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         crossAxisAlignment: CrossAxisAlignment.center,
                            //         children: [
                            //           const Icon(
                            //             Icons.comments_disabled_outlined,
                            //             size: 80,
                            //             color: AppColors.designBlack1,
                            //           ),
                            //           const SizedBox(height: 24),
                            //           Padding(
                            //             padding: const EdgeInsets.symmetric(horizontal: 24),
                            //             child: Text(
                            //               "There are no comments to view for this event timeline.",
                            //               textAlign: TextAlign.center,
                            //               style: context.body1.copyWith(
                            //                 color: AppColors.designBlack1,
                            //                 fontSize: 16,
                            //               ),
                            //             ),
                            //           ),
                            //           const SizedBox(height: 48),
                            //         ],
                            //       );
                            //     }
                            //     return FadeInDown(
                            //       duration: const Duration(milliseconds: 200),
                            //       child: GroupedListView<Comment, String>(
                            //         padding: EdgeInsets.zero,
                            //         elements: preEventComment,
                            //         groupBy: (element) => element.createdAt!.toIso8601String(),
                            //         itemComparator: (item1, item2) => item2.createdAt!.compareTo(item1.createdAt!),
                            //         groupComparator: (value1, value2) => value2.compareTo(value1),
                            //         order: GroupedListOrder.ASC,
                            //         useStickyGroupSeparators: false,
                            //         groupSeparatorBuilder: (value) {
                            //           return 16.height;
                            //         },
                            //         itemBuilder: (context, Comment element) {
                            //           return CommentTile(
                            //             comment: element,
                            //           );
                            //         },
                            //       ),
                            //     );
                            //   });
                            // }

                            // if (postSelected.value) {
                            //   return Builder(builder: (context) {
                            //     if (postEventComment.isEmpty) {
                            //       return Column(
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         crossAxisAlignment: CrossAxisAlignment.center,
                            //         children: [
                            //           const Icon(
                            //             Icons.comments_disabled_outlined,
                            //             size: 80,
                            //             color: AppColors.designBlack1,
                            //           ),
                            //           const SizedBox(height: 24),
                            //           Padding(
                            //             padding: const EdgeInsets.symmetric(horizontal: 24),
                            //             child: Text(
                            //               "There are no comments to view for this event timeline.",
                            //               textAlign: TextAlign.center,
                            //               style: context.body1.copyWith(
                            //                 color: AppColors.designBlack1,
                            //                 fontSize: 16,
                            //               ),
                            //             ),
                            //           ),
                            //           const SizedBox(height: 48),
                            //         ],
                            //       );
                            //     }
                            //     return FadeInDown(
                            //       duration: const Duration(milliseconds: 200),
                            //       child: GroupedListView<Comment, String>(
                            //         padding: EdgeInsets.zero,
                            //         elements: postEventComment,
                            //         groupBy: (element) => element.createdAt!.toIso8601String(),
                            //         itemComparator: (item1, item2) => item2.createdAt!.compareTo(item1.createdAt!),
                            //         groupComparator: (value1, value2) => value2.compareTo(value1),
                            //         order: GroupedListOrder.ASC,
                            //         useStickyGroupSeparators: false,
                            //         groupSeparatorBuilder: (value) {
                            //           return 16.height;
                            //         },
                            //         itemBuilder: (context, Comment element) {
                            //           return CommentTile(
                            //             comment: element,
                            //           );
                            //         },
                            //       ),
                            //     );
                            //   });
                            // }
                            // return const SizedBox.shrink();

                            return Builder(
                              builder: (context) {
                                if (eventProvider.comments.isEmpty) {
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
                                  child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      final comment = eventProvider.comments[index];
                                      return CommentTile(
                                        comment: comment,
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return 16.height;
                                    },
                                    itemCount: eventProvider.comments.length,
                                  ),
                                  // GroupedListView<Comment, String>(
                                  //   padding: EdgeInsets.zero,
                                  //   elements: eventProvider.comments,
                                  //   groupBy: (element) => element.createdAt!.toIso8601String(),
                                  //   itemComparator: (item1, item2) => item2.createdAt!.compareTo(item1.createdAt!),
                                  //   groupComparator: (value1, value2) => value2.compareTo(value1),
                                  //   order: GroupedListOrder.ASC,
                                  //   useStickyGroupSeparators: false,
                                  //   groupSeparatorBuilder: (value) {
                                  //     return 16.height;
                                  //   },
                                  //   itemBuilder: (context, Comment element) {
                                  //     return CommentTile(
                                  //       comment: element,
                                  //     );
                                  //   },
                                  // ),
                                );
                              },
                            );
                          },
                        ),
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
                        onTap: () async {
                          await _picker.pickImage(source: ImageSource.gallery).then(
                            (value) async {
                              if (value != null) {
                                image = value;
                                setState(() {});
                              }
                            },
                          );
                        },
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Builder(builder: (_) {
                              if (image != null) {
                                return InkWell(
                                  onTap: () {
                                    image = null;
                                    setState(() {});
                                  },
                                  child: Stack(
                                    children: [
                                      Image.file(
                                        File(image!.path),
                                        height: 30,
                                        width: 30,
                                      ),
                                      const Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Icon(
                                          Icons.cancel,
                                          color: Colors.red,
                                          size: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }

                              return const SizedBox.shrink();
                            }),
                            ClickWidget(
                              onTap: () async {
                                if (sending) {
                                  return;
                                }
                                await postComment();
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
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
