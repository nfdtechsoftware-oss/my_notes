// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'My Notes';

  @override
  String get myNotes => 'My Notes';

  @override
  String get newNote => 'New Note';

  @override
  String get addNote => 'Add Note';

  @override
  String get editNote => 'Edit Note';

  @override
  String get viewNote => 'View Note';

  @override
  String get noteTitle => 'Title';

  @override
  String get noteContent => 'Content';

  @override
  String get selectColor => 'Select Color';

  @override
  String get titleRequired => 'Title is required';

  @override
  String get contentRequired => 'Content is required';

  @override
  String get titleHint => 'Enter note title';

  @override
  String get contentHint => 'Enter note content';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get search => 'Search';

  @override
  String get searchNotes => 'Search notes...';

  @override
  String get noNotes => 'No notes found';

  @override
  String get createFirstNote => 'Create your first note';

  @override
  String get noSearchResults => 'No results found';

  @override
  String get deleteNoteTitle => 'Delete Note?';

  @override
  String get deleteNoteMessage => 'This action cannot be undone';

  @override
  String get noteDeleted => 'Note deleted';

  @override
  String get noteSaved => 'Note saved';

  @override
  String get noteUpdated => 'Note updated';

  @override
  String get errorTitle => 'Error';

  @override
  String get errorLoadingNotes => 'Error loading notes';

  @override
  String get errorSavingNote => 'Error saving note';

  @override
  String get errorDeletingNote => 'Error deleting note';

  @override
  String get tryAgain => 'Try again';

  @override
  String get loading => 'Loading...';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String daysAgo(int count) {
    return '$count days ago';
  }

  @override
  String get createdAt => 'Created at';

  @override
  String get updatedAt => 'Updated at';

  @override
  String noteCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'notes',
      one: 'note',
      zero: 'notes',
    );
    return '$count $_temp0';
  }

  @override
  String get goHome => 'Go Home';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get languageDescription => 'Select app language';

  @override
  String get systemDefault => 'System default';

  @override
  String get portuguese => 'Português';

  @override
  String get english => 'English';

  @override
  String get appearance => 'Appearance';

  @override
  String get theme => 'Theme';

  @override
  String get lightTheme => 'Light';

  @override
  String get darkTheme => 'Dark';

  @override
  String get systemTheme => 'System';
}
