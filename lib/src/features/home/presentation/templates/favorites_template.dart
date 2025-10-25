import 'package:coffee_venture_app/src/features/home/domain/entities/coffee.dart';
import 'package:coffee_venture_app/src/features/home/presentation/molecules/coffee_image.dart';
import 'package:flutter/widgets.dart';

class FavoritesTemplate extends StatelessWidget {
  const FavoritesTemplate({super.key, required this.coffees});
  final List<Coffee> coffees;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: coffees.length,
      itemBuilder: (context, index) {
        final Coffee coffee = coffees[index];
        return CoffeeImage(imageUrl: coffee.imageUrl, showFavoriteIcon: true, borderRadius: 12);
      },
    );
  }
}
