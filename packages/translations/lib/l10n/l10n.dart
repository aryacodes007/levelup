import 'package:flutter/material.dart';
import 'arb/app_localizations.dart';
export 'arb/app_localizations.dart';

/// Extension on [BuildContext] for easier access to [AppLocalizations].
///
/// Usage:
/// // Instead of:
/// AppLocalizations.of(context).hello;
///
/// // You can simply write:
/// context.l10n.hello;
extension AppLocalizationsExt on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
