import 'package:flutter/material.dart';
import 'package:hurricane_events/app/presentation/add_event/widgets/custom_textfield.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/constants/images.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/app/presentation/add_event/widgets/user_groups_tiles.dart';
import 'package:hurricane_events/app/router/base_navigator.dart';
import 'package:hurricane_events/component/constants/app_strings.dart';
import 'package:hurricane_events/component/widgets/click_button.dart';
import 'package:hurricane_events/component/widgets/custom_button.dart';
import 'package:hurricane_events/component/widgets/svg_picture.dart';

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
  List<String> userGroups = [
    AppStrings.test,
    'lorem ipsum',
    'lorem ipsum',
    'lorem ipsum',
    AppStrings.test,
  ];

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {},
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
      body: Padding(
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
              Text(
                'Select a group',
                textAlign: TextAlign.left,
                style: context.body2.copyWith(
                  fontSize: 12,
                ),
              ),
              8.height,

              ///user group horizontal scroll
              ///I think it should have radio function to enable selecting just one at a time.
              ///no function implemented yet
              SizedBox(
                height: 40.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: userGroups.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                      child: RoundedTile(groupName: userGroups[index]),
                    );
                  },
                ),
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

              ///start date row
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
                                        final text = "${_startDateController!.toLocal()}".split(' ')[0];

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
                            final TimeOfDay? pickedTime = await showTimePicker(
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
                                      if (_startDateStartTimeController != null) {
                                        final text = _startDateStartTimeController!.format(context);

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
                            final TimeOfDay? pickedTime = await showTimePicker(
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
                                      if (_startDateEndTimeController != null) {
                                        final text = _startDateEndTimeController!.format(context);

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

              ///End date
              Text(
                'End of event (if event is more than a day)',
                style: context.body2.copyWith(
                  color: AppColors.designBlack3,
                  fontSize: 12,
                ),
              ),

              ///End date row
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
                                        final text = "${_endDateController!.toLocal()}".split(' ')[0];

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
                            final TimeOfDay? pickedTime = await showTimePicker(
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
                                      if (_endDateStartTimeController != null) {
                                        final text = _endDateStartTimeController!.format(context);

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
                            final TimeOfDay? pickedTime = await showTimePicker(
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
                                      if (_endDateEndTimeController != null) {
                                        final text = _endDateEndTimeController!.format(context);

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

              ///Location editor
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

              ///Event Icon
              Text(
                'Choose an icon',
                style: context.body2.copyWith(
                  fontSize: 12,
                ),
              ),
              8.height,

              ///Event Icon Row
              ///having issues inserting the required images
              Row(children: [
                Container(
                  height: 76.0,
                  width: 76.0,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: AppColors.darkGrey2,
                  ),
                  child: const Svg(
                    image: AppImages.techiesIcon,
                  ),
                ),
                const SizedBox(width: 12.0),
                Container(
                  height: 76.0,
                  width: 76.0,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: AppColors.darkGrey2,
                  ),
                  child: const Svg(
                    image: AppImages.techiesIcon,
                  ),
                ),
                12.width,
                ClickWidget(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add,
                        color: AppColors.designOrange,
                      ),
                      7.width,
                      Text(
                        "Add from\nGallery",
                        style: context.body1.copyWith(
                          fontSize: 12,
                          color: AppColors.designOrange,
                        ),
                      ),
                    ],
                  ),
                )
              ]),
              const Spacer(),

              CustomButton(
                radius: 32,
                backgroundColor: AppColors.darkBlue1,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {}
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
              ),

              48.height,
            ],
          ),
        ),
      ),
    );
  }
}
