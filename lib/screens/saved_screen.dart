import 'package:flutter/material.dart';

import '../models/job.dart';
import '../state/saved_jobs.dart';
import '../widgets/job_card.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key, required this.jobs});

  final List<Job> jobs;

  @override
  Widget build(BuildContext context) {
    final saved = SavedJobsScope.of(context);
    final savedJobs = jobs.where((job) => saved.contains(job.id)).toList()
      ..sort((a, b) => a.start.compareTo(b.start));

    return Scaffold(
      appBar: AppBar(title: const Text('Saved jobs')),
      body: savedJobs.isEmpty
          ? const EmptyState(
              icon: Icons.bookmark_border,
              title: 'Nothing saved yet',
              message:
                  'Tap the bookmark on a job to keep it here and plan your '
                  'route around it.',
            )
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: savedJobs.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) => JobCard(job: savedJobs[index]),
            ),
    );
  }
}
