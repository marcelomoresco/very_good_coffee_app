# ☕ Very Good Coffee App

A Flutter app that lets users view random coffee images from an API and save their favorites locally for offline access.

This project was developed in 1 day as part of the Very Good Ventures code challenge, focusing on clean architecture, maintainability, and developer experience.

## Tech Stack

- Flutter: 3.35.4
- State Management: flutter_bloc
- Architecture: Cubit + clean modular structure
- Design System: custom, inspired by Atomic Design
- Testing: unit and widget tests with coverage support

## Getting Started

```dart
flutter pub get
flutter gen-l10n
flutter run
```

## Run Tests with Coverage

```dart
flutter test --coverage --test-randomize-ordering-seed random
genhtml coverage/lcov.info -o coverage/
open coverage/index.html
```

## Demo

https://github.com/user-attachments/assets/cb1d195d-5778-4a22-aac2-7778cfcb2ebe


## Structure

```
lib/
├── core/            # shared helpers, mixins, templates, and utilities
├── features/        # feature-based modules (e.g., home, favorites)
└── design_system/   # reusable UI components built following Atomic Design
```


## Summary

The app follows Clean Architecture principles and uses flutter_modular to organize the project and allow easy scalability for future modules.

State management is handled with flutter_bloc (Cubit), providing predictable state flows and robust error handling.
If given more time, improvements would include:

- A more robust error handling layer
- Additional unit, widget, and integration tests
- Environment-specific configurations using flavors
- A proper logging system for debugging and analytics
