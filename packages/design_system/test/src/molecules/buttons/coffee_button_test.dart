import 'package:design_system/src/core/colors/app_colors.dart';
import 'package:design_system/src/molecules/buttons/coffee_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      extensions: const [
        AppColors(primary: Color(0xFF111111), background: Color(0xFFFFFFFF), secondary: Color(0xFFE0A96D)),
      ],
    ),
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  testWidgets('renders label and triggers onPressed when not loading', (tester) async {
    var tapped = false;

    await tester.pumpWidget(_wrap(CoffeeButton(text: 'Add', onPressed: () => tapped = true)));

    expect(find.text('Add'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(tapped, isTrue);
  });

  testWidgets('shows CircularProgressIndicator and disables when loading', (tester) async {
    var tapped = false;

    await tester.pumpWidget(_wrap(CoffeeButton(text: 'Loading', isLoading: true, onPressed: () => tapped = true)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Loading'), findsNothing);

    final elevated = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(elevated.onPressed, isNull);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(tapped, isFalse);
  });

  testWidgets('renders leading icon when using the .icon factory', (tester) async {
    await tester.pumpWidget(
      _wrap(CoffeeButton.icon(text: 'Favorite', icon: Icon(Icons.favorite_rounded), onPressed: () {})),
    );

    expect(find.text('Favorite'), findsOneWidget);
    expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);
  });

  testWidgets('uses ThemeExtension colors for text color (foreground)', (tester) async {
    await tester.pumpWidget(_wrap(CoffeeButton(text: 'Next', onPressed: () {})));

    final textWidget = tester.widget<Text>(find.text('Next'));
    final style = textWidget.style!;
    expect(style.color, const Color(0xFF111111));
  });

  testWidgets('respects custom backgroundColor when provided', (tester) async {
    const customBg = Color(0xFF123456);

    await tester.pumpWidget(_wrap(CoffeeButton(text: 'Custom BG', onPressed: () {}, backgroundColor: customBg)));

    final elevated = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    final ButtonStyle? style = elevated.style;

    final Color? resolvedBg = style?.backgroundColor?.resolve(<WidgetState>{});
    expect(resolvedBg, customBg);
  });
}
