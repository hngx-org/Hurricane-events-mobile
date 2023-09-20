import 'package:flutter/material.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/utils/extensions.dart';

class RoundedTile extends StatelessWidget {
  const RoundedTile({super.key, required this.groupName});

  final String groupName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.darkGrey2,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          groupName,
          style: context.body2.copyWith(
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
