import 'package:coffee_venture_app/src/core/errors/failure.dart';
import 'package:coffee_venture_app/src/core/helpers/usecase/base_usecase.dart';
import 'package:coffee_venture_app/src/features/home/domain/entities/coffee.dart';
import 'package:coffee_venture_app/src/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllFavoriteImagesUsecase extends UseCase<List<Coffee>, NoParams> {
  GetAllFavoriteImagesUsecase({required this.homeRepository});
  final HomeRepository homeRepository;

  @override
  Future<Either<BaseException, List<Coffee>>> call([NoParams? params]) async {
    return homeRepository.fetchLocalCoffeesImage();
  }
}
