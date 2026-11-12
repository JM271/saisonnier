import 'package:flutter/material.dart';

import 'app.dart';
import 'data/sample_jobs.dart';
import 'state/saved_jobs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final saved = await SavedJobs.load();
  runApp(SaisonnierApp(saved: saved, jobs: sampleJobs));
}
