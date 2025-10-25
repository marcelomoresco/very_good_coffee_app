import 'package:coffee_venture_app/src/features/home/presentation/molecules/coffee_image.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

ThemeData _testTheme() {
  return ThemeData(
    extensions: const <ThemeExtension<dynamic>>[
      AppColors(primary: Colors.brown, secondary: Colors.white, background: null),
    ],
  );
}

Widget _wrap(Widget child) => MaterialApp(
  theme: _testTheme(),
  localizationsDelegates: const [
    DefaultWidgetsLocalizations.delegate,
    DefaultMaterialLocalizations.delegate,
    DefaultCupertinoLocalizations.delegate,
  ],
  home: Scaffold(body: Center(child: child)),
);

void main() {
  group('CoffeeImage', () {
    testWidgets('shows placeholder while loading', (tester) async {
      await tester.pumpWidget(_wrap(const CoffeeImage(imageUrl: 'https://example.com/image.jpg')));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(
        find.byWidgetPredicate((w) {
          return w is Container && w.alignment == Alignment.center;
        }),
        findsWidgets,
      );
    });
    testWidgets('shows favorite icon overlay when showFavoriteIcon = true', (tester) async {
      await tester.pumpWidget(
        _wrap(const CoffeeImage(imageUrl: 'https://example.com/image.jpg', showFavoriteIcon: true)),
      );

      expect(find.byIcon(Icons.favorite), findsOneWidget);

      final icon = tester.widget<Icon>(find.byIcon(Icons.favorite));
      expect(icon.color, Colors.brown);
    });
  });
}
