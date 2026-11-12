import 'package:flutter/material.dart';

import '../models/job.dart';
import '../models/job_filter.dart';
import '../utils/dates.dart';

/// Opens the filter sheet and resolves to the chosen filter, or null if the
/// sheet was dismissed.
Future<JobFilter?> showFilterSheet(
  BuildContext context, {
  required List<Job> jobs,
  required JobFilter filter,
}) {
  return showModalBottomSheet<JobFilter>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
    builder: (_) => _FilterSheet(jobs: jobs, initial: filter),
  );
}

class _FilterSheet extends StatefulWidget {
  const _FilterSheet({required this.jobs, required this.initial});

  final List<Job> jobs;
  final JobFilter initial;

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  late JobFilter _draft = widget.initial;

  late final List<Country> _countries =
      widget.jobs.map((job) => job.country).toSet().toList()
        ..sort((a, b) => a.label.compareTo(b.label));

  void _update(JobFilter next) => setState(() => _draft = next);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final matches = widget.jobs.where(_draft.matches).length;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      maxChildSize: 1,
      builder: (context, scrollController) => Column(
        children: [
          Expanded(
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              children: [
                Text('Filters', style: theme.textTheme.headlineSmall),
                const _GroupTitle('When are you free?'),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    for (var month = 1; month <= 12; month++)
                      FilterChip(
                        label: Text(monthsShort[month - 1]),
                        showCheckmark: false,
                        selected: _draft.months.contains(month),
                        onSelected: (_) => _update(
                          _draft.copyWith(
                            months: toggled(_draft.months, month),
                          ),
                        ),
                      ),
                  ],
                ),
                const _GroupTitle('Living & language'),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: const Icon(Icons.rv_hookup),
                  title: const Text('Van pitch at the workplace'),
                  value: _draft.vanPitch,
                  onChanged: (value) =>
                      _update(_draft.copyWith(vanPitch: value)),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: const Icon(Icons.bed_outlined),
                  title: const Text('Housing offered'),
                  value: _draft.housing,
                  onChanged: (value) =>
                      _update(_draft.copyWith(housing: value)),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: const Icon(Icons.translate),
                  title: const Text('English is enough'),
                  value: _draft.englishOk,
                  onChanged: (value) =>
                      _update(_draft.copyWith(englishOk: value)),
                ),
                const _GroupTitle('Where?'),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    for (final country in _countries)
                      FilterChip(
                        label: Text('${country.flag}  ${country.label}'),
                        showCheckmark: false,
                        selected: _draft.countries.contains(country),
                        onSelected: (_) => _update(
                          _draft.copyWith(
                            countries: toggled(_draft.countries, country),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Row(
              children: [
                TextButton(
                  onPressed: _draft.sheetCount == 0
                      ? null
                      : () => _update(
                          JobFilter(
                            query: _draft.query,
                            categories: _draft.categories,
                          ),
                        ),
                  child: const Text('Reset'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                    ),
                    onPressed: () => Navigator.of(context).pop(_draft),
                    child: Text(
                      matches == 1 ? 'Show 1 job' : 'Show $matches jobs',
                    ),
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

class _GroupTitle extends StatelessWidget {
  const _GroupTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
