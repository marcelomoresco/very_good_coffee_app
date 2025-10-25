import 'package:coffee_venture_app/src/core/client/base_dio.dart';
import 'package:coffee_venture_app/src/core/constants/app_constants.dart';
import 'package:dio/io.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BaseDio', () {
    test('should be an instance of DioForNative', () {
      final dio = BaseDio();
      expect(dio, isA<DioForNative>());
    });

    test('should configure baseUrl and timeouts correctly', () {
      final dio = BaseDio();

      expect(dio.options.baseUrl, AppConstants.baseUrl);
      expect(dio.options.connectTimeout, const Duration(seconds: 10));
      expect(dio.options.sendTimeout, const Duration(seconds: 10));
      expect(dio.options.receiveTimeout, const Duration(seconds: 10));
    });

    test('should not share the same BaseOptions instance across instances', () {
      final dio1 = BaseDio();
      final dio2 = BaseDio();

      expect(identical(dio1.options, dio2.options), isFalse);
    });
  });
}
