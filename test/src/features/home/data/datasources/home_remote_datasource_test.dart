import 'dart:io';

import 'package:coffee_venture_app/src/core/constants/app_network.dart';
import 'package:coffee_venture_app/src/core/errors/failure.dart';
import 'package:coffee_venture_app/src/features/home/data/datasources/home_remote_datasource.dart';
import 'package:coffee_venture_app/src/features/home/data/exceptions/coffee_exceptions.dart';
import 'package:coffee_venture_app/src/features/home/domain/entities/coffee.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks.dart';

void main() {
  late MockBaseDio dio;
  late HomeRemoteDataSourceImpl dataSource;

  final validJson = <String, dynamic>{'file': 'https://example.com/coffee.jpg'};

  Response<dynamic> okResponse(dynamic data) => Response(
    data: data,
    statusCode: 200,
    requestOptions: RequestOptions(path: AppNetwork.randomJson),
  );

  DioException dioEx({required int statusCode, String? message, DioExceptionType type = DioExceptionType.badResponse}) {
    final ro = RequestOptions(path: AppNetwork.randomJson);
    return DioException(
      requestOptions: ro,
      response: Response(requestOptions: ro, statusCode: statusCode),
      type: type,
      message: message,
    );
  }

  setUp(() {
    dio = MockBaseDio();
    dataSource = HomeRemoteDataSourceImpl(dio: dio);
  });

  group('HomeRemoteDataSourceImpl.fetchRandomCoffeeImageUrl', () {
    test('returns Coffee on success', () async {
      // arrange
      when(() => dio.get(AppNetwork.randomJson)).thenAnswer((_) async => okResponse(validJson));

      // act
      final result = await dataSource.fetchRandomCoffeeImageUrl();

      // assert
      expect(result, isA<Coffee>());
      expect(result.imageUrl, equals(validJson['file']));
      verify(() => dio.get(AppNetwork.randomJson)).called(1);
      verifyNoMoreInteractions(dio);
    });

    test('throws CoffeeParseException when a TypeError occurs while parsing', () async {
      // arrange
      when(() => dio.get(AppNetwork.randomJson)).thenAnswer((_) async => okResponse(null));

      // act + assert
      expect(() => dataSource.fetchRandomCoffeeImageUrl(), throwsA(isA<CoffeeParseException>()));
      verify(() => dio.get(AppNetwork.randomJson)).called(1);
      verifyNoMoreInteractions(dio);
    });

    test('throws CoffeeNotFoundException when HTTP 404 is returned', () async {
      // arrange
      when(
        () => dio.get(AppNetwork.randomJson),
      ).thenThrow(dioEx(statusCode: HttpStatus.notFound, message: 'Not Found'));

      // act + assert
      expect(() => dataSource.fetchRandomCoffeeImageUrl(), throwsA(isA<CoffeeNotFoundException>()));
      verify(() => dio.get(AppNetwork.randomJson)).called(1);
      verifyNoMoreInteractions(dio);
    });

    test('throws BaseServerException for other DioException (e.g., 500)', () async {
      // arrange
      when(
        () => dio.get(AppNetwork.randomJson),
      ).thenThrow(dioEx(statusCode: HttpStatus.internalServerError, message: 'Internal Server Error'));

      // act + assert
      expect(() => dataSource.fetchRandomCoffeeImageUrl(), throwsA(isA<BaseServerException>()));
      verify(() => dio.get(AppNetwork.randomJson)).called(1);
      verifyNoMoreInteractions(dio);
    });

    test('throws BaseException for any other unexpected error', () async {
      // arrange
      when(() => dio.get(AppNetwork.randomJson)).thenThrow(Exception('boom'));

      // act + assert
      expect(() => dataSource.fetchRandomCoffeeImageUrl(), throwsA(isA<BaseException>()));
      verify(() => dio.get(AppNetwork.randomJson)).called(1);
      verifyNoMoreInteractions(dio);
    });
  });
}
