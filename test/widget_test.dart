import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saisonnier/app.dart';
import 'package:saisonnier/data/sample_jobs.dart';
import 'package:saisonnier/data/seasons.dart';
import 'package:saisonnier/models/job.dart';
import 'package:saisonnier/models/job_filter.dart';
import 'package:saisonnier/state/saved_jobs.dart';
import 'package:saisonnier/utils/dates.dart';
import 'package:shared_preferences/shared_preferences.dart';

Job jobById(String id) => sampleJobs.firstWhere((job) => job.id == id);

Future<void> pumpApp(WidgetTester tester) async {
  // A typical phone: 412 x 915 logical pixels.
  tester.view.devicePixelRatio = 2.625;
  tester.view.physicalSize = const Size(1080, 2400);
  addTearDown(tester.view.reset);

  SharedPreferences.setMockInitialValues({});
  final saved = await SavedJobs.load();
  await tester.pumpWidget(SaisonnierApp(saved: saved, jobs: sampleJobs));
}

void main() {
  group('sample data', () {
    test('ids are unique and dates are ordered', () {
      expect(sampleJobs.map((job) => job.id).toSet().length, sampleJobs.length);
      for (final job in sampleJobs) {
        expect(job.end.isAfter(job.start), isTrue, reason: job.id);
      }
    });

    test('every job points at a known season that covers its start', () {
      final byId = {for (final season in seasons) season.id: season};
      for (final job in sampleJobs) {
        final season = byId[job.seasonId];
        expect(season, isNotNull, reason: job.id);
        expect(season!.months, contains(job.start.month), reason: job.id);
      }
    });

    test('a hookup implies a van pitch', () {
      for (final job in sampleJobs.where((job) => job.hookup)) {
        expect(job.vanPitch, isTrue, reason: job.id);
      }
    });
  });

  group('Job', () {
    test('activeMonths wraps across the new year', () {
      expect(jobById('lifts-val-thorens').activeMonths, {12, 1, 2, 3, 4});
      expect(jobById('grapes-champagne').activeMonths, {9});
    });

    test('pay labels group thousands and keep cents', () {
      expect(const Pay(2050, PayUnit.month).label, '€2,050 / month');
      expect(const Pay(14.6, PayUnit.hour).label, '€14.60 / hour');
      expect(
        const Pay(228, PayUnit.hour, currency: 'NOK').label,
        'NOK 228 / hour',
      );
    });
  });

  group('JobFilter', () {
    List<String> ids(JobFilter filter) =>
        sampleJobs.where(filter.matches).map((job) => job.id).toList();

    test('empty filter matches everything', () {
      expect(ids(const JobFilter()).length, sampleJobs.length);
    });

    test('months match jobs running at any point in that month', () {
      final february = ids(const JobFilter(months: {2}));
      expect(february, contains('lifts-val-thorens'));
      expect(february, contains('skrei-lofoten'));
      expect(february, isNot(contains('grapes-champagne')));
    });

    test('van pitch, housing and language switches narrow the list', () {
      expect(
        ids(const JobFilter(vanPitch: true)),
        isNot(contains('lifts-val-thorens')),
      );
      expect(
        ids(const JobFilter(housing: true)),
        isNot(contains('olives-jaen')),
      );
      expect(
        ids(const JobFilter(englishOk: true)),
        isNot(contains('oranges-valencia')),
      );
    });

    test('query matches all words across title, place and country', () {
      expect(ids(const JobFilter(query: 'grape switzerland')), [
        'grapes-lavaux',
      ]);
      expect(ids(const JobFilter(query: '  LOFOTEN ')), ['skrei-lofoten']);
    });

    test('criteria combine', () {
      final result = ids(
        const JobFilter(
          categories: {JobCategory.harvest},
          countries: {Country.germany},
          months: {9},
          vanPitch: true,
        ),
      );
      expect(result, unorderedEquals(['hops-hallertau', 'grapes-mosel']));
    });
  });

  group('dates', () {
    test('ranges show the start year only when it differs', () {
      expect(
        formatDateRange(DateTime(2026, 12, 5), DateTime(2027, 4, 25)),
        '5 Dec 2026 – 25 Apr 2027',
      );
      expect(
        formatDateRange(DateTime(2027, 9, 6), DateTime(2027, 9, 17)),
        '6 Sep – 17 Sep 2027',
      );
    });

    test('durations scale from days to months', () {
      expect(
        formatDuration(DateTime(2027, 9, 6), DateTime(2027, 9, 17)),
        '12 days',
      );
      expect(
        formatDuration(DateTime(2027, 3, 8), DateTime(2027, 4, 18)),
        '6 weeks',
      );
      expect(
        formatDuration(DateTime(2026, 12, 5), DateTime(2027, 4, 25)),
        '5 months',
      );
    });
  });

  group('app', () {
    testWidgets('search narrows the job list', (tester) async {
      await pumpApp(tester);
      expect(find.text('Olive harvest crew'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'lofoten');
      await tester.pump();

      expect(find.text('Fish processing worker'), findsOneWidget);
      expect(find.text('Olive harvest crew'), findsNothing);
      expect(find.text('1 job found'), findsOneWidget);
    });

    testWidgets('a search with no results offers to clear filters', (
      tester,
    ) async {
      await pumpApp(tester);
      await tester.enterText(find.byType(TextField), 'astronaut');
      await tester.pump();
      expect(find.text('No jobs match'), findsOneWidget);

      await tester.tap(find.text('Clear all filters'));
      await tester.pump();
      expect(find.text('Olive harvest crew'), findsOneWidget);
    });

    testWidgets('the filter sheet applies the van pitch switch', (
      tester,
    ) async {
      await pumpApp(tester);
      await tester.enterText(find.byType(TextField), 'zillertal st. anton');
      await tester.pump();
      expect(find.text('No jobs match'), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'tyrol');
      await tester.pump();
      expect(find.text('Mountain hut helper'), findsOneWidget);
      expect(find.text('3 jobs found'), findsOneWidget);

      await tester.tap(find.byTooltip('Filters'));
      await tester.pumpAndSettle();
      final vanSwitch = find.text('Van pitch at the workplace');
      await tester.ensureVisible(vanSwitch);
      await tester.pumpAndSettle();
      await tester.tap(vanSwitch);
      await tester.pump();
      await tester.tap(find.text('Show 2 jobs'));
      await tester.pumpAndSettle();

      expect(find.text('Mountain hut helper'), findsNothing);
      expect(find.text('Kitchen porter'), findsOneWidget);
      expect(find.text('2 jobs found'), findsOneWidget);
    });

    testWidgets('saved jobs appear on the Saved tab and persist', (
      tester,
    ) async {
      await pumpApp(tester);
      await tester.tap(find.byTooltip('Save job').first);
      await tester.pump();

      await tester.tap(find.text('Saved'));
      await tester.pumpAndSettle();
      expect(find.text('Saved jobs'), findsOneWidget);
      expect(find.byTooltip('Remove from saved'), findsWidgets);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getStringList('saved_job_ids'), hasLength(1));
    });

    testWidgets('opening a job shows stay details and the contact sheet', (
      tester,
    ) async {
      await pumpApp(tester);
      await tester.tap(find.text('Olive harvest crew'));
      await tester.pumpAndSettle();

      expect(find.text('Where you stay'), findsOneWidget);
      expect(find.text('Van pitch, no hookup'), findsOneWidget);

      await tester.tap(find.text('Contact employer'));
      await tester.pumpAndSettle();
      expect(find.text('cosecha@fincalosalmendros.example'), findsOneWidget);
    });

    testWidgets('the season calendar links to that season\'s jobs', (
      tester,
    ) async {
      await pumpApp(tester);
      await tester.tap(find.text('Seasons'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Sep'));
      await tester.pumpAndSettle();
      expect(find.text('In season in September'), findsOneWidget);

      // In September only the grape harvest has exactly three listings.
      final grapeJobs = find.text('3 open jobs');
      await tester.scrollUntilVisible(grapeJobs, 200);
      await tester.pumpAndSettle();
      await tester.tap(grapeJobs);
      await tester.pumpAndSettle();

      expect(find.byType(BackButton), findsOneWidget);
      expect(find.text('Grape harvest'), findsOneWidget);
      expect(find.text('Grape harvest & cellar hand'), findsOneWidget);
    });
  });
}
