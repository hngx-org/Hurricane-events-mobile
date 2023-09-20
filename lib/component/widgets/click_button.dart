import 'package:flutter/material.dart';

class ClickWidget extends StatelessWidget {
  final Function()? onTap;
  final Color? color;
  final Widget child;

  const ClickWidget({
    super.key,
    this.onTap,
    this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: MaterialStatePropertyAll(color ?? Colors.transparent),
      child: child,
    );
  }
}
