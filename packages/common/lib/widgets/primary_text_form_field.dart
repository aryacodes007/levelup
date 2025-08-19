import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  const PrimaryTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).appColors;

    // Define the border and focus border colors
    final border = _outlineInputBorder(
      colors.accent1.withOpacity(0.6),
    );
    final focusBorder = _outlineInputBorder(
      colors.accent1,
    );

    return TextFormField(
      controller: controller,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: InputFormattersList.trim,
      maxLength: 50,
      onTapUpOutside: (_) => ServiceUtils.keyboardClosed(),
      onTapOutside: (_) => ServiceUtils.keyboardClosed(),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: colors.primaryText.withAlpha(
            0.6.opacity,
          ),
        ),
        errorStyle: TextStyle(
          fontSize: 12.sp,
        ),
        contentPadding: EdgeInsets.all(12.w),
        enabledBorder: border,
        border: border,
        focusedBorder: focusBorder,
        focusedErrorBorder: focusBorder,
      ),
    );
  }

  // Defines the outline input border.
  OutlineInputBorder _outlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.w),
      borderSide: BorderSide(
        color: color,
        width: 1.1.w,
      ),
    );
  }
}
