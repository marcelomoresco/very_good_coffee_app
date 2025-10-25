import 'package:coffee_venture_app/src/core/errors/failure.dart';
import 'package:coffee_venture_app/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:coffee_venture_app/src/features/home/domain/entities/coffee.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks.dart';

void main() {
  late HomeRepositoryImpl repository;
  late MockHomeRemoteDataSource mockRemote;
  late MockHomeLocalDataSource mockLocal;

  setUpAll(() {
    registerFallbackValue(Coffee(imageUrl: 'fallback'));
  });

  setUp(() {
    mockRemote = MockHomeRemoteDataSource();
    mockLocal = MockHomeLocalDataSource();
    repository = HomeRepositoryImpl(remoteDataSource: mockRemote, localDataSource: mockLocal);
  });

  group('HomeRepositoryImpl', () {
    final tCoffee = Coffee(imageUrl: 'https://coffee.dev/random');
    final tList = [tCoffee];

    group('fetchRandomCoffeeImage', () {
      test('returns Right(Coffee) when remote succeeds', () async {
        // arrange
        when(() => mockRemote.fetchRandomCoffeeImageUrl()).thenAnswer((_) async => tCoffee);

        // act
        final result = await repository.fetchRandomCoffeeImage();

        // assert
        expect(result, equals(Right(tCoffee)));
        verify(() => mockRemote.fetchRandomCoffeeImageUrl()).called(1);
        verifyNoMoreInteractions(mockRemote);
      });

      test('returns Left(BaseException) when remote throws BaseException', () async {
        const exception = BaseException(message: 'remote error');
        when(() => mockRemote.fetchRandomCoffeeImageUrl()).thenThrow(exception);

        final result = await repository.fetchRandomCoffeeImage();

        expect(result, equals(const Left(exception)));
        verify(() => mockRemote.fetchRandomCoffeeImageUrl()).called(1);
      });
    });

    group('fetchLocalCoffeesImage', () {
      test('returns Right(List<Coffee>) when local succeeds', () async {
        when(() => mockLocal.fetchLocalCoffeesImage()).thenAnswer((_) async => tList);

        final result = await repository.fetchLocalCoffeesImage();

        expect(result, equals(Right(tList)));
        verify(() => mockLocal.fetchLocalCoffeesImage()).called(1);
      });

      test('returns Left(BaseException) when local throws BaseException', () async {
        const exception = BaseException(message: 'local error');
        when(() => mockLocal.fetchLocalCoffeesImage()).thenThrow(exception);

        final result = await repository.fetchLocalCoffeesImage();

        expect(result, equals(const Left(exception)));
        verify(() => mockLocal.fetchLocalCoffeesImage()).called(1);
      });
    });

    group('saveFavoriteCoffeeImage', () {
      test('returns Right(void) when local succeeds', () async {
        when(() => mockLocal.saveFavoriteCoffeeImage(any())).thenAnswer((_) async {
          return;
        });

        final result = await repository.saveFavoriteCoffeeImage(tCoffee);

        expect(result, equals(const Right(null)));
        verify(() => mockLocal.saveFavoriteCoffeeImage(tCoffee)).called(1);
      });

      test('returns Left(BaseException) when local throws BaseException', () async {
        const exception = BaseException(message: 'save error');
        when(() => mockLocal.saveFavoriteCoffeeImage(any())).thenThrow(exception);

        final result = await repository.saveFavoriteCoffeeImage(tCoffee);

        expect(result, equals(const Left(exception)));
        verify(() => mockLocal.saveFavoriteCoffeeImage(tCoffee)).called(1);
      });
    });

    group('isFavoriteCoffee', () {
      test('returns Right(true) when local returns true', () async {
        when(() => mockLocal.isFavoriteCoffee(any())).thenAnswer((_) async => true);

        final result = await repository.isFavoriteCoffee(tCoffee);

        expect(result, equals(const Right(true)));
        verify(() => mockLocal.isFavoriteCoffee(tCoffee.imageUrl)).called(1);
      });

      test('returns Right(false) when local returns false', () async {
        when(() => mockLocal.isFavoriteCoffee(any())).thenAnswer((_) async => false);

        final result = await repository.isFavoriteCoffee(tCoffee);

        expect(result, equals(const Right(false)));
        verify(() => mockLocal.isFavoriteCoffee(tCoffee.imageUrl)).called(1);
      });

      test('returns Left(BaseException) when local throws BaseException', () async {
        const exception = BaseException(message: 'isFavorite error');
        when(() => mockLocal.isFavoriteCoffee(any())).thenThrow(exception);

        final result = await repository.isFavoriteCoffee(tCoffee);

        expect(result, equals(const Left(exception)));
        verify(() => mockLocal.isFavoriteCoffee(tCoffee.imageUrl)).called(1);
      });
    });
  });
}
