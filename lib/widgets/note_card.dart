import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../model/notes_model.dart';
import '../utils/date_utils.dart';
import '../core/theme/app_theme.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    // Use AppTheme function for better text contrast
    final textColor = AppTheme.getContrastingTextColor(note.color);
    final subtitleColor = textColor.withValues(alpha: 0.7);

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      color: note.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and menu
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 8, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      note.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(
                      Icons.more_vert,
                      color: textColor,
                      size: 20,
                    ),
                    color: theme.colorScheme.surface,
                    onSelected: (value) {
                      switch (value) {
                        case 'edit':
                          onEdit?.call();
                          break;
                        case 'delete':
                          onDelete?.call();
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            const Icon(Icons.edit, size: 18),
                            const SizedBox(width: 12),
                            Text(l10n.edit),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            const Icon(Icons.delete, size: 18, color: Colors.red),
                            const SizedBox(width: 12),
                            Text(
                              l10n.delete,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (note.content.isNotEmpty) ...[
                    Text(
                      note.content,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: subtitleColor,
                        height: 1.4,
                      ),
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                  ],

                  // Date and time
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 14,
                        color: subtitleColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        DateUtilsCustom.formatDateTime(
                          context,
                          note.dateTime.toIso8601String(),
                        ),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: subtitleColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Compact note card widget for preview
class CompactNoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;

  const CompactNoteCard({
    super.key,
    required this.note,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = AppTheme.getContrastingTextColor(note.color);
    final subtitleColor = textColor.withValues(alpha: 0.7);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: note.color,
      child: ListTile(
        onTap: onTap,
        title: Text(
          note.title,
          style: theme.textTheme.titleMedium?.copyWith(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          note.content,
          style: theme.textTheme.bodySmall?.copyWith(
            color: subtitleColor,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          DateUtilsCustom.formatDateTime(
            context,
            note.dateTime.toIso8601String(),
          ),
          style: theme.textTheme.bodySmall?.copyWith(
            color: subtitleColor,
          ),
        ),
      ),
    );
  }
}
