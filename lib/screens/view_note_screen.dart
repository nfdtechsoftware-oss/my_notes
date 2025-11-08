import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../l10n/app_localizations.dart';
import '../model/notes_model.dart';
import '../providers/notes_provider.dart';
import '../utils/date_utils.dart';
import '../core/theme/app_theme.dart';

class ViewNoteScreen extends ConsumerWidget {
  final Note note;

  const ViewNoteScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final color = note.color;

    // Use contrasting text color based on note color luminance
    final textColor = AppTheme.getContrastingTextColor(color);

    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_ios_new, color: textColor),
        ),
        actions: [
          IconButton(
            onPressed: () => context.push('/edit/${note.id}', extra: note),
            icon: Icon(Icons.edit, color: textColor),
            tooltip: l10n.edit,
          ),
          IconButton(
            onPressed: () => _showDeleteDialog(context, ref, l10n),
            icon: Icon(Icons.delete, color: textColor),
            tooltip: l10n.delete,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: textColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        DateUtilsCustom.formatDateTime(
                          context,
                          note.dateTime.toIso8601String(),
                        ),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: SelectableText(
                    note.content,
                    style: TextStyle(
                      fontSize: 16,
                      color: theme.colorScheme.onSurface,
                      height: 1.6,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDeleteDialog(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final theme = Theme.of(context);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          l10n.deleteNoteTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          l10n.deleteNoteMessage,
          style: TextStyle(
            color: theme.colorScheme.onSurfaceVariant,
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              l10n.cancel,
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              l10n.delete,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      try {
        await ref.read(notesNotifierProvider.notifier).deleteNote(note.id!);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.noteDeleted),
              backgroundColor: Colors.green,
            ),
          );
          context.pop();
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.errorDeletingNote),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
