import 'package:flutter/material.dart';

class AppConstants {
  // Informações da aplicação
  static const String appName = 'Notas';
  static const String version = '2.0.0';

  // Configurações de layout
  static const EdgeInsets defaultPadding = EdgeInsets.all(16.0);
  static const EdgeInsets smallPadding = EdgeInsets.all(8.0);
  static const EdgeInsets largePadding = EdgeInsets.all(24.0);

  // Bordas e raios
  static const double defaultBorderRadius = 12.0;
  static const double largeBorderRadius = 16.0;
  static const double smallBorderRadius = 8.0;

  // Elevações
  static const double cardElevation = 2.0;
  static const double dialogElevation = 6.0;
  static const double bottomSheetElevation = 8.0;

  // Durações de animação
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // Configurações de banco de dados
  static const String databaseName = 'notes_app.db';
  static const int databaseVersion = 2;

  // Configurações de paginação
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Limites de conteúdo
  static const int maxTitleLength = 100;
  static const int maxContentLength = 10000;
  static const int minTitleLength = 1;
  static const int minContentLength = 1;

  // Breakpoints para responsividade
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  // Configurações de grid
  static const int mobileGridColumns = 1;
  static const int tabletGridColumns = 2;
  static const int desktopGridColumns = 3;
  static const int largeDesktopGridColumns = 4;

  // Spacing entre elementos
  static const double defaultSpacing = 16.0;
  static const double smallSpacing = 8.0;
  static const double largeSpacing = 24.0;
  static const double extraLargeSpacing = 32.0;

  // Tamanhos de ícones
  static const double smallIconSize = 16.0;
  static const double defaultIconSize = 24.0;
  static const double largeIconSize = 32.0;
  static const double extraLargeIconSize = 48.0;

  // Tamanhos de fonte
  static const double smallFontSize = 12.0;
  static const double defaultFontSize = 14.0;
  static const double mediumFontSize = 16.0;
  static const double largeFontSize = 18.0;
  static const double extraLargeFontSize = 20.0;

  // Configurações de debounce para pesquisa
  static const Duration searchDebounceDelay = Duration(milliseconds: 300);

  // Configurações de snackbar
  static const Duration snackbarDuration = Duration(seconds: 4);
  static const Duration shortSnackbarDuration = Duration(seconds: 2);
  static const Duration longSnackbarDuration = Duration(seconds: 6);

  // Mensagens padrão
  static const String defaultErrorMessage = 'Ocorreu um erro inesperado';
  static const String networkErrorMessage = 'Verifique sua conexão com a internet';
  static const String emptyListMessage = 'Nenhum item encontrado';
  static const String loadingMessage = 'Carregando...';

  // Configurações de validação
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

  // Formato de datas
  static const String defaultDateFormat = 'dd/MM/yyyy';
  static const String defaultTimeFormat = 'HH:mm';
  static const String defaultDateTimeFormat = 'dd/MM/yyyy HH:mm';
  static const String isoDateTimeFormat = "yyyy-MM-ddTHH:mm:ss.SSSZ";

  // URLs e links (se aplicável no futuro)
  static const String repositoryUrl = 'https://github.com/user/notes-app';
  static const String issuesUrl = 'https://github.com/user/notes-app/issues';

  // Configurações de acessibilidade
  static const double minimumTapTargetSize = 44.0;
  static const double accessibleFontScale = 1.0;

  // Chaves para SharedPreferences
  static const String themePreferenceKey = 'theme_preference';
  static const String languagePreferenceKey = 'language_preference';
  static const String firstLaunchKey = 'first_launch';

  // Assets
  static const String iconsPath = 'assets/icons/';
  static const String imagesPath = 'assets/images/';

  // Hero tags
  static const String fabHeroTag = 'add_note_fab';
  static const String searchHeroTag = 'search_bar';

  // Configurações de performance
  static const int maxCacheSize = 100;
  static const Duration cacheExpiration = Duration(hours: 24);
}

// Enum para tipos de nota (futuro)
enum NoteType {
  text,
  checklist,
  reminder,
  image,
  audio,
  link,
}

// Enum para ordem de classificação
enum SortOrder {
  newest,
  oldest,
  alphabetical,
  alphabeticalReverse,
  lastModified,
}

// Enum para tipos de visualização
enum ViewType {
  grid,
  list,
  staggered,
}

// Enum para filtros
enum NoteFilter {
  all,
  today,
  week,
  month,
  favorites,
  archived,
}

// Extensões úteis
extension AppConstantsExtension on AppConstants {
  // Função para determinar o número de colunas baseado na largura
  static int getGridColumns(double width) {
    if (width > AppConstants.desktopBreakpoint) {
      return AppConstants.largeDesktopGridColumns;
    } else if (width > AppConstants.tabletBreakpoint) {
      return AppConstants.desktopGridColumns;
    } else if (width > AppConstants.mobileBreakpoint) {
      return AppConstants.tabletGridColumns;
    } else {
      return AppConstants.mobileGridColumns;
    }
  }

  // Função para determinar se é mobile
  static bool isMobile(double width) {
    return width <= AppConstants.mobileBreakpoint;
  }

  // Função para determinar se é tablet
  static bool isTablet(double width) {
    return width > AppConstants.mobileBreakpoint &&
           width <= AppConstants.tabletBreakpoint;
  }

  // Função para determinar se é desktop
  static bool isDesktop(double width) {
    return width > AppConstants.tabletBreakpoint;
  }
}
