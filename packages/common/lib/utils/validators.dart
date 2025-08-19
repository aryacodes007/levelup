class Validators {
  // Empty String Validator
  static String? empty({
    String? value,
    String? errorMessage,
  }) {
    return (value ?? '').isEmpty ? errorMessage : null;
  }
}
