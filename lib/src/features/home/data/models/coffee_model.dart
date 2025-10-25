import 'package:coffee_venture_app/src/features/home/domain/entities/coffee.dart';

class CoffeeModel extends Coffee {
  CoffeeModel({required super.imageUrl, super.isFavorite});

  factory CoffeeModel.fromJson(Map<String, dynamic> json) {
    return CoffeeModel(imageUrl: json['file'] as String);
  }
}
