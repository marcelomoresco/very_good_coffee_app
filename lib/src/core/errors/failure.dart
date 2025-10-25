class BaseException implements Exception {
  const BaseException({required this.message});
  final String message;
}

class BaseServerException extends BaseException {
  BaseServerException({required super.message});

  @override
  String get message => 'Something went wrong on the server: ${super.message}';
}
