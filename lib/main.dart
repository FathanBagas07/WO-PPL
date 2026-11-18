import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'firebase_options_dev.dart' as dev;
import 'firebase_options_prod.dart' as prod;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const environment = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'dev',
  );

  if (environment == 'dev') {
    await Firebase.initializeApp(
      options: dev.DefaultFirebaseOptions.currentPlatform,
    );
  } else if (environment == 'prod') {
    await Firebase.initializeApp(
      options: prod.DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    throw UnsupportedError(
      'Environment tidak dikenal: $environment',
    );
  }

  runApp(const WOrganiceApp());
}