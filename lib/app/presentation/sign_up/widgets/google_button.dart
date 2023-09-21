import 'package:flutter/material.dart';
import 'package:hurricane_events/component/constants/images.dart';
import 'package:hurricane_events/component/widgets/custom_button.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    super.key,
    required this.onTap,
  });
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: onTap,
      radius: 32,
      backgroundColor: const Color(0xFFE5F2FF),
      buttonWidget: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppImages.googleIcon),
            const SizedBox(width: 16),
            const Text(
              'Continue with Google',
              style: TextStyle(
                color: Color(0xFF0084FF),
                fontSize: 16,
                fontFamily: 'Work Sans',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
