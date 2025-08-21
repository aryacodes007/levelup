import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:levelup/levelup.dart';

/// [AddHabitScreen]
/// A screen (bottom sheet / dialog style) for creating or editing a [Habit].
///
/// Features:
/// - Allows users to enter a habit name (with validation).
/// - Lets users pick a color using a color picker dialog.
/// - Lets users pick an emoji using a custom emoji keyboard.
/// - Provides a preview of the habit with the chosen color and emoji.
/// - Supports both **add** (new habit) and **edit** (existing habit) flows.
///
/// State Management:
/// - Uses Riverpod [StateProvider] for managing temporary color and emoji state.
/// - Interacts with [habitsProvider] to persist changes.
/// - Pre-fills data when editing an existing habit.
///
/// UI Components:
/// - [LabeledWidget] for labeled input fields.
/// - [PrimaryTextFormField] for habit name input.
/// - [EmojiView] for emoji/color display and preview.
/// - Elevated save button to persist habit changes.
class AddHabitScreen extends ConsumerStatefulWidget {
  final Habit? editHabit;

  const AddHabitScreen({
    super.key,
    this.editHabit,
  });

  @override
  ConsumerState<AddHabitScreen> createState() => _AddHabitScreenState();
}

/// State class for [AddHabitScreen].
///
/// Handles:
/// - Initializing form values for add/edit flows.
/// - Managing local state providers for color and emoji.
/// - Picking emoji and colors.
/// - Saving the habit to the repository via [habitsProvider].
class _AddHabitScreenState extends ConsumerState<AddHabitScreen> {
  final _nameController = TextEditingController();
  final _colorValueStateProvider = StateProvider<int>(
    (ref) => 0xFF2196F3,
  );

  final _emojiStateProvider = StateProvider<String>(
    (ref) => AppConst.defaultEmoji,
  );

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      if (widget.editHabit != null) {
        final editHabit = widget.editHabit;
        _nameController.text = editHabit?.title ?? '';
        ref.read(_colorValueStateProvider.notifier).state =
            editHabit?.colorValue ?? ref.read(_colorValueStateProvider);
        ref.read(_emojiStateProvider.notifier).state =
            editHabit?.emoji ?? ref.read(_emojiStateProvider);
      }
    });
  }

  void _pickEmoji({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    ServiceUtils.showEmojiKeyboard(
      context: context,
      onEmojiSelected: (emoji) {
        ref.read(_emojiStateProvider.notifier).state = emoji;
      },
    );
  }

  Future<void> _pickColor() async {
    final currentColor = Color(ref.read(_colorValueStateProvider));

    Color? pickedColor = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Pick a color',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          content: BlockPicker(
            pickerColor: currentColor,
            onColorChanged: (color) => context.pop(color),
          ),
        );
      },
    );

    if (pickedColor != null) {
      final colorValue = pickedColor.toARGB32();
      ServiceUtils.logs('Color value: $colorValue');
      ref.read(_colorValueStateProvider.notifier).state = colorValue;
    }
  }

  void _saveHabit({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final isValidate = _formKey.currentState?.validate() ?? false;

    if (!isValidate) return;

    final habitId = widget.editHabit?.id;
    final title = _nameController.text.trim();
    final colorValue = ref.read(_colorValueStateProvider);
    final emoji = ref.read(_emojiStateProvider);

    await ref.read(habitsProvider.notifier).addUpdateHabit(
          id: habitId,
          title: title,
          colorValue: colorValue,
          emoji: emoji,
        );

    context.pop();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).appColors;
    final appLocal = context.l10n;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appLocal.addNewHabit,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: colors.accent1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: context.pop,
                  icon: Icon(
                    Icons.close,
                    size: 24.w,
                  ),
                ),
              ],
            ),
            Divider(
              color: colors.primaryText.withAlpha(0.4.opacity),
              thickness: 0.8.h,
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: LabeledWidget(
                title: appLocal.habitName,
                isRequired: true,
                child: PrimaryTextFormField(
                  controller: _nameController,
                  hintText: appLocal.addNewHabit,
                  validator: (value) => Validators.empty(
                    value: value,
                    errorMessage: appLocal.emptyHabitName,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pick a Color
                LabeledWidget(
                  title: appLocal.pickColor,
                  child: Consumer(
                    builder: (context, ref, child) {
                      final colorValue = ref.watch(_colorValueStateProvider);
                      return EmojiView(
                        color: Color(colorValue),
                        pickColor: _pickColor,
                      );
                    },
                  ),
                ),

                // Pick Emoji
                LabeledWidget(
                  title: appLocal.pickEmoji,
                  child: Consumer(
                    builder: (context, ref, child) {
                      final emoji = ref.watch(_emojiStateProvider);

                      return GestureDetector(
                        onTap: () => _pickEmoji(
                          context: context,
                          ref: ref,
                        ),
                        behavior: HitTestBehavior.translucent,
                        child: EmojiView(
                          size: 58,
                          emoji: emoji,
                        ),
                      );
                    },
                  ),
                ),

                // Preview
                LabeledWidget(
                  title: appLocal.preview,
                  child: Consumer(
                    builder: (context, ref, child) {
                      final colorValue = ref.watch(_colorValueStateProvider);
                      final emoji = ref.watch(_emojiStateProvider);

                      return EmojiView(
                        color: Color(colorValue),
                        emoji: emoji,
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: double.infinity,
              child: Consumer(
                builder: (context, ref, child) {
                  return ElevatedButton(
                    onPressed: () => _saveHabit(
                      context: context,
                      ref: ref,
                    ),
                    child: Text(
                      appLocal.saveHabit,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
