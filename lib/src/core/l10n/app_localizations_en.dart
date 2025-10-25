// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get coffee => 'Coffee';

  @override
  String get coffeeSave => 'Save';

  @override
  String get coffeeNext => 'Next';

  @override
  String get favorites => 'Favorites';

  @override
  String get favoritesEmptyTitle => 'No favorites yet';

  @override
  String get favoritesEmptyDescription =>
      'You don\'t have any favorite images yet.\nWhen you do, they\'ll show up here.';

  @override
  String get favoritesSaveError => 'An error occurred while saving favorite.';

  @override
  String get errorTitle => 'An error occurred.';

  @override
  String get somethingWentWrong => 'Something went wrong, while using the app.';

  @override
  String get tryAgain => 'Try Again';

  @override
  String errorMessage(Object message) {
    return 'Error: $message';
  }
}
