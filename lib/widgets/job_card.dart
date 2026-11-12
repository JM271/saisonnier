import 'package:flutter/material.dart';

import '../models/job.dart';
import '../screens/job_detail_screen.dart';
import '../state/saved_jobs.dart';
import '../utils/dates.dart';

class JobCard extends StatelessWidget {
  const JobCard({super.key, required this.job});

  final Job job;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => JobDetailScreen(job: job)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 4, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: CategoryBadge(category: job.category),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            job.employer,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SaveButton(job: job),
                ],
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _MetaRow(
                      icon: Icons.place_outlined,
                      text: '${job.country.flag}  ${job.location}',
                    ),
                    _MetaRow(
                      icon: Icons.calendar_month_outlined,
                      text:
                          '${formatDateRange(job.start, job.end)} · '
                          '${formatDuration(job.start, job.end)}',
                    ),
                    _MetaRow(
                      icon: Icons.payments_outlined,
                      text: job.pay.label,
                    ),
                    if (_tags.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Wrap(spacing: 6, runSpacing: 6, children: _tags),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> get _tags => [
    if (job.vanPitch)
      Tag(
        icon: Icons.rv_hookup,
        label: job.hookup ? 'Van pitch + hookup' : 'Van pitch',
        highlight: true,
      ),
    if (job.housing != Housing.none)
      Tag(
        icon: Icons.bed_outlined,
        label: job.housing == Housing.free ? 'Housing included' : 'Housing',
      ),
    if (job.englishOk) const Tag(icon: Icons.translate, label: 'English OK'),
  ];
}

class CategoryBadge extends StatelessWidget {
  const CategoryBadge({super.key, required this.category, this.size = 40});

  final JobCategory category;
  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(size * 0.3),
      ),
      child: Icon(
        category.icon,
        size: size * 0.55,
        color: scheme.onPrimaryContainer,
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.job});

  final Job job;

  @override
  Widget build(BuildContext context) {
    final saved = SavedJobsScope.of(context);
    final isSaved = saved.contains(job.id);
    return IconButton(
      tooltip: isSaved ? 'Remove from saved' : 'Save job',
      isSelected: isSaved,
      icon: const Icon(Icons.bookmark_border),
      selectedIcon: const Icon(Icons.bookmark),
      onPressed: () => saved.toggle(job.id),
    );
  }
}

class Tag extends StatelessWidget {
  const Tag({
    super.key,
    required this.icon,
    required this.label,
    this.highlight = false,
  });

  final IconData icon;
  final String label;

  /// Uses the accent colour; reserved for the van pitch tag.
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final foreground = highlight
        ? scheme.onTertiaryContainer
        : scheme.onSurfaceVariant;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: highlight
            ? scheme.tertiaryContainer
            : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: foreground),
          const SizedBox(width: 4),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(color: foreground),
          ),
        ],
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 16, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

/// Centered icon, headline and hint for empty lists.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.action,
  });

  final IconData icon;
  final String title;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: theme.colorScheme.outline),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            if (action != null) ...[const SizedBox(height: 16), action!],
          ],
        ),
      ),
    );
  }
}
