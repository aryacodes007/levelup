import 'package:flutter/services.dart';

class TrimTextFormatters extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.startsWith(' ')
          ? newValue.text.replaceAll(' ', '')
          : newValue.text,
      selection: newValue.text.startsWith(' ')
          ? TextSelection.collapsed(
              offset: newValue.text.replaceAll(' ', '').length,
            )
          : newValue.selection,
    );
  }
}
