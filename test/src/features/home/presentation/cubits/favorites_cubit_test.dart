import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_venture_app/src/core/helpers/status.dart';
import 'package:coffee_venture_app/src/features/home/domain/entities/coffee.dart';
import 'package:coffee_venture_app/src/features/home/presentation/cubits/favorites_cubit.dart';
import 'package:coffee_venture_app/src/features/home/presentation/cubits/favorites_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks.dart';

void main() {
  late MockGetAllFavoriteImagesUsecase usecase;

  setUp(() {
    usecase = MockGetAllFavoriteImagesUsecase();
  });

  group('FavoritesCubit', () {
    test('initial state is default FavoritesState', () {
      final cubit = FavoritesCubit(getAllFavoriteImagesUsecase: usecase);
      expect(
        cubit.state,
        isA<FavoritesState>()
            .having((s) => s.status, 'status', Status.initial)
            .having((s) => s.coffees, 'coffees', isEmpty)
            .having((s) => s.exception, 'exception', isNull),
      );
      cubit.close();
    });

    blocTest<FavoritesCubit, FavoritesState>(
      'emits [loading, success] with coffees on success',
      build: () => FavoritesCubit(getAllFavoriteImagesUsecase: usecase),
      setUp: () {
        final coffees = [Coffee(imageUrl: 'https://example.com/1.jpg'), Coffee(imageUrl: 'https://example.com/2.jpg')];
        when(() => usecase()).thenAnswer((_) async => Right(coffees));
      },
      act: (cubit) => cubit.fetchAllFavoritesImages(),
      expect: () => [
        isA<FavoritesState>().having((s) => s.status, 'status', Status.loading),
        isA<FavoritesState>()
            .having((s) => s.status, 'status', Status.success)
            .having((s) => s.coffees.length, 'coffees.length', 2)
            .having((s) => s.exception, 'exception', isNull),
      ],
      verify: (_) {
        verify(() => usecase()).called(1);
      },
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'emits [loading, error] with exception set on failure',
      build: () => FavoritesCubit(getAllFavoriteImagesUsecase: usecase),
      setUp: () {
        when(() => usecase()).thenAnswer((_) async => const Left(FakeFailure('boom')));
      },
      act: (cubit) => cubit.fetchAllFavoritesImages(),
      expect: () => [
        isA<FavoritesState>().having((s) => s.status, 'status', Status.loading),
        isA<FavoritesState>().having((s) => s.exception, 'exception', isNotNull),
      ],
      verify: (_) {
        verify(() => usecase()).called(1);
      },
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'onInitState triggers fetch (loading -> success)',
      build: () => FavoritesCubit(getAllFavoriteImagesUsecase: usecase),
      setUp: () {
        when(() => usecase()).thenAnswer((_) async => const Right(<Coffee>[]));
      },
      act: (cubit) => cubit.onInitState(),
      expect: () => [
        isA<FavoritesState>().having((s) => s.status, 'status', Status.loading),
        isA<FavoritesState>()
            .having((s) => s.status, 'status', Status.success)
            .having((s) => s.coffees, 'coffees', isEmpty),
      ],
      verify: (_) {
        verify(() => usecase()).called(1);
      },
    );
  });
}
