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
import 'package:hurricane_events/component/widgets/shimmer/event_shimmer.dart';
import 'package:hurricane_events/data/models/groups/group_details.dart';
import 'package:provider/provider.dart';

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
  @override
  void initState() {
    super.initState();
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
                      Column(
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
                      )
                    ],
                  ),
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
                                    onTap: () {},
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
