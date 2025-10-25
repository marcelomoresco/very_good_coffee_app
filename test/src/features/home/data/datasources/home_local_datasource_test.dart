import 'package:coffee_venture_app/src/features/home/data/datasources/home_local_datasource.dart';
import 'package:coffee_venture_app/src/features/home/domain/entities/coffee.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks.dart';

void main() {
  late MockCoffeeLocalStorage storage;
  late HomeLocalDataSourceImpl dataSource;

  final tCoffee = Coffee(imageUrl: 'https://example.com/1.jpg');
  const tUrl = 'https://example.com/1.jpg';

  setUpAll(() {
    registerFallbackValue(tCoffee);
  });

  setUp(() {
    storage = MockCoffeeLocalStorage();
    dataSource = HomeLocalDataSourceImpl(storage: storage);
  });

  group('fetchLocalCoffeesImage', () {
    test('returns list from storage.getFavorites and calls it once', () async {
      // arrange
      final list = [tCoffee, Coffee(imageUrl: 'https://example.com/2.jpg')];
      when(() => storage.getFavorites()).thenAnswer((_) async => list);

      // act
      final result = await dataSource.fetchLocalCoffeesImage();

      // assert
      expect(result, equals(list));
      verify(() => storage.getFavorites()).called(1);
      verifyNoMoreInteractions(storage);
    });

    test('rethrows when storage.getFavorites throws', () async {
      when(() => storage.getFavorites()).thenThrow(Exception('db error'));

      expect(() => dataSource.fetchLocalCoffeesImage(), throwsA(isA<Exception>()));
      verify(() => storage.getFavorites()).called(1);
      verifyNoMoreInteractions(storage);
    });
  });

  group('saveFavoriteCoffeeImage', () {
    test('delegates to storage.addFavorite', () async {
      when(() => storage.addFavorite(any())).thenAnswer((_) async {});

      await dataSource.saveFavoriteCoffeeImage(tCoffee);

      verify(() => storage.addFavorite(tCoffee)).called(1);
      verifyNoMoreInteractions(storage);
    });

    test('rethrows when storage.addFavorite throws', () async {
      when(() => storage.addFavorite(any())).thenThrow(Exception('insert fail'));

      expect(() => dataSource.saveFavoriteCoffeeImage(tCoffee), throwsA(isA<Exception>()));
      verify(() => storage.addFavorite(tCoffee)).called(1);
      verifyNoMoreInteractions(storage);
    });
  });

  group('removeFavoriteCoffeeImage', () {
    test('delegates to storage.removeFavorite', () async {
      when(() => storage.removeFavorite(any())).thenAnswer((_) async {});

      await dataSource.removeFavoriteCoffeeImage(tUrl);

      verify(() => storage.removeFavorite(tUrl)).called(1);
      verifyNoMoreInteractions(storage);
    });

    test('rethrows when storage.removeFavorite throws', () async {
      when(() => storage.removeFavorite(any())).thenThrow(Exception('delete fail'));

      expect(() => dataSource.removeFavoriteCoffeeImage(tUrl), throwsA(isA<Exception>()));
      verify(() => storage.removeFavorite(tUrl)).called(1);
      verifyNoMoreInteractions(storage);
    });
  });

  group('isFavoriteCoffee', () {
    test('returns bool from storage.isFavorite', () async {
      when(() => storage.isFavorite(any())).thenAnswer((_) async => true);

      final result = await dataSource.isFavoriteCoffee(tUrl);

      expect(result, isTrue);
      verify(() => storage.isFavorite(tUrl)).called(1);
      verifyNoMoreInteractions(storage);
    });

    test('rethrows when storage.isFavorite throws', () async {
      when(() => storage.isFavorite(any())).thenThrow(Exception('query fail'));

      expect(() => dataSource.isFavoriteCoffee(tUrl), throwsA(isA<Exception>()));
      verify(() => storage.isFavorite(tUrl)).called(1);
      verifyNoMoreInteractions(storage);
    });
  });
}
