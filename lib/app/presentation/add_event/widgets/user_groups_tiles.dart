import 'package:flutter/material.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/data/models/groups/group_details.dart';

class RoundedTile extends StatelessWidget {
  const RoundedTile({
    super.key,
    required this.group,
    this.isSelected,
  });

  final GroupDetails group;

  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected == true ? AppColors.lightBlue1 : AppColors.darkGrey2,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          group.title ?? "",
          style: context.body2.copyWith(
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
