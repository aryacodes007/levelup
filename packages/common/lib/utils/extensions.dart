extension ColorOpacityExtension on num {
  int get opacity => (this * 255).round();
}