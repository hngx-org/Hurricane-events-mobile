
import 'package:flutter/material.dart';

class AddPeopleChip extends StatelessWidget {
  const AddPeopleChip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: ShapeDecoration(
        color: const Color(0xFFE5F2FF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '@Just_Igboji',
            style: TextStyle(
              color: Color(0xFF252525),
              fontSize: 12,
              fontFamily: 'Work Sans',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          SizedBox(width: 8),
          Icon(
            Icons.close,
            size: 12,
          ),
        ],
      ),
    );
  }
}