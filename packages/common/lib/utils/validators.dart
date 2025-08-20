/// [Validators]
///
/// A utility class that provides common form field validators.
///
/// Features:
/// - [empty] → Validates if a string is empty and returns the given error message.
class Validators {
  // Empty String Validator
  static String? empty({
    String? value,
    String? errorMessage,
  }) {
    return (value ?? '').isEmpty ? errorMessage : null;
  }
}
