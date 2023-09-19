import 'package:flutter/material.dart';
import 'package:hurricane_events/app/presentation/my_group/widgets/group_card.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/data/models/groups/group_mock_up.dart';

final myGroupSampleData = [
  GroupMockUp(title: "YBNL Mafia", numOfEvent: 5, numOfPeople: 35),
  GroupMockUp(title: "Hangouts", numOfEvent: 20, numOfPeople: 33),
];

class GroupScreen extends StatelessWidget {
  static const String routeName = "my_group";
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          12.height,
          Text(
            "My Group",
            textAlign: TextAlign.center,
            style: context.headline3.copyWith(
              fontSize: 16,
            ),
          ),
          40.height,
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: List.generate(
                2,
                (index) {
                  final group = myGroupSampleData[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: MyGroupCard(
                      title: group.title!,
                      numberOfEvent: group.numOfEvent!,
                      numberOfPeople: group.numOfPeople!,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            //TODO: Navigate to add group screen
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          backgroundColor: AppColors.darkBlue1,
          extendedPadding:
              const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          label: Row(
            children: [
              const Icon(
                Icons.add,
                color: Colors.white,
              ),
              10.width,
              Text(
                "Add Group",
                style: context.button2.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
              )
            ],
          )),
    );
  }
}
