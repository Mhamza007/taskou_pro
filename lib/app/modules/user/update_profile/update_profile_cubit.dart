import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../db/db.dart';
import '../../../../resources/resources.dart';
import '../../../app.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit(
    this.context,
  ) : super(const UpdateProfileState()) {
    profileForm = ProfileForms.profileForm;
    _userStorage = UserStorage();

    _getThemeMode();
    _getProfileDetails();
  }

  final BuildContext context;
  late final FormGroup profileForm;
  late UserStorage _userStorage;
  late bool darkMode;

  _getThemeMode() {
    darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;
  }

  void back() => Navigator.pop(context);

  Future<void> _getProfileDetails() async {
    try {
      String? userData = _userStorage.getUserData();

      if (userData != null) {
        var userMap = jsonDecode(userData);

        emit(
          state.copyWith(
            profileImage: userMap['profile_img'],
          ),
        );

        profileForm.patchValue(userMap);
      }
      String? profileImagePath = _userStorage.getUserProfileImagePath();
      if (profileImagePath != null &&
          profileImagePath.isNotEmpty &&
          File(profileImagePath).existsSync()) {
        emit(
          state.copyWith(
            profileImagePath: profileImagePath,
          ),
        );
      }
    } catch (e) {
      debugPrint('Unable to fetch user details ${e.toString()}');
    }
  }

  Future<void> updateProfile() async {}
}
