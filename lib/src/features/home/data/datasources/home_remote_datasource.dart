import 'dart:io';

import 'package:coffee_venture_app/src/core/client/base_dio.dart';
import 'package:coffee_venture_app/src/core/constants/app_network.dart';
import 'package:coffee_venture_app/src/core/errors/failure.dart';
import 'package:coffee_venture_app/src/features/home/data/exceptions/coffee_exceptions.dart';
import 'package:coffee_venture_app/src/features/home/data/models/coffee_model.dart';
import 'package:coffee_venture_app/src/features/home/domain/entities/coffee.dart';
import 'package:dio/dio.dart';

abstract class HomeRemoteDataSource {
  Future<Coffee> fetchRandomCoffeeImageUrl();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl({required this.dio});
  final BaseDio dio;

  @override
  Future<Coffee> fetchRandomCoffeeImageUrl() async {
    try {
      final response = await dio.get(AppNetwork.randomJson);

      return CoffeeModel.fromJson(response.data);
    } on TypeError {
      throw CoffeeParseException(message: 'Error parsing coffee data');
    } on DioException catch (e) {
      if (e.response?.statusCode == HttpStatus.notFound) {
        throw CoffeeNotFoundException(message: 'Coffee image not found');
      }

      throw BaseServerException(message: 'Unexpected error: ${e.message}');
    } catch (e) {
      throw BaseException(message: 'Erro inesperado: $e');
    }
  }
}
