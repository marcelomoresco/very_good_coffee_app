import 'package:coffee_venture_app/src/core/errors/failure.dart';
import 'package:coffee_venture_app/src/core/helpers/usecase/base_usecase.dart';
import 'package:coffee_venture_app/src/features/home/data/exceptions/coffee_exceptions.dart';
import 'package:coffee_venture_app/src/features/home/domain/entities/coffee.dart';
import 'package:coffee_venture_app/src/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class SaveFavoriteCoffeeImageUsecase extends UseCase<void, Coffee> {
  SaveFavoriteCoffeeImageUsecase({required this.homeRepository});
  final HomeRepository homeRepository;

  @override
  Future<Either<BaseException, void>> call(Coffee coffee) async {
    final favoriteCheck = await homeRepository.isFavoriteCoffee(coffee);

    return favoriteCheck.fold((failure) => Left(failure), (isFavorite) async {
      if (isFavorite) {
        return Left(CoffeeSaveException(message: 'Coffee is already in favorites'));
      }
      return homeRepository.saveFavoriteCoffeeImage(coffee);
    });
  }
}
