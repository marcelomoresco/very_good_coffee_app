import 'package:coffee_venture_app/src/core/errors/failure.dart';
import 'package:coffee_venture_app/src/features/home/domain/entities/coffee.dart';
import 'package:coffee_venture_app/src/features/home/domain/usecases/get_random_coffee_image_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks.dart';

void main() {
  late GetRandomCoffeeImageUsecase usecase;
  late MockHomeRepository mockRepository;
  final tCoffee = Coffee(imageUrl: 'https://coffee.alexflipnote.dev/random');

  setUpAll(() {
    registerFallbackValue(tCoffee);
  });

  setUp(() {
    mockRepository = MockHomeRepository();
    usecase = GetRandomCoffeeImageUsecase(homeRepository: mockRepository);
  });

  group('GetRandomCoffeeImageUsecase', () {
    const tFailure = BaseException(message: 'Error fetching random image');

    test('returns Right(Coffee) when repository succeeds and coffee is NOT favorite', () async {
      // arrange
      when(() => mockRepository.fetchRandomCoffeeImage()).thenAnswer((_) async => Right(tCoffee));
      when(() => mockRepository.isFavoriteCoffee(any())).thenAnswer((_) async => const Right(false));

      // act
      final result = await usecase();

      // assert
      expect(result.isRight(), isTrue);
      expect(result.getOrElse(() => Coffee(imageUrl: '')), equals(tCoffee));
      verify(() => mockRepository.fetchRandomCoffeeImage()).called(1);
      verify(() => mockRepository.isFavoriteCoffee(tCoffee)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('returns Left(BaseException) when fetchRandomCoffeeImage fails', () async {
      // arrange
      when(() => mockRepository.fetchRandomCoffeeImage()).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await usecase();

      // assert
      expect(result.isLeft(), isTrue);
      expect(result.fold((l) => l, (r) => null), equals(tFailure));
      verify(() => mockRepository.fetchRandomCoffeeImage()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
    test('returns Left(BaseException) when isFavoriteCoffee fails', () async {
      // arrange
      when(() => mockRepository.fetchRandomCoffeeImage()).thenAnswer((_) async => Right(tCoffee));
      when(() => mockRepository.isFavoriteCoffee(any())).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await usecase();

      // assert
      expect(result.isLeft(), isTrue);
      expect(result.fold((l) => l, (r) => null), equals(tFailure));
      verify(() => mockRepository.fetchRandomCoffeeImage()).called(1);
      verify(() => mockRepository.isFavoriteCoffee(tCoffee)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
