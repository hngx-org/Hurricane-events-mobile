import 'package:flutter/material.dart';
import 'package:hurricane_events/component/utils/extensions.dart';

class AddPeopleChip extends StatelessWidget {
  final String text;
  final Function() onTap;
  const AddPeopleChip({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: ShapeDecoration(
        color: const Color(0xFFE5F2FF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: context.body2.copyWith(
              fontSize: 12,
              color: const Color(0xFF252525),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: onTap,
            child: const Icon(
              Icons.close,
              size: 12,
            ),
          )
        ],
      ),
    );
  }
}
