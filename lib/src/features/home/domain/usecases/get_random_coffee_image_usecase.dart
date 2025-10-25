import 'package:coffee_venture_app/src/core/errors/failure.dart';
import 'package:coffee_venture_app/src/core/helpers/usecase/base_usecase.dart';
import 'package:coffee_venture_app/src/features/home/domain/entities/coffee.dart';
import 'package:coffee_venture_app/src/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class GetRandomCoffeeImageUsecase extends UseCase<Coffee, NoParams> {
  GetRandomCoffeeImageUsecase({required this.homeRepository});
  final HomeRepository homeRepository;

  @override
  Future<Either<BaseException, Coffee>> call([NoParams? params]) async {
    final resultRandomCoffeeImage = await homeRepository.fetchRandomCoffeeImage();

    if (resultRandomCoffeeImage.isLeft()) return resultRandomCoffeeImage;

    final Coffee randomCoffee = (resultRandomCoffeeImage as Right).value;
    final resultIsFavorite = await homeRepository.isFavoriteCoffee(randomCoffee);

    return await resultIsFavorite.fold((failure) => Left(failure), (isFavorite) async {
      if (isFavorite) {
        return call();
      }

      return Right(randomCoffee);
    });
  }
}
