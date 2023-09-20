import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hurricane_events/component/utils/extensions.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final String imgPath;
  final Function()? onTap;

  const SettingTile({
    super.key,
    required this.title,
    required this.imgPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          title: Row(
            children: [
              SizedBox(
                width: 15,
                height: 15,
                child: Image.asset(imgPath),
              ),
              const Gap(10),
              Text(
                title,
                style: context.body2.copyWith(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
          ),
        ),
        const Divider(
          height: 1,
          indent: 0,
          endIndent: 2,
        ),
      ],
    );
  }
}
