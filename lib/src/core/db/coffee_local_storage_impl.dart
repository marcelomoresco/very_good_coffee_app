import 'package:coffee_venture_app/src/features/home/domain/entities/coffee.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'coffee_local_storage.dart';

class CoffeeLocalStorageImpl implements CoffeeLocalStorage {
  const CoffeeLocalStorageImpl();

  static const _dbName = 'coffee.db';
  static const _dbVersion = 1;
  static const _table = 'favorites';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    _database = await openDatabase(
      path,
      version: _dbVersion,
      onConfigure: (db) async {
        await db.rawQuery('PRAGMA foreign_keys = ON');
        await db.rawQuery('PRAGMA journal_mode = WAL');
        await db.rawQuery('PRAGMA synchronous = NORMAL');
      },
      onCreate: (db, version) async => _ensureSchema(db),
      onOpen: (db) async => _ensureSchema(db),
      onUpgrade: (db, oldV, newV) async => _ensureSchema(db),
    );

    return _database!;
  }

  Future<void> _ensureSchema(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_table (
        imageUrl TEXT NOT NULL UNIQUE
      )
    ''');
    await db.execute('CREATE UNIQUE INDEX IF NOT EXISTS idx_${_table}_image ON $_table(imageUrl)');
  }

  @override
  Future<void> addFavorite(Coffee coffee) async {
    final db = await database;
    await db.insert(_table, {'imageUrl': coffee.imageUrl}, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  @override
  Future<void> removeFavorite(String imageUrl) async {
    final db = await database;
    await db.delete(_table, where: 'imageUrl = ?', whereArgs: [imageUrl]);
  }

  @override
  Future<List<Coffee>> getFavorites() async {
    final db = await database;
    final result = await db.query(_table, orderBy: 'rowid DESC');
    return result.map((row) => Coffee(imageUrl: row['imageUrl'] as String)).toList();
  }

  @override
  Future<bool> isFavorite(String imageUrl) async {
    final db = await database;
    final result = await db.query(_table, where: 'imageUrl = ?', whereArgs: [imageUrl], limit: 1);
    return result.isNotEmpty;
  }

  @visibleForTesting
  static void clearDatabaseInstance() {
    _database = null;
  }
}
