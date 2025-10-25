import 'package:coffee_venture_app/src/features/home/domain/entities/coffee.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Coffee entity', () {
    test('should correctly support equality based on imageUrl and isFavorite', () {
      // Arrange
      final coffee1 = Coffee(imageUrl: 'https://coffee.dev/1', isFavorite: true);
      final coffee2 = Coffee(imageUrl: 'https://coffee.dev/1', isFavorite: true);
      final coffee3 = Coffee(imageUrl: 'https://coffee.dev/2', isFavorite: true);
      final coffee4 = Coffee(imageUrl: 'https://coffee.dev/1', isFavorite: false);

      // Act & Assert
      expect(coffee1, equals(coffee2));
      expect(coffee1.hashCode, equals(coffee2.hashCode));
      expect(coffee1, isNot(equals(coffee3)));
      expect(coffee1, isNot(equals(coffee4)));
    });

    test('should create a correct copy with copyWith()', () {
      // Arrange
      final original = Coffee(imageUrl: 'https://coffee.dev/1', isFavorite: false);

      // Act
      final updated = original.copyWith(isFavorite: true);
      final cloned = original.copyWith();

      // Assert
      expect(updated.imageUrl, equals('https://coffee.dev/1'));
      expect(updated.isFavorite, isTrue);
      expect(cloned, equals(original));
    });

    test('should produce different hashCodes when fields differ', () {
      // Arrange
      final a = Coffee(imageUrl: 'a');
      final b = Coffee(imageUrl: 'b');
      final c = Coffee(imageUrl: 'a', isFavorite: true);

      // Assert
      expect(a.hashCode, isNot(equals(b.hashCode)));
      expect(a.hashCode, isNot(equals(c.hashCode)));
    });
  });
}
