// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/component/widgets/click_button.dart';

@immutable
class CustomTextField extends StatefulWidget {
  final bool? inputlabelPresent;
  final String? labelText;
  final String? hintText;
  final bool? filled;
  final TextEditingController? controller;
  final FocusNode? focus;
  final String? Function(String?)? validator;
  bool? obscureText;
  final bool? enabled;
  final bool? suffix;
  final int? maxLines;
  final Widget? suffixIcon;
  final String? errorText;
  final Function(String)? onChanged;
  Function(bool)? external;

  CustomTextField({
    super.key,
    this.inputlabelPresent,
    this.labelText,
    this.hintText,
    this.filled,
    this.validator,
    this.controller,
    this.focus,
    this.obscureText,
    this.suffix,
    this.errorText,
    this.onChanged,
    this.external,
    this.suffixIcon,
    this.maxLines,
    this.enabled,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: widget.focus!.hasFocus
              ? const EdgeInsets.all(2.5)
              : widget.errorText != null
                  ? const EdgeInsets.all(0.3)
                  : const EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: widget.errorText != null ? AppColors.designRed : AppColors.designGrey,
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focus,
            onChanged: widget.onChanged,
            cursorColor: Colors.black,
            enabled: widget.enabled,
            style: context.test.copyWith(
              color: Colors.black.withOpacity(.7),
              fontSize: 14,
            ),
            obscureText: widget.obscureText ?? false,
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            validator: widget.validator,
            obscuringCharacter: "*",
            cursorHeight: 16,
            maxLines: widget.maxLines ?? 1,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              filled: widget.filled,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(14),
              hintText: widget.hintText,
              errorMaxLines: 1,
              hintStyle: context.body2.copyWith(
                color: Colors.black.withOpacity(.4),
                fontSize: 14,
              ),
              errorStyle: const TextStyle(
                color: Colors.transparent,
                fontSize: 0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.designGrey,
                  width: 0.5,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.designRed,
                  width: 0.0,
                ),
              ),
              suffixIcon: widget.suffixIcon,
              focusedBorder: widget.errorText != null
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.designRed,
                        width: 0.1,
                      ),
                    )
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.darkBlue1,
                        width: 0.1,
                      ),
                    ),
            ),
          ),
        ),
        8.height,
        Builder(
          builder: (_) {
            if (widget.errorText == null) {
              return const SizedBox.shrink();
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline_outlined,
                  color: AppColors.designRed,
                  size: 14,
                ),
                4.width,
                Text(
                  widget.errorText!,
                  style: context.body2.copyWith(
                    color: AppColors.designRed,
                    fontSize: 12,
                  ),
                )
              ],
            );
          },
        ),
      ],
    );
  }
}

@immutable
class CustomTextField2 extends StatefulWidget {
  final bool? inputlabelPresent;
  final String? labelText;
  final String? hintText;
  final bool? filled;
  final TextEditingController? controller;
  final FocusNode? focus;
  final String? Function(String?)? validator;
  final Color? fillColor;
  bool? obscureText;
  final bool? suffix;
  final int? maxLines;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final String? errorText;
  final Function(String)? onChanged;
  Function()? onTap;

  CustomTextField2({
    super.key,
    this.inputlabelPresent,
    this.labelText,
    this.hintText,
    this.filled,
    this.validator,
    this.controller,
    this.focus,
    this.obscureText,
    this.suffix,
    this.errorText,
    this.onChanged,
    this.onTap,
    this.suffixIcon,
    this.maxLines,
    this.fillColor,
    this.textInputType,
  });

  @override
  State<CustomTextField2> createState() => _CustomTextField2State();
}

class _CustomTextField2State extends State<CustomTextField2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,
          focusNode: widget.focus,
          onChanged: widget.onChanged,
          keyboardType: widget.textInputType,
          cursorColor: Colors.black.withOpacity(.5),
          style: context.test.copyWith(
            color: Colors.black.withOpacity(.7),
            fontSize: 14,
          ),
          obscureText: widget.obscureText ?? false,
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          obscuringCharacter: "*",
          cursorHeight: 16,
          maxLines: widget.maxLines ?? 1,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: widget.filled,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(14),
            hintText: widget.hintText,
            errorMaxLines: 1,
            hintStyle: context.body2.copyWith(
              color: Colors.black.withOpacity(.4),
              fontSize: 14,
            ),
            errorStyle: const TextStyle(
              color: Colors.transparent,
              fontSize: 0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.black.withOpacity(.3),
                width: 0.1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.designRed,
                width: 0.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.black.withOpacity(.3),
                width: 0.1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.black.withOpacity(.3),
                width: 0.1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.black.withOpacity(.3),
                width: 0.1,
              ),
            ),
            suffixIcon: widget.suffixIcon,
            prefixIcon: ClickWidget(
              onTap: widget.onTap,
              child: const Icon(
                Icons.camera_alt_outlined,
                size: 16,
                color: AppColors.darkBlue1,
              ),
            ),
          ),
        ),
        8.height,
      ],
    );
  }
}
