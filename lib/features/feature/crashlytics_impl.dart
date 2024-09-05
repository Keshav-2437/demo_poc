import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashlyticsService {
  static void initialize() {
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }

  static void log(String message) {
    FirebaseCrashlytics.instance.log(message);
  }

  static void recordError(dynamic exception, StackTrace stack) {
    FirebaseCrashlytics.instance.recordError(exception, stack);
  }
}
