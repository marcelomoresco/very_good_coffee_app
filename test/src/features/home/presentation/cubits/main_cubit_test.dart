import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_venture_app/src/features/home/presentation/cubits/main_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MainCubit', () {
    test('initial state should be 0', () {
      final cubit = MainCubit();
      expect(cubit.state, equals(0));
      cubit.close();
    });

    blocTest<MainCubit, int>(
      'emits [index] when setIndex is called',
      build: () => MainCubit(),
      act: (cubit) => cubit.setIndex(2),
      expect: () => [2],
    );

    blocTest<MainCubit, int>(
      'emits multiple indexes when called sequentially',
      build: () => MainCubit(),
      act: (cubit) {
        cubit.setIndex(1);
        cubit.setIndex(3);
      },
      expect: () => [1, 3],
    );
  });
}
