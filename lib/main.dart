import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:hb_demo/features/feature/locator.dart';
import 'package:hb_demo/features/feature/view/demoView.dart';
import 'package:hb_demo/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  FirebasePerformance performance = FirebasePerformance.instance;

  Trace loadTimeTrace = performance.newTrace("app_load_time");
  loadTimeTrace.start();

  setupLocator();

  runApp(MyApp(analytics: analytics, loadTimeTrace: loadTimeTrace));
}

class MyApp extends StatelessWidget {
  final FirebaseAnalytics analytics;
  final Trace loadTimeTrace;

  MyApp({required this.analytics, required this.loadTimeTrace});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ResponsiveScreen(loadTimeTrace: loadTimeTrace),
    );
  }
}
