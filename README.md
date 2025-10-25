# ☕ Very Good Coffee App

A Flutter app that lets users view random coffee images from an API and save their favorites locally for offline access.

## 🛠️ Tech Stack

- Flutter: 3.35.4
- State Management: flutter_bloc
- Architecture: Cubit + clean modular structure
- Design System: custom, inspired by Atomic Design
- Testing: unit and widget tests with coverage support

## 🛠️ Getting Started

```dart
flutter pub get
flutter run
```

## Run Tests with Coverage

```dart
flutter test --coverage --test-randomize-ordering-seed random
genhtml coverage/lcov.info -o coverage/
open coverage/index.html
```
