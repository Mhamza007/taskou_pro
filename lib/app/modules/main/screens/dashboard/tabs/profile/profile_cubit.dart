import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskou_pro/db/user/user.dart';

import '../../../../../../../resources/resources.dart';
import '../../../../../../app.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    this.context,
  ) : super(const ProfileState()) {
    _userStorage = UserStorage();

    _getThemeMode();
    _getUserData();
  }

  final BuildContext context;
  late bool darkMode;
  late UserStorage _userStorage;

  _getThemeMode() {
    darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;
  }

  _getUserData() {
    var userDataString = _userStorage.getUserData();
    debugPrint('userData $userDataString');
    debugPrint('userData ${_userStorage.getUserProfileImagePath()}');
    if (userDataString != null && userDataString.isNotEmpty) {
      var userData = jsonDecode(userDataString);

      emit(
        state.copyWith(
          userName: '${userData['first_name']} ${userData['last_name']}',
          phoneNumber: '${userData['country_code']} ${userData['user_mobile']}',
          address: '${userData['province']} ${userData['city']}',
          description: userData['description'],
          profileImage: _userStorage.getUserProfileImagePath(),
        ),
      );
    }
  }

  void professionCallback() {
    Navigator.pushNamed(
      context,
      Routes.profession,
      arguments: {
        'profile_mode': true,
      },
    );
  }

  void workPhotosCallback() {
    Navigator.pushNamed(
      context,
      Routes.workPhotos,
      arguments: {
        'profile_mode': true,
      },
    );
  }

  void documentsCallback() {
    Navigator.pushNamed(
      context,
      Routes.documents,
      arguments: {
        'profile_mode': true,
      },
    );
  }

  void pricePerHourCallback() {
    Navigator.pushNamed(
      context,
      Routes.updatePrice,
    );
  }
}
