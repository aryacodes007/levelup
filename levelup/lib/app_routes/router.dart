import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:levelup/levelup.dart';

part 'navigation_service.dart';

/// A custom [AppRouter] widget that [provides] routing [functionality] for the [app].
class AppRouter extends ConsumerWidget {
  const AppRouter({super.key, required this.builder});

  final Widget Function(BuildContext, RouterConfig<Object>) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(_routerProvider);
    return builder(context, router);
  }
}
