import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/config/env_config.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'model/notes_model.dart';
import 'providers/locale_provider.dart';
import 'screens/home_screen.dart';
import 'screens/add_edit_screen.dart';
import 'screens/view_note_screen.dart';
import 'screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EnvConfig.load();

  // Configure system UI overlay (status bar and navigation bar)
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark, // Icons dark for light theme
      statusBarBrightness: Brightness.light, // For iOS
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Enable edge-to-edge mode
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );

  // Force portrait orientation only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLocale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: EnvConfig.appName,
      debugShowCheckedModeBanner: false,

      // Localization
      locale: selectedLocale, // Use selected locale or system default
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
        Locale('en', ''),
      ],

      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      // Routing
      routerConfig: _router,
    );
  }
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) => const AddEditScreen(),
    ),
    GoRoute(
      path: '/edit/:id',
      builder: (context, state) {
        final note = state.extra as Note?;
        if (note == null) {
          return const _ErrorPage(message: 'Note not found');
        }
        return AddEditScreen(note: note);
      },
    ),
    GoRoute(
      path: '/view/:id',
      builder: (context, state) {
        final note = state.extra as Note?;
        if (note == null) {
          return const _ErrorPage(message: 'Note not found');
        }
        return ViewNoteScreen(note: note);
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
  errorBuilder: (context, state) => const _ErrorPage(),
);

class _ErrorPage extends StatelessWidget {
  final String? message;

  const _ErrorPage({this.message});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.errorTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              message ?? l10n.errorTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => context.go('/'),
              icon: const Icon(Icons.home),
              label: Text(l10n.goHome),
            ),
          ],
        ),
      ),
    );
  }
}
