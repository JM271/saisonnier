import 'package:flutter/material.dart';

import '../models/job.dart';
import '../models/job_filter.dart';
import '../widgets/filter_sheet.dart';
import '../widgets/job_card.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key, required this.jobs});

  final List<Job> jobs;

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  final _searchController = TextEditingController();
  JobFilter _filter = const JobFilter();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openFilters() async {
    FocusScope.of(context).unfocus();
    final result = await showFilterSheet(
      context,
      jobs: widget.jobs,
      filter: _filter,
    );
    if (result != null) setState(() => _filter = result);
  }

  void _clearAll() {
    _searchController.clear();
    setState(() => _filter = const JobFilter());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final results = widget.jobs.where(_filter.matches).toList()
      ..sort((a, b) => a.start.compareTo(b.start));

    return Scaffold(
      appBar: AppBar(title: const Text('Saisonnier')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 8, 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    textInputAction: TextInputAction.search,
                    onChanged: (value) => setState(
                      () => _filter = _filter.copyWith(query: value),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Job, place or country',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _filter.query.isEmpty
                          ? null
                          : IconButton(
                              tooltip: 'Clear search',
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                _searchController.clear();
                                setState(
                                  () => _filter = _filter.copyWith(query: ''),
                                );
                              },
                            ),
                      filled: true,
                      fillColor: scheme.surfaceContainerHigh,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Badge(
                  isLabelVisible: _filter.sheetCount > 0,
                  label: Text('${_filter.sheetCount}'),
                  offset: const Offset(-4, 4),
                  child: IconButton(
                    tooltip: 'Filters',
                    icon: const Icon(Icons.tune),
                    onPressed: _openFilters,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: JobCategory.values.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = JobCategory.values[index];
                return FilterChip(
                  avatar: Icon(category.icon, size: 18),
                  label: Text(category.label),
                  showCheckmark: false,
                  selected: _filter.categories.contains(category),
                  onSelected: (_) => setState(
                    () => _filter = _filter.copyWith(
                      categories: toggled(_filter.categories, category),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: results.isEmpty
                ? EmptyState(
                    icon: Icons.search_off,
                    title: 'No jobs match',
                    message:
                        'Try other months or countries, or loosen a filter.',
                    action: FilledButton.tonal(
                      onPressed: _clearAll,
                      child: const Text('Clear all filters'),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    itemCount: results.length + 1,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            _filter.isEmpty
                                ? '${results.length} seasonal jobs across '
                                      'Europe, soonest first'
                                : results.length == 1
                                ? '1 job found'
                                : '${results.length} jobs found',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        );
                      }
                      return JobCard(job: results[index - 1]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
