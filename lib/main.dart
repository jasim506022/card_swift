import 'dart:developer' as developer;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'common/style/apps_constant.dart';
import 'common/style/app_string.dart';
import 'firebase_options.dart';
import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeFirebase();
  await _loadSharedPreferences();
  runApp(const MyApp());
}

/// Initializes Firebase.
/// Any initialization failure is logged without crashing the app.
Future<void> _initializeFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e, stackTrace) {
    developer.log("Firebase initialization failed: $e", stackTrace: stackTrace);
  }
}

/// Loads SharedPreferences and app startup data.
Future<void> _loadSharedPreferences() async {
  try {
    AppsConstant.sharedPreferences = await SharedPreferences.getInstance();

    AppsConstant.isViewed =
        AppsConstant.sharedPreferences?.getBool(AppString.onboardSharePrefer) ??
        false;
  } catch (e, stackTrace) {
    developer.log(
      'SharedPreferences loading failed',
      error: e,
      stackTrace: stackTrace,
    );
  }
}
