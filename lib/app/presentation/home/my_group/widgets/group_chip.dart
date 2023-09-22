import 'package:flutter/material.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/utils/extensions.dart';

class MyGroupChip extends StatelessWidget {
  const MyGroupChip({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: ShapeDecoration(
        color: AppColors.opacityOrange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        title,
        style: context.body1.copyWith(
          fontSize: 12,
          color: Colors.orange,
        ),
      ),
    );
  }
}
