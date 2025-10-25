import 'dart:async';

import 'package:coffee_venture_app/src/core/helpers/status.dart';
import 'package:coffee_venture_app/src/core/helpers/very_good_venture_cubit.dart';
import 'package:coffee_venture_app/src/features/home/domain/usecases/get_random_coffee_image_usecase.dart';
import 'package:coffee_venture_app/src/features/home/domain/usecases/save_favorite_coffee_image_usecase.dart';
import 'package:coffee_venture_app/src/features/home/presentation/cubits/coffee_state.dart';

class CoffeeCubit extends VeryGoodVentureCubit<CoffeeState> {
  CoffeeCubit({
    required GetRandomCoffeeImageUsecase getRandomCoffeeImageUsecase,
    required SaveFavoriteCoffeeImageUsecase saveFavoriteCoffeeImageUsecase,
  }) : _getRandomCoffeeImageUsecase = getRandomCoffeeImageUsecase,
       _saveFavoriteCoffeeImageUsecase = saveFavoriteCoffeeImageUsecase,
       super(const CoffeeState());

  final GetRandomCoffeeImageUsecase _getRandomCoffeeImageUsecase;
  final SaveFavoriteCoffeeImageUsecase _saveFavoriteCoffeeImageUsecase;

  @override
  FutureOr<void> onInitState() {
    // analytics logEvent
    // remote config fetch
    fetchRandomCoffeeImage();
  }

  Future<void> fetchRandomCoffeeImage() async {
    emit(state.copyWith(status: Status.loading));
    final result = await _getRandomCoffeeImageUsecase();
    result.fold(
      (failure) => emit(state.copyWith(exception: failure, status: Status.error)),
      (coffee) => emit(state.copyWith(status: Status.success, coffee: coffee)),
    );
  }

  Future<void> _saveFavoriteCoffeeImage() async {
    emit(state.copyWith(isButtonLoading: true, saveStatus: Status.loading));
    final currentCoffee = state.coffee;

    if (currentCoffee == null) {
      emit(state.copyWith(isButtonLoading: false, saveStatus: Status.initial));
      return;
    }

    final result = await _saveFavoriteCoffeeImageUsecase(currentCoffee);
    result.fold(
      (failure) => emit(state.copyWith(exception: failure, saveStatus: Status.error, isButtonLoading: false)),
      (_) {
        emit(state.copyWith(isButtonLoading: false, saveStatus: Status.success));
        fetchRandomCoffeeImage();
      },
    );
  }

  Future<void> onFavoriteImage() async {
    await _saveFavoriteCoffeeImage();
  }

  void onNext() {
    fetchRandomCoffeeImage();
  }
}
