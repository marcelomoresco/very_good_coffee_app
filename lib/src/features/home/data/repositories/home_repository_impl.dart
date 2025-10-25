import 'package:coffee_venture_app/src/core/errors/failure.dart';
import 'package:coffee_venture_app/src/features/home/data/datasources/home_local_datasource.dart';
import 'package:coffee_venture_app/src/features/home/data/datasources/home_remote_datasource.dart';
import 'package:coffee_venture_app/src/features/home/domain/entities/coffee.dart';
import 'package:coffee_venture_app/src/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl({required this.remoteDataSource, required this.localDataSource});
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;

  @override
  Future<Either<BaseException, Coffee>> fetchRandomCoffeeImage() async {
    try {
      final coffee = await remoteDataSource.fetchRandomCoffeeImageUrl();
      return Right(coffee);
    } on BaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<BaseException, List<Coffee>>> fetchLocalCoffeesImage() async {
    try {
      final coffee = await localDataSource.fetchLocalCoffeesImage();
      return Right(coffee);
    } on BaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<BaseException, void>> saveFavoriteCoffeeImage(Coffee coffee) async {
    try {
      final result = await localDataSource.saveFavoriteCoffeeImage(coffee);
      return Right(result);
    } on BaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<BaseException, bool>> isFavoriteCoffee(Coffee coffee) async {
    try {
      final result = await localDataSource.isFavoriteCoffee(coffee.imageUrl);
      return Right(result);
    } on BaseException catch (e) {
      return Left(e);
    }
  }
}
