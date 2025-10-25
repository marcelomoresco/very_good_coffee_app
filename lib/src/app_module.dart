import 'package:coffee_venture_app/src/core/client/base_dio.dart';
import 'package:coffee_venture_app/src/core/db/coffee_local_storage.dart';
import 'package:coffee_venture_app/src/core/db/coffee_local_storage_impl.dart';
import 'package:coffee_venture_app/src/features/home/data/datasources/home_local_datasource.dart';
import 'package:coffee_venture_app/src/features/home/data/datasources/home_remote_datasource.dart';
import 'package:coffee_venture_app/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:coffee_venture_app/src/features/home/domain/repositories/home_repository.dart';
import 'package:coffee_venture_app/src/features/home/domain/usecases/get_all_favorite_images_usecase.dart';
import 'package:coffee_venture_app/src/features/home/domain/usecases/get_random_coffee_image_usecase.dart';
import 'package:coffee_venture_app/src/features/home/domain/usecases/save_favorite_coffee_image_usecase.dart';
import 'package:coffee_venture_app/src/features/home/presentation/cubits/coffee_cubit.dart';
import 'package:coffee_venture_app/src/features/home/presentation/cubits/favorites_cubit.dart';
import 'package:coffee_venture_app/src/features/home/presentation/cubits/main_cubit.dart';
import 'package:coffee_venture_app/src/features/home/presentation/pages/main_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<BaseDio>(BaseDio.new);
    i.addSingleton<CoffeeLocalStorage>(() => const CoffeeLocalStorageImpl());

    i.addLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(dio: i()));
    i.addLazySingleton<HomeLocalDataSource>(() => HomeLocalDataSourceImpl(storage: i()));

    i.addLazySingleton<HomeRepository>(() => HomeRepositoryImpl(remoteDataSource: i(), localDataSource: i()));

    i.addLazySingleton(() => GetRandomCoffeeImageUsecase(homeRepository: i()));
    i.addLazySingleton(() => GetAllFavoriteImagesUsecase(homeRepository: i()));
    i.addLazySingleton(() => SaveFavoriteCoffeeImageUsecase(homeRepository: i()));

    i.addLazySingleton(() => MainCubit());

    i.addLazySingleton<CoffeeCubit>(
      () => CoffeeCubit(getRandomCoffeeImageUsecase: i(), saveFavoriteCoffeeImageUsecase: i()),
    );
    i.addLazySingleton<FavoritesCubit>(() => FavoritesCubit(getAllFavoriteImagesUsecase: i()));
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (context) => const MainPage());
  }
}
