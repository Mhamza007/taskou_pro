import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'app/app.dart';
import 'db/db.dart';
import 'firebase_options.dart';
import 'resources/resources.dart';
import 'resources/values/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await runZonedGuarded(
    () async {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await GetStorage.init();
      await GetStorage.init(USER_BOX);
      await GetStorage.init(THEME_BOX);
      await Res.appTranslations.initLocale();

      if (kReleaseMode) {
        CustomImageCache();
      }

      runApp(const TaskouProApp());
    },
    (error, stack) {
      debugPrintStack(
        stackTrace: stack,
        label: error.toString(),
      );
    },
  );
}
