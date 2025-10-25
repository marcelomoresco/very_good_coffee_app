import 'package:dartz/dartz.dart';

import '../../errors/failure.dart';

// ignore: avoid_types_as_parameter_names
abstract class UseCase<Type, Params> {
  Future<Either<BaseException, Type>> call(Params params);
}

class NoParams {}
