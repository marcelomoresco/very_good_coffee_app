import 'dart:async';

import 'package:coffee_venture_app/src/core/helpers/status.dart';
import 'package:coffee_venture_app/src/core/helpers/very_good_venture_cubit.dart';
import 'package:coffee_venture_app/src/features/home/domain/usecases/get_all_favorite_images_usecase.dart';
import 'package:coffee_venture_app/src/features/home/presentation/cubits/favorites_state.dart';

class FavoritesCubit extends VeryGoodVentureCubit<FavoritesState> {
  FavoritesCubit({required GetAllFavoriteImagesUsecase getAllFavoriteImagesUsecase})
    : _getAllFavoriteImagesUsecase = getAllFavoriteImagesUsecase,
      super(const FavoritesState());

  final GetAllFavoriteImagesUsecase _getAllFavoriteImagesUsecase;

  @override
  FutureOr<void> onInitState() {
    // analytics logEvent
    // remote config fetch
    fetchAllFavoritesImages();
  }

  Future<void> fetchAllFavoritesImages() async {
    emit(state.copyWith(status: Status.loading));
    final result = await _getAllFavoriteImagesUsecase();
    result.fold(
      (failure) => emit(state.copyWith(exception: failure)),
      (coffees) => emit(state.copyWith(status: Status.success, coffees: coffees)),
    );
  }
}
