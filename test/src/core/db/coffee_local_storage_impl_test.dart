import 'package:coffee_venture_app/src/core/db/coffee_local_storage_impl.dart';
import 'package:coffee_venture_app/src/features/home/domain/entities/coffee.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late CoffeeLocalStorageImpl storage;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() {
    CoffeeLocalStorageImpl.clearDatabaseInstance();
    storage = const CoffeeLocalStorageImpl();
  });

  tearDown(() async {
    final db = await storage.database;
    await db.delete('favorites');
    await db.close();
    await deleteDatabase(await getDatabasesPath() + '/coffee.db');
    CoffeeLocalStorageImpl.clearDatabaseInstance();
  });

  group('CoffeeLocalStorageImpl', () {
    test('should add favorite coffee successfully', () async {
      // Arrange
      final coffee = Coffee(imageUrl: 'https://example.com/coffee1.jpg');

      // Act
      await storage.addFavorite(coffee);
      final favorites = await storage.getFavorites();

      // Assert
      expect(favorites.length, 1);
      expect(favorites.first.imageUrl, coffee.imageUrl);
    });

    test('should not add duplicate favorite', () async {
      // Arrange
      final coffee = Coffee(imageUrl: 'https://example.com/coffee1.jpg');

      // Act
      await storage.addFavorite(coffee);
      await storage.addFavorite(coffee);
      final favorites = await storage.getFavorites();

      // Assert
      expect(favorites.length, 1);
    });

    test('should remove favorite coffee successfully', () async {
      // Arrange
      final coffee = Coffee(imageUrl: 'https://example.com/coffee1.jpg');
      await storage.addFavorite(coffee);

      // Act
      await storage.removeFavorite(coffee.imageUrl);
      final favorites = await storage.getFavorites();

      // Assert
      expect(favorites.length, 0);
    });

    test('should return all favorites in reverse order', () async {
      // Arrange
      final coffee1 = Coffee(imageUrl: 'https://example.com/coffee1.jpg');
      final coffee2 = Coffee(imageUrl: 'https://example.com/coffee2.jpg');
      final coffee3 = Coffee(imageUrl: 'https://example.com/coffee3.jpg');

      // Act
      await storage.addFavorite(coffee1);
      await storage.addFavorite(coffee2);
      await storage.addFavorite(coffee3);
      final favorites = await storage.getFavorites();

      // Assert
      expect(favorites.length, 3);
      expect(favorites[0].imageUrl, coffee3.imageUrl);
      expect(favorites[1].imageUrl, coffee2.imageUrl);
      expect(favorites[2].imageUrl, coffee1.imageUrl);
    });

    test('should return true when coffee is favorite', () async {
      // Arrange
      final coffee = Coffee(imageUrl: 'https://example.com/coffee1.jpg');
      await storage.addFavorite(coffee);

      // Act
      final isFavorite = await storage.isFavorite(coffee.imageUrl);

      // Assert
      expect(isFavorite, true);
    });

    test('should return false when coffee is not favorite', () async {
      // Act
      final isFavorite = await storage.isFavorite('https://example.com/nonexistent.jpg');

      // Assert
      expect(isFavorite, false);
    });

    test('should return empty list when no favorites exist', () async {
      // Act
      final favorites = await storage.getFavorites();

      // Assert
      expect(favorites, isEmpty);
    });

    test('should handle removing non-existent favorite gracefully', () async {
      // Act & Assert
      expect(() => storage.removeFavorite('https://example.com/nonexistent.jpg'), returnsNormally);
    });

    test('should maintain database instance across multiple operations', () async {
      // Arrange
      final coffee1 = Coffee(imageUrl: 'https://example.com/coffee1.jpg');
      final coffee2 = Coffee(imageUrl: 'https://example.com/coffee2.jpg');

      // Act
      await storage.addFavorite(coffee1);
      final db1 = await storage.database;
      await storage.addFavorite(coffee2);
      final db2 = await storage.database;

      // Assert
      expect(identical(db1, db2), true);
    });
  });
}
