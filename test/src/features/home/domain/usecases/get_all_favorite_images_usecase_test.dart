import 'package:coffee_venture_app/src/core/errors/failure.dart';
import 'package:coffee_venture_app/src/features/home/domain/entities/coffee.dart';
import 'package:coffee_venture_app/src/features/home/domain/usecases/get_all_favorite_images_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks.dart';

void main() {
  late GetAllFavoriteImagesUsecase usecase;
  late MockHomeRepository mockRepository;

  setUp(() {
    mockRepository = MockHomeRepository();
    usecase = GetAllFavoriteImagesUsecase(homeRepository: mockRepository);
  });

  group('GetAllFavoriteImagesUsecase', () {
    final tCoffees = [
      Coffee(imageUrl: 'https://coffee.alexflipnote.dev/123'),
      Coffee(imageUrl: 'https://coffee.alexflipnote.dev/456'),
    ];

    test('deve retornar Right(List<Coffee>) quando o repository for bem-sucedido', () async {
      // arrange
      when(() => mockRepository.fetchLocalCoffeesImage()).thenAnswer((_) async => Right(tCoffees));

      // act
      final result = await usecase();

      // assert
      expect(result.isRight(), true);
      expect(result.fold((l) => null, (r) => r), equals(tCoffees));
      verify(() => mockRepository.fetchLocalCoffeesImage()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('deve retornar Left(BaseException) quando o repository falhar', () async {
      // arrange
      const failure = BaseException(message: 'Erro ao buscar favoritos');
      when(() => mockRepository.fetchLocalCoffeesImage()).thenAnswer((_) async => const Left(failure));

      // act
      final result = await usecase();

      // assert
      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => null), equals(failure));
      verify(() => mockRepository.fetchLocalCoffeesImage()).called(1);
    });
  });
}
