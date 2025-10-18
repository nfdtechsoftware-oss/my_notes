import 'dart:async';
import 'dart:developer' as developer;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/notes_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;
  static const String _databaseName = 'my_notes.db';
  static const int _databaseVersion = 2;

  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      final String path = join(await getDatabasesPath(), _databaseName);

      return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onConfigure: _onConfigure,
      );
    } catch (e) {
      developer.log('Erro ao inicializar banco: $e');
      rethrow;
    }
  }

  Future<void> _onConfigure(Database db) async {
    // Habilita foreign keys
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database db, int version) async {
    const String createNotesTable = '''
      CREATE TABLE notes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL CHECK(length(title) >= 1),
        content TEXT NOT NULL CHECK(length(content) >= 1),
        color TEXT NOT NULL,
        dateTime TEXT NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''';

    const String createIndexes = '''
      CREATE INDEX idx_notes_datetime ON notes(dateTime DESC);
      CREATE INDEX idx_notes_title ON notes(title);
    ''';

    await db.execute(createNotesTable);
    await db.execute(createIndexes);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE notes ADD COLUMN created_at DATETIME DEFAULT CURRENT_TIMESTAMP');
      await db.execute('ALTER TABLE notes ADD COLUMN updated_at DATETIME DEFAULT CURRENT_TIMESTAMP');
      await db.execute('CREATE INDEX idx_notes_datetime ON notes(dateTime DESC)');
      await db.execute('CREATE INDEX idx_notes_title ON notes(title)');
    }
  }

  Future<int> insertNote(Note note) async {
    try {
      final db = await database;
      final noteMap = note.toMap();
      noteMap.remove('id'); // Remove id para auto increment

      return await db.transaction((txn) async {
        return await txn.insert(
          'notes',
          noteMap,
          conflictAlgorithm: ConflictAlgorithm.fail,
        );
      });
    } catch (e) {
      developer.log('Erro ao inserir nota: $e');
      throw DatabaseException('Erro ao salvar nota: $e');
    }
  }

  Future<List<Note>> getNotes({int? limit, int? offset}) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'notes',
        orderBy: 'dateTime DESC',
        limit: limit,
        offset: offset,
      );

      return maps.map((map) => Note.fromMap(map)).toList();
    } catch (e) {
      developer.log('Erro ao carregar notas: $e');
      throw DatabaseException('Erro ao carregar notas: $e');
    }
  }

  Future<Note?> getNoteById(int id) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'notes',
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );

      if (maps.isEmpty) return null;
      return Note.fromMap(maps.first);
    } catch (e) {
      developer.log('Erro ao buscar nota por ID: $e');
      throw DatabaseException('Erro ao buscar nota: $e');
    }
  }

  Future<List<Note>> searchNotes(String query) async {
    try {
      if (query.trim().isEmpty) return getNotes();

      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'notes',
        where: 'title LIKE ? OR content LIKE ?',
        whereArgs: ['%$query%', '%$query%'],
        orderBy: 'dateTime DESC',
      );

      return maps.map((map) => Note.fromMap(map)).toList();
    } catch (e) {
      developer.log('Erro ao pesquisar notas: $e');
      throw DatabaseException('Erro ao pesquisar notas: $e');
    }
  }

  Future<int> updateNote(Note note) async {
    try {
      if (note.id == null) {
        throw ArgumentError('ID da nota não pode ser nulo para atualização');
      }

      final db = await database;
      final noteMap = note.toMap();
      noteMap['updated_at'] = DateTime.now().toIso8601String();

      return await db.transaction((txn) async {
        return await txn.update(
          'notes',
          noteMap,
          where: 'id = ?',
          whereArgs: [note.id],
        );
      });
    } catch (e) {
      developer.log('Erro ao atualizar nota: $e');
      throw DatabaseException('Erro ao atualizar nota: $e');
    }
  }

  Future<int> deleteNote(int id) async {
    try {
      final db = await database;

      return await db.transaction((txn) async {
        return await txn.delete(
          'notes',
          where: 'id = ?',
          whereArgs: [id],
        );
      });
    } catch (e) {
      developer.log('Erro ao deletar nota: $e');
      throw DatabaseException('Erro ao deletar nota: $e');
    }
  }

  Future<int> getNotesCount() async {
    try {
      final db = await database;
      final result = await db.rawQuery('SELECT COUNT(*) as count FROM notes');
      return Sqflite.firstIntValue(result) ?? 0;
    } catch (e) {
      developer.log('Erro ao contar notas: $e');
      throw DatabaseException('Erro ao contar notas: $e');
    }
  }

  Future<void> closeDatabase() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }

  // Para debug e testes
  Future<void> deleteAllNotes() async {
    try {
      final db = await database;
      await db.delete('notes');
    } catch (e) {
      developer.log('Erro ao deletar todas as notas: $e');
      throw DatabaseException('Erro ao deletar todas as notas: $e');
    }
  }
}

class DatabaseException implements Exception {
  final String message;
  const DatabaseException(this.message);

  @override
  String toString() => 'DatabaseException: $message';
}
