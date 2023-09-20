import 'package:flutter/material.dart';
import 'package:hurricane_events/app/presentation/home/my_group/widgets/group_card.dart';
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
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
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
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final group = myGroupSampleData[index];
                  return MyGroupCard(
                    title: group.title!,
                    numberOfEvent: group.numOfEvent!,
                    numberOfPeople: group.numOfPeople!,
                  );
                },
                separatorBuilder: (context, index) {
                  return 16.height;
                },
                itemCount: myGroupSampleData.length,
              ),
            ),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            //TODO: Navigate to add group screen
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          backgroundColor: AppColors.darkBlue1,
          extendedPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
