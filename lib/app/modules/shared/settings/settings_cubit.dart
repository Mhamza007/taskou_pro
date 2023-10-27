import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../resources/resources.dart';
import '../../../app.dart';

part 'settings_state.dart';

enum AppLanguage { en, fr }

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(
    this.context,
  ) : super(const SettingsState());

  final BuildContext context;

  void back() => Navigator.pop(context);

  void navigateToChangePassword() {
    Navigator.pushNamed(
      context,
      Routes.changePassword,
    );
  }

  void changeLanguage() {
    var language = AppLanguage.en;
    var locale = Res.appTranslations.getLocale();
    if (locale == const Locale('fr')) {
      language = AppLanguage.fr;
    }

    Get.dialog(
      CupertinoAlertDialog(
        title: Text(Res.string.changeLanguage),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioMenuButton(
              value: AppLanguage.en,
              groupValue: language,
              onChanged: (AppLanguage? appLanguage) async {
                language = AppLanguage.en;
                await Res.appTranslations.updateLocale(langCode: 'en');
                Get.back();
              },
              child: const Text('English'),
            ),
            RadioMenuButton(
              value: AppLanguage.fr,
              groupValue: language,
              onChanged: (AppLanguage? appLanguage) async {
                language = AppLanguage.fr;
                await Res.appTranslations.updateLocale(langCode: 'fr');
                Get.back();
              },
              child: const Text('Français'),
            ),
          ],
        ),
      ),
    );
  }
}
