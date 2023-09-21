import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/utils/extensions.dart';

class CommentType extends StatelessWidget {
  final String commentType;
  final bool isSelected;
  final VoidCallback onTap;

  const CommentType({
    super.key,
    required this.commentType,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lightBlue2 : Colors.transparent,
          border: isSelected
              ? const Border(
                  top: BorderSide(
                    width: 1,
                    color: AppColors.designGrey,
                  ),
                  bottom: BorderSide(
                    width: 1,
                    color: AppColors.designGrey,
                  ),
                )
              : const Border(
                  bottom: BorderSide(
                  width: 1,
                  color: AppColors.designGrey,
                )),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              commentType,
              style: context.body3.copyWith(
                color: isSelected ? AppColors.designBlack1 : Colors.black,
                fontSize: 18,
              ),
            ),
            SvgPicture.asset(
              isSelected
                  ? "assets/icons/icon_drop_down.svg"
                  : "assets/icons/icon_forward_arrow.svg",
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
