import 'package:coffee_venture_app/src/features/home/domain/entities/coffee.dart';

abstract class CoffeeLocalStorage {
  Future<void> addFavorite(Coffee coffee);
  Future<void> removeFavorite(String imageUrl);
  Future<List<Coffee>> getFavorites();
  Future<bool> isFavorite(String imageUrl);
}
