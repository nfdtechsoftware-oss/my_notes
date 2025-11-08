import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider para gerenciar o idioma selecionado
class LocaleNotifier extends Notifier<Locale?> {
  static const String _localeKey = 'selected_locale';

  @override
  Locale? build() {
    _loadLocale();
    return null;
  }

  /// Carrega o idioma salvo das preferências
  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final localeCode = prefs.getString(_localeKey);

    if (localeCode != null) {
      final parts = localeCode.split('_');
      if (parts.length == 2) {
        state = Locale(parts[0], parts[1]);
      } else {
        state = Locale(parts[0]);
      }
    }
  }

  /// Define o idioma e salva nas preferências
  Future<void> setLocale(Locale? locale) async {
    final prefs = await SharedPreferences.getInstance();

    if (locale == null) {
      await prefs.remove(_localeKey);
      state = null;
    } else {
      final localeCode = locale.countryCode != null
          ? '${locale.languageCode}_${locale.countryCode}'
          : locale.languageCode;
      await prefs.setString(_localeKey, localeCode);
      state = locale;
    }
  }

  /// Limpa o idioma selecionado (volta para o padrão do sistema)
  Future<void> clearLocale() async {
    await setLocale(null);
  }
}

/// Provider global para o idioma
final localeProvider = NotifierProvider<LocaleNotifier, Locale?>(() {
  return LocaleNotifier();
});
