import 'package:coffee_venture_app/src/core/errors/failure.dart';

class CoffeeNotFoundException extends BaseException {
  CoffeeNotFoundException({required super.message});
}

class CoffeeParseException extends BaseException {
  CoffeeParseException({required super.message});
}

class CoffeeSaveException extends BaseException {
  CoffeeSaveException({required super.message});
}

class CoffeeLocalStorageException extends BaseException {
  CoffeeLocalStorageException({required super.message});
}
