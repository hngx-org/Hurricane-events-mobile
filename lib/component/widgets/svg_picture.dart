// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Svg extends StatelessWidget {
  final String image;
  final Color? color;
  const Svg({
    super.key,
    required this.image,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image,
      color: color,
      placeholderBuilder: (context) {
        return const SizedBox.shrink();
      },
    );
  }
}
