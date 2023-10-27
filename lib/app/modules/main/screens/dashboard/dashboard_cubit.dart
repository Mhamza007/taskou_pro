// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';

import '../../../../../db/db.dart';
import '../../../../../resources/resources.dart';
import '../../../../../sdk/sdk.dart';
import '../../../../app.dart';
part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(
    this.context,
  ) : super(const DashboardState()) {
    scaffoldKey = GlobalKey<ScaffoldState>();
    _userStorage = UserStorage();
    _dashboardApi = DashboardApi();
    // _backgroundLocationservice = BackgroundLocationservice();

    emit(
      state.copyWith(
        themeMode: Res.appTheme.getThemeMode(),
        currentPageTitle: Res.string.home,
      ),
    );

    _getUserData();
    _getUserIsAvailable();
    try {
      initializeFirebaseMessagingService();
    } catch (_) {}
  }

  final BuildContext context;
  FindServicemanCubit? findServicemanCubit;
  BookingsCubit? bookingsCubit;
  ProfileCubit? profileCubit;
  late final GlobalKey<ScaffoldState> scaffoldKey;
  late UserStorage _userStorage;
  late DashboardApi _dashboardApi;
  // late BackgroundLocationservice _backgroundLocationservice;

  void initFindServicemanCubit(FindServicemanCubit findServicemanCubit) {
    this.findServicemanCubit = findServicemanCubit;
  }

  void initBookingsCubit(BookingsCubit bookingsCubit) {
    this.bookingsCubit = bookingsCubit;
  }

  void initProfileCubit(ProfileCubit profileCubit) {
    this.profileCubit = profileCubit;
  }

  void changeThemeMode(ThemeMode themeMode) {
    Res.appTheme.changeThemeMode(themeMode);
    emit(
      state.copyWith(
        themeMode: themeMode,
      ),
    );
  }

  Future<void> _getUserData() async {
    var userData = _userStorage.getUserData();
    if (userData != null) {
      UserLoginData userLoginData = UserLoginData.fromMap(
        jsonDecode(userData),
      );
      emit(
        state.copyWith(
          imageUrl: userLoginData.profileImg,
          userName:
              '${userLoginData.firstName ?? ''} ${userLoginData.lastName ?? ''}',
          phoneNumber: userLoginData.userMobile,
        ),
      );
    }

    try {
      var userId = _userStorage.getUserId();
      // if (userId != null) {
      //   _backgroundLocationservice.startLocationService(
      //     userId: userId,
      //   );
      // }
    } catch (_) {}
  }

  void onItemSelected(int index) {
    emit(
      state.copyWith(
        selectedIndex: index,
        currentPageTitle: index == 1
            ? Res.string.bookings
            : index == 2
                ? Res.string.profile
                : Res.string.home,
      ),
    );

    if (index == 1) {
      bookingsCubit?.getBookings();
    }
  }

  void _getUserIsAvailable() {
    var isAvailable = _userStorage.getUserIsAvailable();
    emit(
      state.copyWith(
        onDuty: isAvailable == '1',
      ),
    );
  }

  void onDutyCallback(bool onDuty) async {
    try {
      emit(
        state.copyWith(
          loading: true,
        ),
      );

      var userToken = _userStorage.getUserToken();

      if (userToken != null && userToken.isNotEmpty) {
        var updateAvailability = await _dashboardApi.updateAvailability(
          userToken: userToken,
          availability: onDuty ? 1 : 0,
        );

        if (updateAvailability?.statusCode == 200) {
          emit(
            state.copyWith(
              onDuty: onDuty,
            ),
          );
        } else {
          Helpers.errorSnackBar(
            context: context,
            title: updateAvailability?.message ?? Res.string.apiErrorMessage,
          );
        }
      } else {
        Helpers.errorSnackBar(
          context: context,
          title: Res.string.apiErrorMessage,
        );
      }
    } catch (e) {
      Helpers.errorSnackBar(
        context: context,
        title: Res.string.apiErrorMessage,
      );
    } finally {
      emit(
        state.copyWith(
          loading: false,
        ),
      );
    }
  }

  void editProfile() {
    Navigator.pushNamed(
      context,
      Routes.updateProfile,
    );
  }

  void showBottomSheetPopup({
    Function()? browseService,
    Function()? postWork,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(48),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ElevatedButton(
              onPressed: browseService,
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  const TextStyle(
                    fontSize: 16,
                  ),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 12.0),
                ),
              ),
              child: Text(
                Res.string.browseService,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: postWork,
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  const TextStyle(
                    fontSize: 16,
                  ),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 12.0),
                ),
              ),
              child: Text(
                Res.string.postWork,
              ),
            ),
          ],
        );
      },
    );
  }

  void home() {
    Navigator.pop(context);
    onItemSelected(0);
  }

  Future<void> settings() async {
    Navigator.pop(context);
    Navigator.pushNamed(context, Routes.settings);
  }

  Future<void> help() async {
    Navigator.pop(context);
    Navigator.pushNamed(context, Routes.help);
  }

  Future<void> subscription() async {
    Navigator.pop(context);
    Navigator.pushNamed(context, Routes.subscription);
  }

  void _logoutAlert({
    Function()? logoutCallback,
  }) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            Res.string.appTitle.toUpperCase(),
            style: TextStyle(
              color: Res.colors.materialColor,
            ),
          ),
          content: Text(
            Res.string.logoutMessage,
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: logoutCallback,
              child: Text(
                Res.string.logout,
                style: TextStyle(
                  color: Res.colors.redColor,
                ),
              ),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                Res.string.cancel,
                style: TextStyle(
                  color: Res.colors.materialColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> logout() async {
    Navigator.pop(context);
    _logoutAlert(
      logoutCallback: () async {
        try {
          await Future.wait(
            [
              _userStorage.setUserId(null),
              _userStorage.setUserMobile(null),
              _userStorage.setUserToken(null),
              _userStorage.setUserType(null),
              _userStorage.setUserFirstName(null),
              _userStorage.setUserLastName(null),
              _userStorage.setUserDeviceToken(null),
              _userStorage.setUserData(null),
              _userStorage.setUserProfessions(null),
              _userStorage.setUserWorkPhotos(null),
              _userStorage.setUserIdFront(null),
              _userStorage.setUserIdBack(null),
              _userStorage.setUserCertificateFront(null),
              _userStorage.setUserCertificateBack(null),
              _userStorage.setUserPricePerHour(null),
            ],
          );

          // Navigate to Login
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.signIn,
            (route) => false,
          );
        } catch (e) {
          debugPrint('$e');
          Helpers.errorSnackBar(
            context: context,
            title: Res.string.errorLoggingOut,
          );
        }
      },
    );

    // try {
    //   _backgroundLocationservice.stopLocationService();
    // } catch (_) {}
  }

  void myReviews() {
    Navigator.pop(context);
    Navigator.pushNamed(context, Routes.myReviews);
  }
}
