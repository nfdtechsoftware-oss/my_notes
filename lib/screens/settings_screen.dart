import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../l10n/app_localizations.dart';
import '../providers/locale_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final selectedLocale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.settings,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 22,
            letterSpacing: -0.3,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Language Section
          _SectionHeader(
            icon: Icons.language,
            title: l10n.language,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: theme.colorScheme.outlineVariant,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                _LanguageTile(
                  title: l10n.systemDefault,
                  subtitle: l10n.languageDescription,
                  locale: null,
                  currentLocale: selectedLocale,
                  onTap: () => ref.read(localeProvider.notifier).setLocale(null),
                ),
                Divider(height: 1, color: theme.colorScheme.outlineVariant),
                _LanguageTile(
                  title: l10n.portuguese,
                  subtitle: 'Português (Brasil)',
                  locale: const Locale('pt', 'BR'),
                  currentLocale: selectedLocale,
                  onTap: () => ref.read(localeProvider.notifier).setLocale(
                        const Locale('pt', 'BR'),
                      ),
                ),
                Divider(height: 1, color: theme.colorScheme.outlineVariant),
                _LanguageTile(
                  title: l10n.english,
                  subtitle: 'English',
                  locale: const Locale('en'),
                  currentLocale: selectedLocale,
                  onTap: () => ref.read(localeProvider.notifier).setLocale(
                        const Locale('en'),
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // App Info
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.note_alt_outlined,
                  size: 48,
                  color: theme.colorScheme.primary.withValues(alpha: 0.5),
                ),
                const SizedBox(height: 8),
                Text(
                  'My Notes',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Version 1.0.1',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const _SectionHeader({
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

class _LanguageTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Locale? locale;
  final Locale? currentLocale;
  final VoidCallback onTap;

  const _LanguageTile({
    required this.title,
    required this.subtitle,
    required this.locale,
    required this.currentLocale,
    required this.onTap,
  });

  bool get isSelected {
    if (locale == null && currentLocale == null) return true;
    if (locale == null || currentLocale == null) return false;
    return locale!.languageCode == currentLocale!.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          color: isSelected ? theme.colorScheme.primary : null,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 13,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: theme.colorScheme.primary,
              size: 24,
            )
          : Icon(
              Icons.circle_outlined,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
              size: 24,
            ),
      onTap: onTap,
    );
  }
}
