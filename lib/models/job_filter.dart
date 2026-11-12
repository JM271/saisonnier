import 'job.dart';

class JobFilter {
  const JobFilter({
    this.query = '',
    this.categories = const {},
    this.countries = const {},
    this.months = const {},
    this.vanPitch = false,
    this.housing = false,
    this.englishOk = false,
  });

  final String query;
  final Set<JobCategory> categories;
  final Set<Country> countries;

  /// Months (1-12) the worker is available; a job matches if it runs in any.
  final Set<int> months;
  final bool vanPitch;
  final bool housing;
  final bool englishOk;

  /// Number of active criteria that live in the filter sheet.
  int get sheetCount =>
      countries.length +
      months.length +
      (vanPitch ? 1 : 0) +
      (housing ? 1 : 0) +
      (englishOk ? 1 : 0);

  bool get isEmpty =>
      query.trim().isEmpty && categories.isEmpty && sheetCount == 0;

  JobFilter copyWith({
    String? query,
    Set<JobCategory>? categories,
    Set<Country>? countries,
    Set<int>? months,
    bool? vanPitch,
    bool? housing,
    bool? englishOk,
  }) {
    return JobFilter(
      query: query ?? this.query,
      categories: categories ?? this.categories,
      countries: countries ?? this.countries,
      months: months ?? this.months,
      vanPitch: vanPitch ?? this.vanPitch,
      housing: housing ?? this.housing,
      englishOk: englishOk ?? this.englishOk,
    );
  }

  bool matches(Job job) {
    if (categories.isNotEmpty && !categories.contains(job.category)) {
      return false;
    }
    if (countries.isNotEmpty && !countries.contains(job.country)) return false;
    if (months.isNotEmpty && job.activeMonths.intersection(months).isEmpty) {
      return false;
    }
    if (vanPitch && !job.vanPitch) return false;
    if (housing && job.housing == Housing.none) return false;
    if (englishOk && !job.englishOk) return false;

    final words = query
        .toLowerCase()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty);
    if (words.isEmpty) return true;
    final haystack =
        '${job.title} ${job.employer} ${job.place} ${job.country.label} '
                '${job.category.label}'
            .toLowerCase();
    return words.every(haystack.contains);
  }
}

/// Returns a copy of [set] with [value] added if absent, removed if present.
Set<T> toggled<T>(Set<T> set, T value) =>
    set.contains(value) ? ({...set}..remove(value)) : {...set, value};
