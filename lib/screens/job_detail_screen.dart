import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/job.dart';
import '../utils/dates.dart';
import '../widgets/job_card.dart';

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key, required this.job});

  final Job job;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final payNote = job.pay.note;

    return Scaffold(
      appBar: AppBar(
        actions: [
          SaveButton(job: job),
          const SizedBox(width: 4),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CategoryBadge(category: job.category, size: 52),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${job.employer} · ${job.category.label}',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Card(
            child: Column(
              children: [
                _FactRow(
                  icon: Icons.place_outlined,
                  label: 'Where',
                  value: '${job.country.flag}  ${job.location}',
                ),
                _FactRow(
                  icon: Icons.calendar_month_outlined,
                  label: 'When',
                  value: formatDateRange(job.start, job.end),
                  detail: formatDuration(job.start, job.end),
                ),
                _FactRow(
                  icon: Icons.payments_outlined,
                  label: 'Pay',
                  value: job.pay.label,
                  detail: payNote,
                ),
                _FactRow(
                  icon: Icons.schedule,
                  label: 'Hours',
                  value: 'About ${job.hoursPerWeek} per week',
                ),
              ],
            ),
          ),
          const _SectionTitle('Where you stay'),
          _StayRow(
            icon: Icons.rv_hookup,
            available: job.vanPitch,
            text: !job.vanPitch
                ? 'No van pitch at the workplace'
                : job.hookup
                ? 'Van pitch with electric hookup'
                : 'Van pitch, no hookup',
          ),
          _StayRow(
            icon: Icons.bed_outlined,
            available: job.housing != Housing.none,
            text: job.housing.label,
          ),
          if (job.stayNote case final note?) ...[
            const SizedBox(height: 8),
            Text(note, style: theme.textTheme.bodyMedium),
          ],
          const _SectionTitle('The work'),
          Text(job.description, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 12),
          for (final task in job.tasks) _Bullet(task),
          const _SectionTitle('Languages'),
          Text(
            job.englishOk
                ? 'English is enough for this job.'
                : 'You need the local language for this job.',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final language in job.languages)
                Tag(icon: Icons.translate, label: language),
            ],
          ),
          if (job.perks.isNotEmpty) ...[
            const _SectionTitle('Perks'),
            for (final perk in job.perks) _Bullet(perk),
          ],
          _SectionTitle('Working in ${job.country.label}'),
          Text(job.country.workRights, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 4),
          Text(
            'This is a summary, not legal advice. Check the official rules '
            'for your nationality before you travel.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
            ),
            onPressed: () => _showContact(context),
            icon: const Icon(Icons.mail_outline),
            label: const Text('Contact employer'),
          ),
        ),
      ),
    );
  }

  void _showContact(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        final theme = Theme.of(sheetContext);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(job.employer, style: theme.textTheme.titleLarge),
                const SizedBox(height: 4),
                Text(
                  'Write a short message: who you are, when you can start, '
                  'and whether you bring your own van.',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                SelectableText(
                  job.contactEmail,
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                FilledButton.tonalIcon(
                  onPressed: () async {
                    await Clipboard.setData(
                      ClipboardData(text: job.contactEmail),
                    );
                    if (sheetContext.mounted) Navigator.of(sheetContext).pop();
                    messenger.showSnackBar(
                      const SnackBar(content: Text('Email address copied')),
                    );
                  },
                  icon: const Icon(Icons.content_copy),
                  label: const Text('Copy email address'),
                ),
                const SizedBox(height: 16),
                Text(
                  'Sample listing: this employer and address are placeholders.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28, bottom: 8),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium
            ?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _FactRow extends StatelessWidget {
  const _FactRow({
    required this.icon,
    required this.label,
    required this.value,
    this.detail,
  });

  final IconData icon;
  final String label;
  final String value;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurfaceVariant;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: muted),
          const SizedBox(width: 12),
          SizedBox(
            width: 56,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(color: muted),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (detail != null)
                  Text(
                    detail!,
                    style: theme.textTheme.bodyMedium?.copyWith(color: muted),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StayRow extends StatelessWidget {
  const _StayRow({
    required this.icon,
    required this.available,
    required this.text,
  });

  final IconData icon;
  final bool available;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: available ? scheme.tertiary : scheme.outline,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: available ? FontWeight.w500 : null,
                color: available ? null : scheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 4, right: 12),
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(child: Text(text, style: theme.textTheme.bodyLarge)),
        ],
      ),
    );
  }
}
