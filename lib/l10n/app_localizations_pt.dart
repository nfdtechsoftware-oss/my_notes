// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'Minhas Notas';

  @override
  String get myNotes => 'Minhas Notas';

  @override
  String get newNote => 'Nova Nota';

  @override
  String get addNote => 'Adicionar Nota';

  @override
  String get editNote => 'Editar Nota';

  @override
  String get viewNote => 'Ver Nota';

  @override
  String get noteTitle => 'Título';

  @override
  String get noteContent => 'Conteúdo';

  @override
  String get selectColor => 'Selecionar Cor';

  @override
  String get titleRequired => 'Título é obrigatório';

  @override
  String get contentRequired => 'Conteúdo é obrigatório';

  @override
  String get titleHint => 'Digite o título da nota';

  @override
  String get contentHint => 'Digite o conteúdo da nota';

  @override
  String get save => 'Salvar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Excluir';

  @override
  String get edit => 'Editar';

  @override
  String get yes => 'Sim';

  @override
  String get no => 'Não';

  @override
  String get search => 'Buscar';

  @override
  String get searchNotes => 'Buscar notas...';

  @override
  String get noNotes => 'Nenhuma nota encontrada';

  @override
  String get createFirstNote => 'Crie sua primeira nota';

  @override
  String get noSearchResults => 'Nenhum resultado encontrado';

  @override
  String get deleteNoteTitle => 'Excluir Nota?';

  @override
  String get deleteNoteMessage => 'Esta ação não pode ser desfeita';

  @override
  String get noteDeleted => 'Nota excluída';

  @override
  String get noteSaved => 'Nota salva';

  @override
  String get noteUpdated => 'Nota atualizada';

  @override
  String get errorTitle => 'Erro';

  @override
  String get errorLoadingNotes => 'Erro ao carregar notas';

  @override
  String get errorSavingNote => 'Erro ao salvar nota';

  @override
  String get errorDeletingNote => 'Erro ao excluir nota';

  @override
  String get tryAgain => 'Tentar novamente';

  @override
  String get loading => 'Carregando...';

  @override
  String get today => 'Hoje';

  @override
  String get yesterday => 'Ontem';

  @override
  String daysAgo(int count) {
    return '$count dias atrás';
  }

  @override
  String get createdAt => 'Criado em';

  @override
  String get updatedAt => 'Atualizado em';

  @override
  String noteCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'notas',
      one: 'nota',
      zero: 'notas',
    );
    return '$count $_temp0';
  }

  @override
  String get goHome => 'Ir para o Início';

  @override
  String get settings => 'Configurações';

  @override
  String get language => 'Idioma';

  @override
  String get languageDescription => 'Selecione o idioma do aplicativo';

  @override
  String get systemDefault => 'Padrão do sistema';

  @override
  String get portuguese => 'Português';

  @override
  String get english => 'English';

  @override
  String get appearance => 'Aparência';

  @override
  String get theme => 'Tema';

  @override
  String get lightTheme => 'Claro';

  @override
  String get darkTheme => 'Escuro';

  @override
  String get systemTheme => 'Sistema';
}
