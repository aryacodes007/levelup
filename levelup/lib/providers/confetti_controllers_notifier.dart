import 'package:confetti/confetti.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// StateNotifier that manages a collection of [ConfettiController]s,
/// one per habit, keyed by habitId.
///
/// Responsibilities:
/// - Lazily creates and caches a [ConfettiController] when requested.
/// - Disposes individual controllers when no longer needed.
/// - Ensures all controllers are properly disposed on notifier teardown.
///
/// Usage:
/// - Access via [confettiControllersProvider].
/// - Call [getController] with a habitId to obtain (or create) its controller.
/// - Call [disposeController] when a habit is deleted or no longer needs confetti.
///
/// Notes:
/// - Each controller runs for 700ms by default.
/// - Prevents memory leaks by disposing all controllers in [dispose].
class ConfettiControllersNotifier
    extends StateNotifier<Map<String, ConfettiController>> {
  ConfettiControllersNotifier() : super({});

  ConfettiController getController(String habitId) {
    return state.putIfAbsent(
      habitId,
      () => ConfettiController(duration: const Duration(milliseconds: 700)),
    );
  }

  void disposeController(String habitId) {
    state[habitId]?.dispose();
    state = Map.of(state)..remove(habitId);
  }

  @override
  void dispose() {
    for (final controller in state.values) {
      controller.dispose();
    }
    super.dispose();
  }
}

/// Riverpod provider exposing [ConfettiControllersNotifier].
///
/// Exposes the current map of active [ConfettiController]s.
final confettiControllersProvider = StateNotifierProvider<
    ConfettiControllersNotifier, Map<String, ConfettiController>>(
  (ref) => ConfettiControllersNotifier(),
);
