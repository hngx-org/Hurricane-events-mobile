import 'package:animate_do/animate_do.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hurricane_events/app/presentation/comments/screens/event_details.dart';
import 'package:hurricane_events/app/presentation/home/my_group/provider/my_group_provider.dart';
import 'package:hurricane_events/app/router/base_navigator.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/constants/images.dart';
import 'package:hurricane_events/component/enums/enums.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/component/widgets/click_button.dart';
import 'package:hurricane_events/component/widgets/event_card.dart';
import 'package:hurricane_events/component/widgets/overlays/delete_event.dart';
import 'package:hurricane_events/component/widgets/shimmer/event_shimmer.dart';
import 'package:hurricane_events/data/models/groups/group_details.dart';
import 'package:hurricane_events/data/repository/group_repository/group_repository.dart';
import 'package:hurricane_events/domain/providers/events_provider.dart';
import 'package:hurricane_events/domain/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../component/widgets/custom_textfield.dart';

class GroupDetailsScreen extends StatefulWidget {
  static const String routeName = "group_details";
  final GroupDetails groupDetail;

  const GroupDetailsScreen({
    super.key,
    required this.groupDetail,
  });

  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  ValueNotifier addPeoplePressed = ValueNotifier(false);

  String? emailError;

  bool isDeleting = false;

  final emailFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailFocus.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MyGroupProvider>(context, listen: false).getGrouEvents(widget.groupDetail.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
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
          "My Group",
          style: context.headline3.copyWith(
            fontSize: 16,
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer<MyGroupProvider>(builder: (context, myGroupProvider, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                24.height,
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(width: 1, color: Color(0xFFCCE6FF)),
                      bottom: BorderSide(width: 1, color: Color(0xFFCCE6FF)),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: ShapeDecoration(
                          color: AppColors.lightBlue1,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: SvgPicture.asset(
                          AppImages.techiesIcon,
                          height: 56,
                        ),
                      ),
                      16.width,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.groupDetail.title!,
                              style: context.body1.copyWith(fontSize: 16),
                            ),
                            // 12.height,
                            // Row(
                            //   children: [
                            //     //Number of people
                            //     const MyGroupChip(
                            //       title: "33 people",
                            //     ),
                            //     12.width,

                            //     //Number of events
                            //     const MyGroupChip(
                            //       title: "3 Upcoming events",
                            //     ),
                            //   ],
                            // )
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          addPeoplePressed.value = !addPeoplePressed.value;
                        },
                        icon: const Icon(
                          Icons.group_add_rounded,
                          color: AppColors.darkBlue1,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          final s = await AppOverlays.showDeleteGroupDialog(
                            context,
                            widget.groupDetail.id ?? "",
                            widget.groupDetail.title ?? "",
                          );

                          if (!mounted) return;

                          if (s != null && s == true) {
                            BaseNavigator.pop();
                            BaseNavigator.currentContext.read<MyGroupProvider>().refreshUserGroups(
                                  context.read<UserProvider>().user?.id ?? "",
                                );
                            context.read<EventProvider>().refreshEvents();
                            context.read<EventProvider>().refreshUserAndFriendsEvents();
                          }
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: AppColors.designRed,
                        ),
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: addPeoplePressed,
                  builder: (context, value, _) {
                    if (!value) {
                      return const SizedBox.shrink();
                    }
                    return Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          12.height,
                          FadeInDown(
                            duration: const Duration(milliseconds: 100),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                10.height,
                                CustomTextField(
                                  focus: emailFocus,
                                  filled: true,
                                  controller: _email,
                                  errorText: emailError,
                                  hintText: "Enter email of user",
                                  suffixIcon: IconButton(
                                    onPressed: () async {
                                      if (_email.text.trim().isEmpty) {
                                        return;
                                      }

                                      if (_formKey.currentState!.validate()) {
                                        final r = await GroupRepository.instance.inviteUsersToGroup(
                                          context.read<UserProvider>().user!.id!,
                                          widget.groupDetail.id!,
                                          [_email.text],
                                        );

                                        if (r.item1 != null) {
                                          if (r.item1!.invalidUsers!.isEmpty) {
                                            _email.clear();
                                            setState(() {});
                                            if (mounted) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  backgroundColor: AppColors.lightBlue1,
                                                  content: Text(
                                                    "Email added successfully",
                                                    style: context.body1.copyWith(
                                                      fontSize: 12,
                                                      color: AppColors.designBlack1,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                          } else {
                                            if (mounted) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  backgroundColor: AppColors.lightBlue1,
                                                  content: Text(
                                                    "User does not exist on the platform",
                                                    style: context.body1.copyWith(
                                                      fontSize: 12,
                                                      color: AppColors.designBlack1,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                          }
                                        }
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: AppColors.darkBlue1,
                                    ),
                                  ),
                                  validator: (p0) {
                                    if (p0 == null || p0.trim().isEmpty) {
                                      emailError = "Please enter a valid email";
                                      setState(() {});
                                      return emailError;
                                    }

                                    if (!EmailValidator.validate(p0)) {
                                      emailError = "This email is not valid";
                                      setState(() {});
                                      return emailError;
                                    }

                                    emailError = null;
                                    setState(() {});
                                    return emailError;
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
                40.height,
                Text(
                  "Upcoming events",
                  style: context.body1.copyWith(
                    fontSize: 16,
                    color: AppColors.darkGrey,
                  ),
                ),
                24.height,
                Expanded(
                  child: Builder(builder: (context) {
                    if (myGroupProvider.groupEventState == AppState.loading) {
                      return const EventShimmer();
                    }

                    if (myGroupProvider.allEvents.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.free_cancellation_rounded,
                              size: 100,
                              color: AppColors.designBlack1,
                            ),
                            const SizedBox(height: 24),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0),
                              child: Text(
                                "There are no events in this group",
                                textAlign: TextAlign.center,
                                style: context.body1.copyWith(
                                  color: AppColors.designBlack1,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 48),
                          ],
                        ),
                      );
                    }
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return ClickWidget(
                          onTap: () async {
                            await BaseNavigator.pushNamed(
                              PreCommentEventDetails.routeName,
                              args: myGroupProvider.allEvents[index]!.id,
                            );

                            if (!mounted) return;

                            context.read<MyGroupProvider>().refreshGrouEvents(
                                  widget.groupDetail.id!,
                                );
                          },
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  EventCard(
                                    eventFull: myGroupProvider.allEvents[index],
                                    onTap: () async {
                                      final s = await AppOverlays.showDeleteDialog(
                                        context,
                                        myGroupProvider.allEvents[index]?.id ?? "",
                                        myGroupProvider.allEvents[index]?.title ?? "",
                                      );

                                      if (!mounted) return;

                                      if (s != null && s == true) {
                                        context.read<MyGroupProvider>().refreshGrouEvents(
                                              widget.groupDetail.id ?? "",
                                            );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return 16.height;
                      },
                      itemCount: myGroupProvider.allEvents.length,
                    );
                  }),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
