import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The set of bookmarked job ids, persisted on the device.
class SavedJobs extends ChangeNotifier {
  SavedJobs(this._prefs) : _ids = {...?_prefs.getStringList(_key)};

  static const _key = 'saved_job_ids';

  final SharedPreferences _prefs;
  final Set<String> _ids;

  static Future<SavedJobs> load() async =>
      SavedJobs(await SharedPreferences.getInstance());

  int get count => _ids.length;

  bool contains(String jobId) => _ids.contains(jobId);

  void toggle(String jobId) {
    if (!_ids.remove(jobId)) _ids.add(jobId);
    notifyListeners();
    _prefs.setStringList(_key, _ids.toList());
  }
}

class SavedJobsScope extends InheritedNotifier<SavedJobs> {
  const SavedJobsScope({
    super.key,
    required SavedJobs saved,
    required super.child,
  }) : super(notifier: saved);

  /// Rebuilds the caller whenever the saved set changes.
  static SavedJobs of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SavedJobsScope>()!.notifier!;
}
