import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// App page [transition] with [slide] for the next [screen] screen.
class AppPageTransition extends CustomTransitionPage {
  final BuildContext context;
  final Widget page;
  final GoRouterState state;

  /// Constructor for AppPageTransition.
  AppPageTransition({
    required this.context,
    required this.page,
    required this.state,
  }) : super(
          transitionDuration: const Duration(
            milliseconds: 500, // Set transition duration to 500 milliseconds
          ),
          key: state.pageKey, // Use the page key from GoRouterState
          child: page, // Display the child widgets
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              _slideTransition(
            animation,
            child,
            AxisDirection.right, // Slide transition from right to left
          ),
        );
}

/// Function for [creating] a [slide] transition [animation].
SlideTransition _slideTransition(
  Animation<double> animation,
  Widget child,
  AxisDirection direction,
) {
  return SlideTransition(
    // Define the position of the transition using Tween
    position: Tween<Offset>(
      begin: _getOffsets(direction), // Initial position based on direction
      end: Offset.zero, // Final position is zero (no offset)
    ).animate(
      // Apply curved animation for smoother transition
      CurvedAnimation(
        parent: animation,
        curve: Curves.fastOutSlowIn, // Use fastOutSlowIn curve
      ),
    ),
    child: child, // Display the child widget with the transition
  );
}

/// Helper [function] to get the [offset] based on the [direction].
Offset _getOffsets(AxisDirection direction) {
  switch (direction) {
    case AxisDirection.up:
      return const Offset(0, 1); // Slide up by 1 unit
    case AxisDirection.down:
      return const Offset(0, -1); // Slide down by 1 unit
    case AxisDirection.right:
      return const Offset(1, 0); // Slide right by 1 unit
    case AxisDirection.left:
      return const Offset(-1, 0); // Slide left by 1 unit
  }
}
