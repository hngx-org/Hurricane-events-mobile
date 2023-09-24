import 'package:flutter/material.dart';
import 'package:hurricane_events/app/presentation/add_event/widgets/user_groups_tiles.dart';
import 'package:hurricane_events/app/presentation/add_group/screens/add_group.dart';
import 'package:hurricane_events/app/presentation/home/my_group/provider/my_group_provider.dart';
import 'package:hurricane_events/app/router/base_navigator.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/enums/enums.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/component/widgets/click_button.dart';
import 'package:hurricane_events/component/widgets/custom_button.dart';
import 'package:hurricane_events/component/widgets/custom_textfield.dart';
import 'package:hurricane_events/component/widgets/shimmer/add_ebent_group_shimmer.dart';
import 'package:hurricane_events/data/models/events/add_events_modal.dart';
import 'package:hurricane_events/data/models/groups/group_details.dart';
import 'package:hurricane_events/domain/providers/events_provider.dart';
import 'package:hurricane_events/domain/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AddEvent extends StatefulWidget {
  static const String routeName = "add_event-screen";
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

///defined variables used on this screen
///navigation not done.
///
class _AddEventState extends State<AddEvent> {
  GroupDetails? selectedGroup;

  final _formKey = GlobalKey<FormState>();

  String? nameError;
  String? locationError;

  DateTime? _startDateController;
  DateTime? _endDateController;

  TimeOfDay? _startDateStartTimeController;
  TimeOfDay? _startDateEndTimeController;

  TimeOfDay? _endDateStartTimeController;
  TimeOfDay? _endDateEndTimeController;

  final nameFocus = FocusNode();
  final TextEditingController _name = TextEditingController();

  final locationFocus = FocusNode();
  final TextEditingController _location = TextEditingController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  TimeOfDay startDateStartTime = TimeOfDay.now();
  TimeOfDay endDateStartTime = TimeOfDay.now();
  TimeOfDay startDateEndTime = TimeOfDay.now();
  TimeOfDay endDateEndTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MyGroupProvider>(context, listen: false).getUserGroups(
        context.read<UserProvider>().user!.id!,
      );
    });
  }

  List<String> onlineIcons = [
    // Add new Icons here...
    'https://img.icons8.com/?size=160&id=j2lPVrxHLuGq&format=png',
    'https://img.icons8.com/?size=160&id=uOgV6ugNgk6m&format=png',
    'https://img.icons8.com/?size=96&id=l3jcLOr5VOxm&format=png',
    'https://img.icons8.com/?size=160&id=tHVAuNrS2dx2&format=png'
  ];

  int selectedIconIndex = -1;
  String selectedIconUrl = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(
      builder: (context, eventsProvider, _) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: AppColors.backgroundColor,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                BaseNavigator.pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
              ),
            ),
            title: Text(
              'Add Event',
              textAlign: TextAlign.center,
              style: context.headline3.copyWith(
                fontSize: 16,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  32.height,
                  Text(
                    'Name of Event',
                    style: context.body2.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  8.height,
                  CustomTextField(
                    focus: nameFocus,
                    filled: true,
                    controller: _name,
                    enabled: () {
                      if (eventsProvider.state == AppState.loading) {
                        return false;
                      }

                      return true;
                    }(),
                    errorText: nameError,
                    hintText: "Enter name of event",
                    validator: (p0) {
                      if (p0 == null || p0.trim().isEmpty) {
                        nameError = "Please enter your event name";
                        setState(() {});
                        return nameError;
                      }

                      nameError = null;
                      setState(() {});
                      return nameError;
                    },
                  ),
                  24.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select a group',
                        textAlign: TextAlign.left,
                        style: context.body2.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      Builder(builder: (_) {
                        if (eventsProvider.getGroupState == AppState.loading) {
                          return const SizedBox(
                            height: 12,
                            width: 12,
                            child: CircularProgressIndicator(
                              color: AppColors.darkBlue1,
                              strokeWidth: 2,
                            ),
                          );
                        }

                        return const SizedBox.shrink();
                      }),
                    ],
                  ),
                  8.height,

                  ///user group horizontal scroll
                  ///I think it should have radio function to enable selecting just one at a time.
                  ///no function implemented yet
                  Consumer<MyGroupProvider>(
                    builder: (context, group, _) {
                      if (group.state == AppState.loading) {
                        return const SizedBox(
                          height: 40,
                          child: AddEventGroupShimmer(),
                        );
                      }

                      return SizedBox(
                        height: 40.0,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                BaseNavigator.pop();
                                await BaseNavigator.pushNamed(
                                  AddGroupScreen.routeName,
                                );

                                if (!mounted) return;

                                context
                                    .read<MyGroupProvider>()
                                    .refreshUserGroups(
                                      context.read<UserProvider>().user!.id!,
                                    );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.darkBlue1,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  "Add Group",
                                  style: context.body2.copyWith(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            4.width,
                            const VerticalDivider(),
                            Expanded(
                              child: Builder(
                                builder: (context) {
                                  if (group.allGroups.isEmpty) {
                                    return const SizedBox.shrink();
                                  }

                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: group.allGroups.length,
                                    itemBuilder: (context, i) {
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 0.0, 10.0, 0.0),
                                        child: ClickWidget(
                                          onTap: () {
                                            selectedGroup = group.allGroups[i];
                                            setState(() {});
                                          },
                                          child: RoundedTile(
                                            group: group.allGroups[i]!,
                                            isSelected: selectedGroup?.id ==
                                                group.allGroups[i]?.id,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  24.height,

                  Text(
                    'Date of event',
                    textAlign: TextAlign.left,
                    style: context.body2.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  8.height,

                  ///start date
                  Text(
                    'Start of event',
                    style: context.body2.copyWith(
                      color: AppColors.designBlack3,
                      fontSize: 12,
                    ),
                  ),
                  6.height,

                  // ///start date row
                  SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ClickWidget(
                              onTap: () async {
                                if (eventsProvider.state == AppState.loading) {
                                  return;
                                }
                                final res = await showDatePicker(
                                  context: context,
                                  initialDate: startDate,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                if (!mounted) return;

                                if (res != null) {
                                  setState(() {
                                    _startDateController = res.toLocal();
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.calendar_month,
                                      size: 16.0,
                                    ),
                                    8.width,
                                    Container(
                                      height: 16,
                                      width: 1,
                                      color: AppColors.designGrey,
                                    ),
                                    8.width,
                                    Expanded(
                                      child: Builder(
                                        builder: (_) {
                                          // print(_startDateController);
                                          if (_startDateController != null) {
                                            final text =
                                                "${_startDateController!.toLocal()}"
                                                    .split(' ')[0];

                                            return Text(
                                              text,
                                              style: context.body2.copyWith(
                                                fontSize: 12,
                                                color: AppColors.designBlack1,
                                              ),
                                            );
                                          }
                                          return Text(
                                            "Start day",
                                            style: context.body2.copyWith(
                                              fontSize: 10,
                                              color: AppColors.designBlack3,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ClickWidget(
                              onTap: () async {
                                if (eventsProvider.state == AppState.loading) {
                                  return;
                                }
                                final TimeOfDay? pickedTime =
                                    await showTimePicker(
                                  context: context,
                                  initialTime: startDateStartTime,
                                );
                                if (!mounted) return;

                                if (pickedTime != null) {
                                  setState(() {
                                    _startDateStartTimeController = pickedTime;
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.access_time_outlined,
                                      size: 16.0,
                                    ),
                                    8.width,
                                    Container(
                                      height: 16,
                                      width: 1,
                                      color: AppColors.designGrey,
                                    ),
                                    8.width,
                                    Expanded(
                                      child: Builder(
                                        builder: (_) {
                                          if (_startDateStartTimeController !=
                                              null) {
                                            final text =
                                                _startDateStartTimeController!
                                                    .format(context);

                                            return Text(
                                              text,
                                              style: context.body2.copyWith(
                                                fontSize: 12,
                                                color: AppColors.designBlack1,
                                              ),
                                            );
                                          }
                                          return Text(
                                            "Start time",
                                            style: context.body2.copyWith(
                                              fontSize: 10,
                                              color: AppColors.designBlack3,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ClickWidget(
                              onTap: () async {
                                if (eventsProvider.state == AppState.loading) {
                                  return;
                                }
                                final TimeOfDay? pickedTime =
                                    await showTimePicker(
                                  context: context,
                                  initialTime: startDateEndTime,
                                );
                                if (!mounted) return;

                                if (pickedTime != null) {
                                  setState(() {
                                    _startDateEndTimeController = pickedTime;
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.access_time_outlined,
                                      size: 16.0,
                                    ),
                                    8.width,
                                    Container(
                                      height: 16,
                                      width: 1,
                                      color: AppColors.designGrey,
                                    ),
                                    8.width,
                                    Expanded(
                                      child: Builder(
                                        builder: (_) {
                                          if (_startDateEndTimeController !=
                                              null) {
                                            final text =
                                                _startDateEndTimeController!
                                                    .format(context);

                                            return Text(
                                              text,
                                              style: context.body2.copyWith(
                                                fontSize: 12,
                                                color: AppColors.designBlack1,
                                              ),
                                            );
                                          }
                                          return Text(
                                            "End time",
                                            style: context.body2.copyWith(
                                              fontSize: 10,
                                              color: AppColors.designBlack3,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  12.height,

                  // ///End date
                  Text(
                    'End of event (if event is more than a day)',
                    style: context.body2.copyWith(
                      color: AppColors.designBlack3,
                      fontSize: 12,
                    ),
                  ),

                  // ///End date row
                  SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ClickWidget(
                              onTap: () async {
                                if (eventsProvider.state == AppState.loading) {
                                  return;
                                }
                                final res = await showDatePicker(
                                  context: context,
                                  initialDate: endDate,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                if (!mounted) return;

                                if (res != null) {
                                  setState(() {
                                    _endDateController = res.toLocal();
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.calendar_month,
                                      size: 16.0,
                                    ),
                                    8.width,
                                    Container(
                                      height: 16,
                                      width: 1,
                                      color: AppColors.designGrey,
                                    ),
                                    8.width,
                                    Expanded(
                                      child: Builder(
                                        builder: (_) {
                                          if (_endDateController != null) {
                                            final text =
                                                "${_endDateController!.toLocal()}"
                                                    .split(' ')[0];

                                            return Text(
                                              text,
                                              style: context.body2.copyWith(
                                                fontSize: 12,
                                                color: AppColors.designBlack1,
                                              ),
                                            );
                                          }
                                          return Text(
                                            "End day",
                                            style: context.body2.copyWith(
                                              fontSize: 10,
                                              color: AppColors.designBlack3,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ClickWidget(
                              onTap: () async {
                                if (eventsProvider.state == AppState.loading) {
                                  return;
                                }
                                final TimeOfDay? pickedTime =
                                    await showTimePicker(
                                  context: context,
                                  initialTime: endDateStartTime,
                                );
                                if (!mounted) return;

                                if (pickedTime != null) {
                                  setState(() {
                                    _endDateStartTimeController = pickedTime;
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.access_time_outlined,
                                      size: 16.0,
                                    ),
                                    8.width,
                                    Container(
                                      height: 16,
                                      width: 1,
                                      color: AppColors.designGrey,
                                    ),
                                    8.width,
                                    Expanded(
                                      child: Builder(
                                        builder: (_) {
                                          if (_endDateStartTimeController !=
                                              null) {
                                            final text =
                                                _endDateStartTimeController!
                                                    .format(context);

                                            return Text(
                                              text,
                                              style: context.body2.copyWith(
                                                fontSize: 12,
                                                color: AppColors.designBlack1,
                                              ),
                                            );
                                          }
                                          return Text(
                                            "Start time",
                                            style: context.body2.copyWith(
                                              fontSize: 10,
                                              color: AppColors.designBlack3,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ClickWidget(
                              onTap: () async {
                                if (eventsProvider.state == AppState.loading) {
                                  return;
                                }
                                final TimeOfDay? pickedTime =
                                    await showTimePicker(
                                  context: context,
                                  initialTime: endDateEndTime,
                                );
                                if (!mounted) return;

                                if (pickedTime != null) {
                                  setState(() {
                                    _endDateEndTimeController = pickedTime;
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.access_time_outlined,
                                      size: 16.0,
                                    ),
                                    8.width,
                                    Container(
                                      height: 16,
                                      width: 1,
                                      color: AppColors.designGrey,
                                    ),
                                    8.width,
                                    Expanded(
                                      child: Builder(
                                        builder: (_) {
                                          if (_endDateEndTimeController !=
                                              null) {
                                            final text =
                                                _endDateEndTimeController!
                                                    .format(context);

                                            return Text(
                                              text,
                                              style: context.body2.copyWith(
                                                fontSize: 12,
                                                color: AppColors.designBlack1,
                                              ),
                                            );
                                          }
                                          return Text(
                                            "End time",
                                            style: context.body2.copyWith(
                                              fontSize: 10,
                                              color: AppColors.designBlack3,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  24.height,

                  // ///Location editor
                  Text(
                    'Location',
                    style: context.body2.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  8.height,
                  CustomTextField(
                    focus: locationFocus,
                    filled: true,
                    errorText: locationError,
                    controller: _location,
                    enabled: () {
                      if (eventsProvider.state == AppState.loading) {
                        return false;
                      }

                      return true;
                    }(),
                    hintText: "Enter location of event",
                    validator: (p0) {
                      if (p0 == null || p0.trim().isEmpty) {
                        locationError = "Please enter a valid location";
                        setState(() {});
                        return nameError;
                      }

                      locationError = null;
                      setState(() {});
                      return locationError;
                    },
                  ),
                  12.height,
                  ClickWidget(
                    onTap: () {},
                    child: Text(
                      'Use current location instead',
                      style: context.body1.copyWith(
                        color: AppColors.darkBlue1,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  24.height,

                  // ///Event Icon
                  Text(
                    'Choose an icon',
                    style: context.body2.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  8.height,

                  // ///Event Icon Row
                  // ///having issues inserting the required images
                  Row(
                    children: List.generate(
                      onlineIcons.length,
                      (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            // Check if the tapped icon is already selected
                            if (selectedIconIndex == index) {
                              // If it's the same icon, deselect it
                              selectedIconUrl = '';
                              selectedIconIndex = -1;
                            } else {
                              // If a different icon is tapped, select it
                              selectedIconUrl = onlineIcons[index];
                              selectedIconIndex = index;
                            }
                          });
                        },
                        child: Container(
                          height: 76.0,
                          width: 76.0,
                          margin: const EdgeInsets.only(right: 14),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: selectedIconIndex == index
                                ? AppColors.darkBlue1
                                : AppColors.darkGrey2,
                            border: Border.all(
                              color: selectedIconIndex == index
                                  ? AppColors.darkBlue1
                                  : Colors.transparent,
                              width: 2.0, // Adjust the border width as needed
                            ),
                          ),
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(24.0),
                          //   color: AppColors.darkGrey2,
                          // ),
                          child: Image.network(
                            onlineIcons[index],
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }

                              return Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.darkBlue1,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    // children: [
                    // Container(
                    //   height: 76.0,
                    //   width: 76.0,
                    //   padding: const EdgeInsets.all(14),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(24.0),
                    //     color: AppColors.darkGrey2,
                    //   ),
                    //   child: const Svg(
                    //     image: AppImages.techiesIcon,
                    //   ),
                    // ),
                    // const SizedBox(width: 12.0),
                    // Container(
                    //   height: 76.0,
                    //   width: 76.0,
                    //   padding: const EdgeInsets.all(14),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(24.0),
                    //     color: AppColors.darkGrey2,
                    //   ),
                    //   child: const Svg(
                    //     image: AppImages.techiesIcon,
                    //   ),
                    // ),
                    // 12.width,
                    // Visibility(
                    //   visible: _customEventIcon != null,
                    //   child: Container(
                    //     height: 76.0,
                    //     width: 76.0,
                    //     padding: const EdgeInsets.all(14),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(24.0),
                    //       color: AppColors.darkGrey2,
                    //     ),
                    //     child: _customEventIcon != null
                    //         ? ClipRRect(
                    //             child: Image.file(
                    //               _customEventIcon!,
                    //               fit: BoxFit.cover,
                    //             ),
                    //           )
                    //         : const Placeholder(),
                    //   ),
                    // ),
                    // 12.width,
                    // Visibility(
                    //   visible: _customEventIcon == null,
                    //   child: ClickWidget(
                    //     onTap: _getImageFromGallery,
                    //     child: Row(
                    //       children: [
                    //         const Icon(
                    //           Icons.add,
                    //           color: AppColors.designOrange,
                    //         ),
                    //         7.width,
                    //         Text(
                    //           "Add from\nGallery",
                    //           style: context.body1.copyWith(
                    //             fontSize: 12,
                    //             color: AppColors.designOrange,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // 12.width,
                    // Visibility(
                    //   visible: _customEventIcon != null,
                    //   child: ClickWidget(
                    //     onTap: removeImage,
                    //     child: const Icon(
                    //       Icons.close,
                    //       color: AppColors.designOrange,
                    //     ),
                    //   ),
                    // ),
                    // ]
                  ),
                  20.height,
                  Builder(builder: (context) {
                    if (eventsProvider.state == AppState.loading) {
                      return const Center(
                        child: SizedBox(
                          height: 32,
                          width: 32,
                          child: CircularProgressIndicator(
                            color: AppColors.darkBlue1,
                          ),
                        ),
                      );
                    }

                    return CustomButton(
                      radius: 32,
                      backgroundColor: AppColors.darkBlue1,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (selectedGroup == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.lightBlue1,
                                content: Text(
                                  "You must select a group to continue",
                                  style: context.body1.copyWith(
                                    fontSize: 12,
                                    color: AppColors.designBlack1,
                                  ),
                                ),
                              ),
                            );
                            return;
                          }

                          if (_startDateStartTimeController == null ||
                              _startDateEndTimeController == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.lightBlue1,
                                content: Text(
                                  "You must input event start time and end time to continue",
                                  style: context.body1.copyWith(
                                    fontSize: 12,
                                    color: AppColors.designBlack1,
                                  ),
                                ),
                              ),
                            );
                            return;
                          }

                          if (_startDateController != null) {
                            AddEventsRequest request = AddEventsRequest(
                              title: _name.text,
                              description: selectedGroup?.title,
                              location: _location.text,
                              startDate: _startDateController,
                              endDate:
                                  _endDateController ?? _startDateController,
                              creatorId: context.read<UserProvider>().user?.id,
                              thumbnail: selectedIconUrl,
                              startTime: DateTime(
                                _startDateController!.year,
                                _startDateController!.month,
                                _startDateController!.day,
                                _startDateStartTimeController!.hour,
                                _startDateStartTimeController!.minute,
                              ),
                              endTime: _endDateController == null
                                  ? DateTime(
                                      _startDateController!.year,
                                      _startDateController!.month,
                                      _startDateController!.day,
                                      _startDateEndTimeController!.hour,
                                      _startDateEndTimeController!.minute,
                                    )
                                  : DateTime(
                                      _endDateController!.year,
                                      _endDateController!.month,
                                      _endDateController!.day,
                                      _endDateEndTimeController!.hour,
                                      _endDateEndTimeController!.minute,
                                    ),
                            );

                            await eventsProvider.createEvent(
                              body: request,
                              group: selectedGroup!,
                            );
                          }
                        }
                      },
                      buttonWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          7.width,
                          Text(
                            "Add Event",
                            style: context.button2.copyWith(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  48.height,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
