import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  /// Nome da aplicação
  ///
  /// In pt, this message translates to:
  /// **'Minhas Notas'**
  String get appName;

  /// Título da tela principal
  ///
  /// In pt, this message translates to:
  /// **'Minhas Notas'**
  String get myNotes;

  /// Botão para criar nova nota
  ///
  /// In pt, this message translates to:
  /// **'Nova Nota'**
  String get newNote;

  /// Título da tela de adicionar nota
  ///
  /// In pt, this message translates to:
  /// **'Adicionar Nota'**
  String get addNote;

  /// Título da tela de editar nota
  ///
  /// In pt, this message translates to:
  /// **'Editar Nota'**
  String get editNote;

  /// Título da tela de visualizar nota
  ///
  /// In pt, this message translates to:
  /// **'Ver Nota'**
  String get viewNote;

  /// Label do campo título
  ///
  /// In pt, this message translates to:
  /// **'Título'**
  String get noteTitle;

  /// Label do campo conteúdo
  ///
  /// In pt, this message translates to:
  /// **'Conteúdo'**
  String get noteContent;

  /// Label para seleção de cor
  ///
  /// In pt, this message translates to:
  /// **'Selecionar Cor'**
  String get selectColor;

  /// Mensagem de validação do título
  ///
  /// In pt, this message translates to:
  /// **'Título é obrigatório'**
  String get titleRequired;

  /// Mensagem de validação do conteúdo
  ///
  /// In pt, this message translates to:
  /// **'Conteúdo é obrigatório'**
  String get contentRequired;

  /// Dica do campo título
  ///
  /// In pt, this message translates to:
  /// **'Digite o título da nota'**
  String get titleHint;

  /// Dica do campo conteúdo
  ///
  /// In pt, this message translates to:
  /// **'Digite o conteúdo da nota'**
  String get contentHint;

  /// Botão salvar
  ///
  /// In pt, this message translates to:
  /// **'Salvar'**
  String get save;

  /// Botão cancelar
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// Botão excluir
  ///
  /// In pt, this message translates to:
  /// **'Excluir'**
  String get delete;

  /// Botão editar
  ///
  /// In pt, this message translates to:
  /// **'Editar'**
  String get edit;

  /// Confirmação sim
  ///
  /// In pt, this message translates to:
  /// **'Sim'**
  String get yes;

  /// Confirmação não
  ///
  /// In pt, this message translates to:
  /// **'Não'**
  String get no;

  /// Botão buscar
  ///
  /// In pt, this message translates to:
  /// **'Buscar'**
  String get search;

  /// Hint do campo de busca
  ///
  /// In pt, this message translates to:
  /// **'Buscar notas...'**
  String get searchNotes;

  /// Mensagem quando não há notas
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma nota encontrada'**
  String get noNotes;

  /// Mensagem de incentivo para criar primeira nota
  ///
  /// In pt, this message translates to:
  /// **'Crie sua primeira nota'**
  String get createFirstNote;

  /// Mensagem quando busca não retorna resultados
  ///
  /// In pt, this message translates to:
  /// **'Nenhum resultado encontrado'**
  String get noSearchResults;

  /// Título do diálogo de confirmação de exclusão
  ///
  /// In pt, this message translates to:
  /// **'Excluir Nota?'**
  String get deleteNoteTitle;

  /// Mensagem do diálogo de confirmação de exclusão
  ///
  /// In pt, this message translates to:
  /// **'Esta ação não pode ser desfeita'**
  String get deleteNoteMessage;

  /// Mensagem de sucesso ao excluir nota
  ///
  /// In pt, this message translates to:
  /// **'Nota excluída'**
  String get noteDeleted;

  /// Mensagem de sucesso ao salvar nota
  ///
  /// In pt, this message translates to:
  /// **'Nota salva'**
  String get noteSaved;

  /// Mensagem de sucesso ao atualizar nota
  ///
  /// In pt, this message translates to:
  /// **'Nota atualizada'**
  String get noteUpdated;

  /// Título de diálogo de erro
  ///
  /// In pt, this message translates to:
  /// **'Erro'**
  String get errorTitle;

  /// Mensagem de erro ao carregar notas
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar notas'**
  String get errorLoadingNotes;

  /// Mensagem de erro ao salvar nota
  ///
  /// In pt, this message translates to:
  /// **'Erro ao salvar nota'**
  String get errorSavingNote;

  /// Mensagem de erro ao excluir nota
  ///
  /// In pt, this message translates to:
  /// **'Erro ao excluir nota'**
  String get errorDeletingNote;

  /// Botão para tentar novamente
  ///
  /// In pt, this message translates to:
  /// **'Tentar novamente'**
  String get tryAgain;

  /// Mensagem de carregamento
  ///
  /// In pt, this message translates to:
  /// **'Carregando...'**
  String get loading;

  /// Palavra 'hoje' para datas
  ///
  /// In pt, this message translates to:
  /// **'Hoje'**
  String get today;

  /// Palavra 'ontem' para datas
  ///
  /// In pt, this message translates to:
  /// **'Ontem'**
  String get yesterday;

  /// Formato de dias atrás
  ///
  /// In pt, this message translates to:
  /// **'{count} dias atrás'**
  String daysAgo(int count);

  /// Label de data de criação
  ///
  /// In pt, this message translates to:
  /// **'Criado em'**
  String get createdAt;

  /// Label de data de atualização
  ///
  /// In pt, this message translates to:
  /// **'Atualizado em'**
  String get updatedAt;

  /// Contador de notas com plural
  ///
  /// In pt, this message translates to:
  /// **'{count} {count, plural, =0{notas} =1{nota} other{notas}}'**
  String noteCount(int count);

  /// Botão para voltar à tela inicial
  ///
  /// In pt, this message translates to:
  /// **'Ir para o Início'**
  String get goHome;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
