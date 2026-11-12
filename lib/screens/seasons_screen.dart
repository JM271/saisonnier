import 'package:flutter/material.dart';

import '../data/seasons.dart';
import '../models/job.dart';
import '../utils/dates.dart';
import '../widgets/job_card.dart';

/// "What is in season where": pick a month, see the work that happens then.
class SeasonsScreen extends StatefulWidget {
  const SeasonsScreen({super.key, required this.jobs});

  final List<Job> jobs;

  @override
  State<SeasonsScreen> createState() => _SeasonsScreenState();
}

class _SeasonsScreenState extends State<SeasonsScreen> {
  int _month = DateTime.now().month;

  List<Job> _jobsFor(Season season) =>
      widget.jobs.where((job) => job.seasonId == season.id).toList()
        ..sort((a, b) => a.start.compareTo(b.start));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final active = seasons
        .where((season) => season.months.contains(_month))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Season calendar')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        children: [
          _MonthPicker(
            selected: _month,
            onSelected: (month) => setState(() => _month = month),
          ),
          const SizedBox(height: 20),
          Text(
            'In season in ${monthsLong[_month - 1]}',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          for (final season in active)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _SeasonCard(
                season: season,
                month: _month,
                jobs: _jobsFor(season),
              ),
            ),
        ],
      ),
    );
  }
}

class _MonthPicker extends StatelessWidget {
  const _MonthPicker({required this.selected, required this.onSelected});

  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final firstMonth in const [1, 7])
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                for (var month = firstMonth; month < firstMonth + 6; month++)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: _MonthTile(
                        month: month,
                        selected: month == selected,
                        onTap: () => onSelected(month),
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class _MonthTile extends StatelessWidget {
  const _MonthTile({
    required this.month,
    required this.selected,
    required this.onTap,
  });

  final int month;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Semantics(
      button: true,
      selected: selected,
      label: monthsLong[month - 1],
      excludeSemantics: true,
      child: Material(
        color: selected ? scheme.primary : scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 44,
            child: Center(
              child: Text(
                monthsShort[month - 1],
                style: theme.textTheme.labelLarge?.copyWith(
                  color: selected ? scheme.onPrimary : scheme.onSurface,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SeasonCard extends StatelessWidget {
  const _SeasonCard({
    required this.season,
    required this.month,
    required this.jobs,
  });

  final Season season;
  final int month;
  final List<Job> jobs;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(season.icon, color: scheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        season.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        season.regions,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _MonthStrip(active: season.months, current: month),
            const SizedBox(height: 12),
            Text(season.blurb, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 8),
            if (jobs.isEmpty)
              Text(
                'No listings yet',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: scheme.outline,
                ),
              )
            else
              Align(
                alignment: Alignment.centerLeft,
                child: FilledButton.tonalIcon(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) =>
                          SeasonJobsScreen(season: season, jobs: jobs),
                    ),
                  ),
                  icon: const Icon(Icons.arrow_forward, size: 18),
                  iconAlignment: IconAlignment.end,
                  label: Text(
                    jobs.length == 1
                        ? '1 open job'
                        : '${jobs.length} open jobs',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Twelve small bars, January to December, filled where the season runs.
class _MonthStrip extends StatelessWidget {
  const _MonthStrip({required this.active, required this.current});

  final Set<int> active;
  final int current;

  static const _initials = 'JFMAMJJASOND';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return ExcludeSemantics(
      child: Row(
        children: [
          for (var month = 1; month <= 12; month++)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.5),
                child: Column(
                  children: [
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: active.contains(month)
                            ? scheme.primary
                            : scheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _initials[month - 1],
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: month == current ? FontWeight.w800 : null,
                        color: month == current
                            ? scheme.onSurface
                            : scheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class SeasonJobsScreen extends StatelessWidget {
  const SeasonJobsScreen({super.key, required this.season, required this.jobs});

  final Season season;
  final List<Job> jobs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(season.title)),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        itemCount: jobs.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) => JobCard(job: jobs[index]),
      ),
    );
  }
}
