import 'package:flutter/material.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/component/widgets/click_button.dart';

class AddPeopleButton extends StatelessWidget {
  const AddPeopleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClickWidget(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.add,
            size: 12,
            color: AppColors.designOrange,
          ),
          const SizedBox(width: 7),
          SizedBox(
            width: 62,
            child: Text(
              'Add people',
              style: context.body1.copyWith(
                color: AppColors.designOrange,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
