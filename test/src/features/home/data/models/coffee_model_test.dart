import 'package:coffee_venture_app/src/features/home/data/models/coffee_model.dart';
import 'package:coffee_venture_app/src/features/home/domain/entities/coffee.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CoffeeModel', () {
    test('should be a subclass of Coffee entity', () {
      // Arrange
      final model = CoffeeModel(imageUrl: 'https://coffee.dev/img');

      // Assert
      expect(model, isA<Coffee>());
    });

    test('should correctly parse from JSON with "file" key', () {
      // Arrange
      final json = {'file': 'https://coffee.dev/abc123'};

      // Act
      final result = CoffeeModel.fromJson(json);

      // Assert
      expect(result.imageUrl, equals('https://coffee.dev/abc123'));
      expect(result.isFavorite, isFalse); // default value
    });

    test('should support equality based on imageUrl and isFavorite', () {
      // Arrange
      final model1 = CoffeeModel(imageUrl: 'https://coffee.dev/123', isFavorite: true);
      final model2 = CoffeeModel(imageUrl: 'https://coffee.dev/123', isFavorite: true);
      final model3 = CoffeeModel(imageUrl: 'https://coffee.dev/456', isFavorite: true);
      final model4 = CoffeeModel(imageUrl: 'https://coffee.dev/123', isFavorite: false);

      // Assert
      expect(model1, equals(model2));
      expect(model1.hashCode, equals(model2.hashCode));
      expect(model1, isNot(equals(model3)));
      expect(model1, isNot(equals(model4)));
    });

    test('should allow creating a modified copy using copyWith()', () {
      // Arrange
      final model = CoffeeModel(imageUrl: 'https://coffee.dev/original');

      // Act
      final updated = model.copyWith(isFavorite: true);

      // Assert
      expect(updated.isFavorite, isTrue);
      expect(updated.imageUrl, equals(model.imageUrl));
      expect(updated, isNot(equals(model)));
    });
  });
}
