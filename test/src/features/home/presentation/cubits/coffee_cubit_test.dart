import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_venture_app/src/core/helpers/status.dart';
import 'package:coffee_venture_app/src/features/home/domain/entities/coffee.dart';
import 'package:coffee_venture_app/src/features/home/presentation/cubits/coffee_cubit.dart';
import 'package:coffee_venture_app/src/features/home/presentation/cubits/coffee_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks.dart';

void main() {
  late MockGetRandomCoffeeImageUsecase getRandom;
  late MockSaveFavoriteCoffeeImageUsecase saveFavorite;

  final coffee = Coffee(imageUrl: 'https://example.com/1.jpg');
  const failure = FakeFailure('some error');

  setUp(() {
    getRandom = MockGetRandomCoffeeImageUsecase();
    saveFavorite = MockSaveFavoriteCoffeeImageUsecase();
  });

  group('fetchRandomCoffeeImage', () {
    blocTest<CoffeeCubit, CoffeeState>(
      'emits [loading, success] when getRandom succeeds',
      build: () {
        when(() => getRandom()).thenAnswer((_) async => Right(coffee));
        return CoffeeCubit(getRandomCoffeeImageUsecase: getRandom, saveFavoriteCoffeeImageUsecase: saveFavorite);
      },
      act: (cubit) => cubit.fetchRandomCoffeeImage(),
      expect: () => [
        isA<CoffeeState>().having((s) => s.status, 'status', Status.loading),
        isA<CoffeeState>().having((s) => s.status, 'status', Status.success).having((s) => s.coffee, 'coffee', coffee),
      ],
      verify: (_) => verify(() => getRandom()).called(1),
    );

    blocTest<CoffeeCubit, CoffeeState>(
      'emits [loading, error] when getRandom fails',
      build: () {
        when(() => getRandom()).thenAnswer((_) async => const Left(failure));
        return CoffeeCubit(getRandomCoffeeImageUsecase: getRandom, saveFavoriteCoffeeImageUsecase: saveFavorite);
      },
      act: (cubit) => cubit.fetchRandomCoffeeImage(),
      expect: () => [
        isA<CoffeeState>().having((s) => s.status, 'status', Status.loading),
        isA<CoffeeState>()
            .having((s) => s.status, 'status', Status.error)
            .having((s) => s.exception, 'exception', failure),
      ],
      verify: (_) => verify(() => getRandom()).called(1),
    );
  });

  group('_saveFavoriteCoffeeImage / onFavoriteImage', () {
    blocTest<CoffeeCubit, CoffeeState>(
      'emits loading → success → fetchRandomCoffeeImage() on success',
      build: () {
        when(() => saveFavorite(coffee)).thenAnswer((_) async => const Right(null));
        when(() => getRandom()).thenAnswer((_) async => Right(coffee));
        final cubit = CoffeeCubit(getRandomCoffeeImageUsecase: getRandom, saveFavoriteCoffeeImageUsecase: saveFavorite);
        cubit.emit(cubit.state.copyWith(coffee: coffee, status: Status.success));
        return cubit;
      },
      act: (cubit) => cubit.onFavoriteImage(),
      expect: () => [
        isA<CoffeeState>()
            .having((s) => s.isButtonLoading, 'isButtonLoading', true)
            .having((s) => s.saveStatus, 'saveStatus', Status.loading),
        isA<CoffeeState>()
            .having((s) => s.isButtonLoading, 'isButtonLoading', false)
            .having((s) => s.saveStatus, 'saveStatus', Status.success),
        isA<CoffeeState>().having((s) => s.status, 'status', Status.loading),
        isA<CoffeeState>().having((s) => s.status, 'status', Status.success).having((s) => s.coffee, 'coffee', coffee),
      ],
      verify: (_) {
        verify(() => saveFavorite(coffee)).called(1);
        verify(() => getRandom()).called(1);
      },
    );

    blocTest<CoffeeCubit, CoffeeState>(
      'emits loading → error (stops there) on failure to save',
      build: () {
        when(() => saveFavorite(coffee)).thenAnswer((_) async => const Left(failure));
        final cubit = CoffeeCubit(getRandomCoffeeImageUsecase: getRandom, saveFavoriteCoffeeImageUsecase: saveFavorite);
        cubit.emit(cubit.state.copyWith(coffee: coffee, status: Status.success));
        return cubit;
      },
      act: (cubit) => cubit.onFavoriteImage(),
      expect: () => [
        isA<CoffeeState>()
            .having((s) => s.saveStatus, 'saveStatus', Status.loading)
            .having((s) => s.isButtonLoading, 'isButtonLoading', true),
        isA<CoffeeState>()
            .having((s) => s.saveStatus, 'saveStatus', Status.error)
            .having((s) => s.isButtonLoading, 'isButtonLoading', false)
            .having((s) => s.exception, 'exception', failure),
      ],
      verify: (_) {
        verify(() => saveFavorite(coffee)).called(1);
        verifyNever(() => getRandom());
      },
    );

    blocTest<CoffeeCubit, CoffeeState>(
      'when no coffee available, toggles loading true→false without calling save',
      build: () {
        when(() => getRandom()).thenAnswer((_) async => Right(coffee));
        return CoffeeCubit(getRandomCoffeeImageUsecase: getRandom, saveFavoriteCoffeeImageUsecase: saveFavorite);
      },
      act: (cubit) => cubit.onFavoriteImage(),
      expect: () => [
        isA<CoffeeState>()
            .having((s) => s.isButtonLoading, 'isButtonLoading', true)
            .having((s) => s.saveStatus, 'saveStatus', Status.loading),
        isA<CoffeeState>()
            .having((s) => s.isButtonLoading, 'isButtonLoading', false)
            .having((s) => s.saveStatus, 'saveStatus', Status.initial),
      ],
      verify: (_) {
        verifyZeroInteractions(saveFavorite);
        verifyNever(() => getRandom());
      },
    );
  });

  group('onInitState', () {
    blocTest<CoffeeCubit, CoffeeState>(
      'calls fetchRandomCoffeeImage() on init',
      build: () {
        when(() => getRandom()).thenAnswer((_) async => Right(coffee));
        return CoffeeCubit(getRandomCoffeeImageUsecase: getRandom, saveFavoriteCoffeeImageUsecase: saveFavorite);
      },
      act: (cubit) => cubit.onInitState(),
      expect: () => [
        isA<CoffeeState>().having((s) => s.status, 'status', Status.loading),
        isA<CoffeeState>().having((s) => s.status, 'status', Status.success).having((s) => s.coffee, 'coffee', coffee),
      ],
      verify: (_) => verify(() => getRandom()).called(1),
    );
  });
}
