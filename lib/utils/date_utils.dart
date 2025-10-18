import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class DateUtilsCustom {
  /// Format DateTime string with localized labels (Today, Yesterday)
  static String formatDateTime(BuildContext context, String dateTime) {
    try {
      final l10n = AppLocalizations.of(context)!;
      final DateTime dt = DateTime.parse(dateTime);
      final now = DateTime.now();

      // Check if it's today
      if (dt.year == now.year && dt.month == now.month && dt.day == now.day) {
        return '${l10n.today}, ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
      }

      // Check if it's yesterday
      final yesterday = now.subtract(const Duration(days: 1));
      if (dt.year == yesterday.year && dt.month == yesterday.month && dt.day == yesterday.day) {
        return '${l10n.yesterday}, ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
      }

      // Default format: dd/MM/yy, HH:mm
      return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year % 100}, ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';

    } catch (e) {
      return 'Invalid date';
    }
  }

  /// Format date for display (no time)
  static String formatDate(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
  }

  /// Format time only
  static String formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
