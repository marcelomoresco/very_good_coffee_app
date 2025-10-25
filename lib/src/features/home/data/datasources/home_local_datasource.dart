import 'package:coffee_venture_app/src/core/db/coffee_local_storage.dart';
import 'package:coffee_venture_app/src/features/home/domain/entities/coffee.dart';

abstract class HomeLocalDataSource {
  Future<List<Coffee>> fetchLocalCoffeesImage();
  Future<void> saveFavoriteCoffeeImage(Coffee coffee);
  Future<void> removeFavoriteCoffeeImage(String url);
  Future<bool> isFavoriteCoffee(String url);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  HomeLocalDataSourceImpl({required this.storage});
  final CoffeeLocalStorage storage;

  @override
  Future<List<Coffee>> fetchLocalCoffeesImage() async {
    try {
      return await storage.getFavorites();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveFavoriteCoffeeImage(Coffee coffee) async {
    await storage.addFavorite(coffee);
  }

  @override
  Future<void> removeFavoriteCoffeeImage(String url) async {
    await storage.removeFavorite(url);
  }

  @override
  Future<bool> isFavoriteCoffee(String url) async {
    return await storage.isFavorite(url);
  }
}
