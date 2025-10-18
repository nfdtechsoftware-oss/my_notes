import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/notes_model.dart';
import '../services/database_helper.dart';

// Main provider for notes list
final notesNotifierProvider = AsyncNotifierProvider<NotesNotifier, List<Note>>(() {
  return NotesNotifier();
});

// Provider for searching notes
final notesSearchProvider = Provider.family<List<Note>, String>((ref, query) {
  final notesAsync = ref.watch(notesNotifierProvider);
  final notes = notesAsync.valueOrNull ?? [];

  if (query.isEmpty) return notes;

  return notes.where((note) {
    return note.title.toLowerCase().contains(query.toLowerCase()) ||
           note.content.toLowerCase().contains(query.toLowerCase());
  }).toList();
});

// Provider for notes statistics
final notesStatsProvider = Provider<Map<String, int>>((ref) {
  final notesAsync = ref.watch(notesNotifierProvider);
  final notes = notesAsync.valueOrNull ?? [];

  return {
    'total': notes.length,
    'today': notes.where((note) {
      final now = DateTime.now();
      final noteDate = note.dateTime;
      return noteDate.year == now.year &&
             noteDate.month == now.month &&
             noteDate.day == now.day;
    }).length,
  };
});

/// Notes state management with Riverpod AsyncNotifier
///
/// Handles all CRUD operations with optimistic updates and error handling
class NotesNotifier extends AsyncNotifier<List<Note>> {
  DatabaseHelper? _databaseHelper;

  DatabaseHelper get databaseHelper {
    _databaseHelper ??= DatabaseHelper();
    return _databaseHelper!;
  }

  @override
  Future<List<Note>> build() async {
    return _loadNotes();
  }

  Future<List<Note>> _loadNotes() async {
    try {
      return await databaseHelper.getNotes();
    } catch (e) {
      throw Exception('Erro ao carregar notas: $e');
    }
  }

  /// Add a new note with optimistic update
  Future<void> addNote(Note note) async {
    final currentNotes = state.valueOrNull ?? [];
    final tempId = DateTime.now().millisecondsSinceEpoch;
    final tempNote = note.copyWith(id: tempId);

    // Optimistic update
    state = AsyncValue.data([tempNote, ...currentNotes]);

    try {
      final realId = await databaseHelper.insertNote(note);
      final realNote = note.copyWith(id: realId);

      final updatedNotes = [
        realNote,
        ...currentNotes,
      ];

      state = AsyncValue.data(updatedNotes);
    } catch (e) {
      // Rollback on error
      state = AsyncValue.data(currentNotes);
      rethrow;
    }
  }

  /// Update an existing note with optimistic update
  Future<void> updateNote(Note note) async {
    final currentNotes = state.valueOrNull ?? [];

    final updatedNotes = currentNotes.map((n) {
      return n.id == note.id ? note : n;
    }).toList();

    // Optimistic update
    state = AsyncValue.data(updatedNotes);

    try {
      await databaseHelper.updateNote(note);
    } catch (e) {
      // Rollback on error
      state = AsyncValue.data(currentNotes);
      rethrow;
    }
  }

  /// Delete a note with optimistic update
  Future<void> deleteNote(int id) async {
    final currentNotes = state.valueOrNull ?? [];

    final updatedNotes = currentNotes.where((note) => note.id != id).toList();

    // Optimistic update
    state = AsyncValue.data(updatedNotes);

    try {
      await databaseHelper.deleteNote(id);
    } catch (e) {
      // Rollback on error
      state = AsyncValue.data(currentNotes);
      rethrow;
    }
  }

  /// Refresh notes from database
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadNotes());
  }
}
