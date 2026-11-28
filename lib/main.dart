
import 'package:firebase_core/firebase_core.dart';
import 'package:material_ui/material_ui.dart';

import 'app/app.dart';
import 'firebase_options_dev.dart' as dev;
import 'firebase_options_prod.dart' as prod;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const environment = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'dev',
  );

  switch (environment) {
    case 'dev':
      await Firebase.initializeApp(
        options: dev.DefaultFirebaseOptions.currentPlatform,
      );
      break;

    case 'prod':
      await Firebase.initializeApp(
        options: prod.DefaultFirebaseOptions.currentPlatform,
      );
      break;

    default:
      throw UnsupportedError(
        'Environment tidak dikenal: $environment',
      );
  }

  // Verifikasi koneksi Firebase
  final firebaseApp = Firebase.app();

  debugPrint('================================');
  debugPrint('WOrganice Firebase Initialized');
  debugPrint('Environment: $environment');
  debugPrint('Firebase App: ${firebaseApp.name}');
  debugPrint(
    'Firebase Project: ${firebaseApp.options.projectId}',
  );
  debugPrint('================================');

  runApp(const WOrganiceApp());
}