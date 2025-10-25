import 'package:coffee_venture_app/src/core/errors/failure.dart';
import 'package:coffee_venture_app/src/features/home/domain/entities/coffee.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<BaseException, Coffee>> fetchRandomCoffeeImage();
  Future<Either<BaseException, List<Coffee>>> fetchLocalCoffeesImage();
  Future<Either<BaseException, void>> saveFavoriteCoffeeImage(Coffee coffee);
  Future<Either<BaseException, bool>> isFavoriteCoffee(Coffee coffee);
}
