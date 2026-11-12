import 'package:flutter/material.dart';

import 'models/job.dart';
import 'screens/jobs_screen.dart';
import 'screens/saved_screen.dart';
import 'screens/seasons_screen.dart';
import 'state/saved_jobs.dart';

class SaisonnierApp extends StatelessWidget {
  const SaisonnierApp({super.key, required this.saved, required this.jobs});

  final SavedJobs saved;
  final List<Job> jobs;

  @override
  Widget build(BuildContext context) {
    return SavedJobsScope(
      saved: saved,
      child: MaterialApp(
        title: 'Saisonnier',
        debugShowCheckedModeBanner: false,
        theme: _theme(Brightness.light),
        darkTheme: _theme(Brightness.dark),
        home: _HomeShell(jobs: jobs),
      ),
    );
  }
}

ThemeData _theme(Brightness brightness) {
  final scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF2F6F4F),
    brightness: brightness,
  );
  return ThemeData(
    colorScheme: scheme,
    appBarTheme: const AppBarTheme(centerTitle: false),
    cardTheme: CardThemeData(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: scheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}

class _HomeShell extends StatefulWidget {
  const _HomeShell({required this.jobs});

  final List<Job> jobs;

  @override
  State<_HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<_HomeShell> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final savedCount = SavedJobsScope.of(context).count;

    return Scaffold(
      body: IndexedStack(
        index: _tab,
        children: [
          JobsScreen(jobs: widget.jobs),
          SeasonsScreen(jobs: widget.jobs),
          SavedScreen(jobs: widget.jobs),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (index) => setState(() => _tab = index),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.work_outline),
            selectedIcon: Icon(Icons.work),
            label: 'Jobs',
          ),
          const NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Seasons',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: savedCount > 0,
              label: Text('$savedCount'),
              child: const Icon(Icons.bookmark_border),
            ),
            selectedIcon: Badge(
              isLabelVisible: savedCount > 0,
              label: Text('$savedCount'),
              child: const Icon(Icons.bookmark),
            ),
            label: 'Saved',
          ),
        ],
      ),
    );
  }
}
