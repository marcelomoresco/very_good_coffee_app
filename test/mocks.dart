import 'package:coffee_venture_app/src/core/client/base_dio.dart';
import 'package:coffee_venture_app/src/core/db/coffee_local_storage.dart';
import 'package:coffee_venture_app/src/core/errors/failure.dart';
import 'package:coffee_venture_app/src/features/home/data/datasources/home_local_datasource.dart';
import 'package:coffee_venture_app/src/features/home/data/datasources/home_remote_datasource.dart';
import 'package:coffee_venture_app/src/features/home/domain/repositories/home_repository.dart';
import 'package:coffee_venture_app/src/features/home/domain/usecases/get_all_favorite_images_usecase.dart';
import 'package:coffee_venture_app/src/features/home/domain/usecases/get_random_coffee_image_usecase.dart';
import 'package:coffee_venture_app/src/features/home/domain/usecases/save_favorite_coffee_image_usecase.dart';
import 'package:coffee_venture_app/src/features/home/presentation/cubits/favorites_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

class MockHomeRemoteDataSource extends Mock implements HomeRemoteDataSource {}

class MockHomeLocalDataSource extends Mock implements HomeLocalDataSource {}

class MockBaseDio extends Mock implements BaseDio {}

class MockGetAllFavoriteImagesUsecase extends Mock implements GetAllFavoriteImagesUsecase {}

class MockGetRandomCoffeeImageUsecase extends Mock implements GetRandomCoffeeImageUsecase {}

class MockSaveFavoriteCoffeeImageUsecase extends Mock implements SaveFavoriteCoffeeImageUsecase {}

class MockFavoritesCubit extends Mock implements FavoritesCubit {}

class MockCoffeeLocalStorage extends Mock implements CoffeeLocalStorage {}

class FakeFailure extends BaseException {
  const FakeFailure(String message) : super(message: message);
}
