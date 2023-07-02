import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app.dart';

part 'settings_state.dart';

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
}
