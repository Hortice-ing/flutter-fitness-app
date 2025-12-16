import 'package:shared_preferences/shared_preferences.dart';

class WeeklyUpdateService {
  static const String _lastUpdateKey = 'lastWeeklyUpdate';

  /// Retourne true si une nouvelle semaine commence
  static Future<bool> shouldUpdate() async {
    final prefs = await SharedPreferences.getInstance();
    final last = prefs.getString(_lastUpdateKey);

    final now = DateTime.now();

    if (last == null) {
      await prefs.setString(_lastUpdateKey, now.toIso8601String());
      return true;
    }

    final lastDate = DateTime.parse(last);
    final difference = now.difference(lastDate).inDays;

    if (difference >= 7) {
      await prefs.setString(_lastUpdateKey, now.toIso8601String());
      return true;
    }

    return false;
  }
}


