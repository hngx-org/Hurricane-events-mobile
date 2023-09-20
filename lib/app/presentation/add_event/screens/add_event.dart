import 'package:flutter/material.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/app/presentation/add_event/widgets/user_groups_tiles.dart';
import 'package:hurricane_events/component/constants/app_strings.dart';

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
    AppStrings.test
  ];

  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  final TextEditingController _startDateStartTimeController =
      TextEditingController();
  final TextEditingController _endDateStartTimeController =
      TextEditingController();
  final TextEditingController _startDateEndTimeController =
      TextEditingController();
  final TextEditingController _endDateEndTimeController =
      TextEditingController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  TimeOfDay startDateStartTime = TimeOfDay.now();
  TimeOfDay endDateStartTime = TimeOfDay.now();
  TimeOfDay startDateEndTime = TimeOfDay.now();
  TimeOfDay endDateEndTime = TimeOfDay.now();

  ///function to select date using DateTime
  Future<void> _selectDate(
      {required BuildContext context,
      required DateTime selectedDate,
      required controller}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        controller.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }
  ///function to select time using TimeofDay
  Future<void> _selectTime(
      {required BuildContext context,
      required TimeOfDay selectedTime,
      required controller}) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
        controller.text = "${selectedTime.format(context)}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xAAFAFAFA),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text('Add Event'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///name of event textField
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 32.0, 0.0, 8.0),
              child: Text(
                'Name of Event',
                style: context.body1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Color(0xAAd9d9d9),
                      width: 1.0,
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: 'Enter name of event',
                  hintStyle:
                      context.body1.copyWith(color: const Color(0xAA84838B)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 24.0, 0.0, 8.0),
              child: Text(
                'Select a group',
                textAlign: TextAlign.left,
                style: context.body1,
              ),
            ),
            ///user group horizontal scroll
            ///I think it should have radio function to enable selecting just one at a time.
            ///no function implemented yet
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0.0, 0.0, 0.0),
              child: SizedBox(
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
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 24.0, 0.0, 8.0),
              child: Text(
                'Date of event',
                textAlign: TextAlign.left,
                style: context.body1,
              ),
            ),
            ///start date
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0.0, 0.0, 0.0),
              child: Text(
                'Start of event',
                style: context.body1.copyWith(color: const Color(0xAA737373)),
              ),
            ),
            ///start date row
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              child: SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextField(
                          style: context.body2.copyWith(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Start day',
                            hintStyle: context.body3.copyWith(
                              color: const Color(0xAA404040),
                            ),
                            border: InputBorder.none,
                            prefixIcon: const Icon(
                              Icons.calendar_month,
                              size: 13.0,
                            ),
                          ),
                          controller: _startDateController,
                          onTap: () {
                            _selectDate(
                              context: context,
                              selectedDate: startDate,
                              controller: _startDateController,
                            ); // Show date picker when tapped
                          },
                          readOnly: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        style: context.body2.copyWith(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Start time',
                          hintStyle: context.body3
                              .copyWith(color: const Color(0xAA404040)),
                          border: InputBorder.none,
                          prefixIcon: const Icon(
                            Icons.access_time_outlined,
                            size: 13.0,
                          ),
                        ),
                        controller: _startDateStartTimeController,
                        onTap: () {
                          _selectTime(
                              context: context,
                              selectedTime: startDateStartTime,
                              controller: _startDateStartTimeController);
                        },
                        readOnly: true,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        style: context.body2.copyWith(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'End time',
                          hintStyle: context.body3
                              .copyWith(color: const Color(0xAA404040)),
                          border: InputBorder.none,
                          prefixIcon: const Icon(
                            Icons.access_time_outlined,
                            size: 13.0,
                          ),
                        ),
                        controller: _startDateEndTimeController,
                        onTap: () {
                          _selectTime(
                              context: context,
                              selectedTime: startDateEndTime,
                              controller: _startDateEndTimeController);
                        },
                        readOnly: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ///End date
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0.0, 0.0, 0.0),
              child: Text(
                'End of event (if event is more than a day)',
                style: context.body1.copyWith(color: const Color(0xAA737373)),
              ),
            ),
            ///End date row
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              child: SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextField(
                          style: context.body2.copyWith(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'End day',
                            hintStyle: context.body3.copyWith(
                              color: const Color(0xAA404040),
                            ),
                            border: InputBorder.none,
                            prefixIcon: const Icon(
                              Icons.calendar_month,
                              size: 13.0,
                            ),
                          ),
                          controller: _endDateController,
                          onTap: () {
                            _selectDate(
                              context: context,
                              selectedDate: startDate,
                              controller: _endDateController,
                            );
                          },
                          readOnly: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        style: context.body2.copyWith(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Start time',
                          hintStyle: context.body3
                              .copyWith(color: const Color(0xAA404040)),
                          border: InputBorder.none,
                          prefixIcon: const Icon(
                            Icons.access_time_outlined,
                            size: 13.0,
                          ),
                        ),
                        controller: _endDateStartTimeController,
                        onTap: () {
                          _selectTime(
                              context: context,
                              selectedTime: endDateStartTime,
                              controller: _endDateStartTimeController);
                        },
                        readOnly: true,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        style: context.body2.copyWith(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'End time',
                          hintStyle: context.body3
                              .copyWith(color: const Color(0xAA404040)),
                          border: InputBorder.none,
                          prefixIcon: const Icon(
                            Icons.access_time_outlined,
                            size: 13.0,
                          ),
                        ),
                        controller: _endDateEndTimeController,
                        onTap: () {
                          _selectTime(
                              context: context,
                              selectedTime: endDateEndTime,
                              controller: _endDateEndTimeController);
                        },
                        readOnly: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ///Location editor
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0.0, 0.0, 8.0),
              child: Text(
                'Location',
                style: context.body1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Color(0xAAd9d9d9),
                      width: 1.0,
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: 'Enter location of event',
                  hintStyle:
                      context.body1.copyWith(color: const Color(0xAA84838B)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Use current location instead',
                  style: context.body2.copyWith(color: const Color(0xAA0085FF)),
                ),
              ),
            ),
            ///Event Icon
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0.0, 0.0, 8.0),
              child: Text(
                'Choose an icon',
                style: context.body1,
              ),
            ),
            ///Event Icon Row
            ///having issues inserting the required images
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                child: Row(children: [
                  Container(
                    height: 76.0,
                    width: 76.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0)),
                    // child: Image.asset(AppImages.legEventsIcon),
                    
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Container(
                    height: 76.0,
                    width: 76.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0)),
                    // child: Image.asset(AppImages.chatEventsIcon),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                ]),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xAA0085FF),
                          foregroundColor: const Color(0xAAfFffff)),
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text('Add Event')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
