import 'package:coffee_venture_app/src/features/home/domain/entities/coffee.dart';
import 'package:coffee_venture_app/src/features/home/presentation/molecules/coffee_image.dart';
import 'package:coffee_venture_app/src/features/home/presentation/templates/favorites_template.dart';
import 'package:design_system/src/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

ThemeData _testTheme() {
  return ThemeData(
    extensions: const <ThemeExtension<dynamic>>[
      AppColors(primary: Colors.white, secondary: Colors.brown, background: Colors.amber),
    ],
  );
}

Widget _wrap(Widget child) => MaterialApp(
  theme: _testTheme(),
  home: Scaffold(body: child),
);

void main() {
  group('FavoritesTemplate', () {
    testWidgets('renders a CoffeeImage for each item', (tester) async {
      final coffees = <Coffee>[
        Coffee(imageUrl: 'https://example.com/1.jpg'),
        Coffee(imageUrl: 'https://example.com/2.jpg'),
        Coffee(imageUrl: 'https://example.com/3.jpg'),
      ];

      await tester.pumpWidget(_wrap(FavoritesTemplate(coffees: coffees)));

      expect(find.byType(CoffeeImage), findsNWidgets(coffees.length));

      final widgets = find.byType(CoffeeImage).evaluate().map((e) => e.widget as CoffeeImage).toList();
      for (var i = 0; i < widgets.length; i++) {
        expect(widgets[i].imageUrl, coffees[i].imageUrl);
        expect(widgets[i].showFavoriteIcon, isTrue);
      }
    });

    testWidgets('renders nothing when list is empty', (tester) async {
      await tester.pumpWidget(_wrap(const FavoritesTemplate(coffees: [])));
      expect(find.byType(CoffeeImage), findsNothing);
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('uses expected GridDelegate configuration', (tester) async {
      await tester.pumpWidget(
        _wrap(
          FavoritesTemplate(
            coffees: [
              Coffee(imageUrl: 'a'),
              Coffee(imageUrl: 'b'),
            ],
          ),
        ),
      );

      final grid = tester.widget<GridView>(find.byType(GridView));
      expect(grid.padding, const EdgeInsets.all(16));

      final delegate = grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, 2);
      expect(delegate.crossAxisSpacing, 12);
      expect(delegate.mainAxisSpacing, 12);
    });
  });
}
