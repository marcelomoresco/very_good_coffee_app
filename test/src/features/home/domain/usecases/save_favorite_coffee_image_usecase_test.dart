import 'package:coffee_venture_app/src/core/errors/failure.dart';
import 'package:coffee_venture_app/src/features/home/data/exceptions/coffee_exceptions.dart';
import 'package:coffee_venture_app/src/features/home/domain/entities/coffee.dart';
import 'package:coffee_venture_app/src/features/home/domain/usecases/save_favorite_coffee_image_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks.dart';

void main() {
  late SaveFavoriteCoffeeImageUsecase usecase;
  late MockHomeRepository mockRepository;
  final tCoffee = Coffee(imageUrl: 'https://coffee.alexflipnote.dev/123');

  setUpAll(() {
    registerFallbackValue(tCoffee);
  });

  setUp(() {
    mockRepository = MockHomeRepository();
    usecase = SaveFavoriteCoffeeImageUsecase(homeRepository: mockRepository);
  });

  group('SaveFavoriteCoffeeImageUsecase', () {
    const tFailure = BaseException(message: 'Repository failure');

    test('should return Right(void) when coffee is not favorite and save succeeds', () async {
      // arrange
      when(() => mockRepository.isFavoriteCoffee(any())).thenAnswer((_) async => const Right(false));
      when(() => mockRepository.saveFavoriteCoffeeImage(any())).thenAnswer((_) async => const Right(null));

      // act
      final result = await usecase(tCoffee);

      // assert
      expect(result.isRight(), isTrue);
      expect(result, equals(const Right(null)));

      verify(() => mockRepository.isFavoriteCoffee(tCoffee)).called(1);
      verify(() => mockRepository.saveFavoriteCoffeeImage(tCoffee)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return Left(CoffeeSaveException) when coffee is already a favorite', () async {
      // arrange
      when(() => mockRepository.isFavoriteCoffee(any())).thenAnswer((_) async => const Right(true));

      // act
      final result = await usecase(tCoffee);

      // assert
      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<CoffeeSaveException>()),
        (_) => fail('Expected a CoffeeSaveException'),
      );

      verify(() => mockRepository.isFavoriteCoffee(tCoffee)).called(1);
      verifyNever(() => mockRepository.saveFavoriteCoffeeImage(any()));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should propagate Left(BaseException) when isFavoriteCoffee fails', () async {
      // arrange
      when(() => mockRepository.isFavoriteCoffee(any())).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await usecase(tCoffee);

      // assert
      expect(result.isLeft(), isTrue);
      expect(result.fold((l) => l, (r) => null), equals(tFailure));

      verify(() => mockRepository.isFavoriteCoffee(tCoffee)).called(1);
      verifyNever(() => mockRepository.saveFavoriteCoffeeImage(any()));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return Left(BaseException) when saving fails', () async {
      // arrange
      when(() => mockRepository.isFavoriteCoffee(any())).thenAnswer((_) async => const Right(false));
      when(() => mockRepository.saveFavoriteCoffeeImage(any())).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await usecase(tCoffee);

      // assert
      expect(result.isLeft(), isTrue);
      expect(result.fold((l) => l, (r) => null), equals(tFailure));

      verify(() => mockRepository.isFavoriteCoffee(tCoffee)).called(1);
      verify(() => mockRepository.saveFavoriteCoffeeImage(tCoffee)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
