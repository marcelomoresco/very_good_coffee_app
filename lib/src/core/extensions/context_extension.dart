import 'package:coffee_venture_app/src/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  AppLocalizations get intl => AppLocalizations.of(this)!;
}
