import 'package:flutter/material.dart';

class RoundedTile extends StatelessWidget {
  const RoundedTile({super.key, required this.groupName});

  final String groupName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0,
      height: 40.0,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xAAf2f2f2),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(groupName),
      ),
    );
  }
}