import 'package:common/common.dart';
import 'package:flutter/services.dart';

/// [InputFormattersList]
///
/// A utility class that groups reusable [TextInputFormatter]s
/// for text input across the app.
///
/// Currently includes:
/// - [TrimTextFormatters] → Removes leading spaces from input.
///
/// Example:
/// TextFormField(
///   inputFormatters: InputFormattersList.trim,
/// )
class InputFormattersList {
  // For numbers and decimal point
  static List<TextInputFormatter> trim = [
    TrimTextFormatters(),
  ];
}
