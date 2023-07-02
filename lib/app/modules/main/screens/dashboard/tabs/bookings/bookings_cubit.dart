// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';

import '../../../../../../../db/db.dart';
import '../../../../../../../resources/resources.dart';
import '../../../../../../../sdk/sdk.dart';
import '../../../../../../app.dart';

part 'bookings_state.dart';

class BookingsCubit extends Cubit<BookingsState> {
  BookingsCubit(
    this.context,
  ) : super(const BookingsState()) {
    _bookingsApi = BookingsApi();
    _userStorage = UserStorage();
    _location = Location();
    _backgroundLocationservice = BackgroundLocationservice();

    getBookings();
  }

  final BuildContext context;
  late BookingsApi _bookingsApi;
  late UserStorage _userStorage;
  late Location _location;
  late BackgroundLocationservice _backgroundLocationservice;

  Future<void> getBookings() async {
    try {
      emit(
        state.copyWith(
          currentLoading: true,
        ),
      );

      var isConnected = await NetworkService().getConnectivity();
      if (isConnected) {
        var userToken = _userStorage.getUserToken();
        if (userToken != null) {
          var response = await _bookingsApi.getBookings(
            userToken: userToken,
          );

          if (response?.statusCode == 200 && response?.data != null) {
            var runningList = <GetBookingsData>[];
            var pastList = <GetBookingsData>[];
            var newList = <GetBookingsData>[];

            for (var element in response!.data!) {
              if (element.bookingStatus == '1') {
                newList.add(element);
              } else if (element.bookingStatus == '5') {
                pastList.add(element);
              } else if (element.bookingStatus == '2' ||
                  element.bookingStatus == '3' ||
                  element.bookingStatus == '4') {
                runningList.add(element);
              }
            }

            emit(
              state.copyWith(
                apiResponseStatus: ApiResponseStatus.success,
                newBookingsResponseList: newList,
                runningBookingsResponseList: runningList,
                pastBookingsResponseList: pastList,
              ),
            );
          } else {
            emit(
              state.copyWith(
                apiResponseStatus: ApiResponseStatus.failure,
                message: response?.message ?? Res.string.apiErrorMessage,
                newBookingsResponseList: [],
                runningBookingsResponseList: [],
                pastBookingsResponseList: [],
              ),
            );
          }
        } else {
          emit(
            state.copyWith(
              apiResponseStatus: ApiResponseStatus.failure,
              message: Res.string.userAuthFailedLoginAgain,
              newBookingsResponseList: [],
              runningBookingsResponseList: [],
              pastBookingsResponseList: [],
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            apiResponseStatus: ApiResponseStatus.failure,
            message: Res.string.youAreInOfflineMode,
            newBookingsResponseList: [],
            runningBookingsResponseList: [],
            pastBookingsResponseList: [],
          ),
        );
      }
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: e.toString(),
          newBookingsResponseList: [],
          runningBookingsResponseList: [],
          pastBookingsResponseList: [],
        ),
      );
    } on ResponseException catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: e.toString(),
          newBookingsResponseList: [],
          runningBookingsResponseList: [],
          pastBookingsResponseList: [],
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: Res.string.apiErrorMessage,
          newBookingsResponseList: [],
          runningBookingsResponseList: [],
          pastBookingsResponseList: [],
        ),
      );
    } finally {
      emit(
        state.copyWith(
          currentLoading: false,
          apiResponseStatus: ApiResponseStatus.none,
        ),
      );
    }
  }

  Future<void> rejectBooking({
    String? bookingId,
  }) async {
    try {
      emit(
        state.copyWith(
          currentLoading: true,
        ),
      );

      var userToken = _userStorage.getUserToken();
      // var userToken =
      //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.Ijk1Ig.w_zFbmsk6ZRbt6xx2AgRAB7q1xkpvdN4i8SjGzyIhgI';
      if (userToken != null) {
        var response = await _bookingsApi.rejectBooking(
          userToken: userToken,
          bookingId: bookingId!,
        );

        if (response?.statusCode == 200 && response?.data != null) {
          Helpers.successSnackBar(
            context: context,
            title: response?.message ?? Res.string.success,
          );

          await getBookings();
        } else {
          emit(
            state.copyWith(
              apiResponseStatus: ApiResponseStatus.failure,
              message: response?.message ?? Res.string.apiErrorMessage,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            apiResponseStatus: ApiResponseStatus.failure,
            message: Res.string.userAuthFailedLoginAgain,
          ),
        );
      }
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: e.toString(),
        ),
      );
    } on ResponseException catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: e.toString(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: Res.string.apiErrorMessage,
        ),
      );
    } finally {
      emit(
        state.copyWith(
          currentLoading: false,
          apiResponseStatus: ApiResponseStatus.none,
        ),
      );
    }
  }

  Future<void> acceptBooking({
    required GetBookingsData booking,
  }) async {
    debugPrint('booking ${booking.toMap()}');
    debugPrint('booking lat ${booking.userLat}');
    debugPrint('booking lon ${booking.userLong}');
    // Check if background location is enabled

    var bgModeEnabled = await backgroundLocationEnabled();

    if (bgModeEnabled) {
      var userId = _userStorage.getUserId();
      if (userId != null) {
        _backgroundLocationservice.startLocationService(
          userId: userId,
        );
      }

      try {
        emit(
          state.copyWith(
            currentLoading: true,
          ),
        );

        var userToken = _userStorage.getUserToken();

        if (userToken != null && userToken.isNotEmpty) {
          var response = await _bookingsApi.acceptBooking(
            userToken: userToken,
            bookingId: booking.bookingId!,
          );

          if (response?.statusCode == 200 && response?.data != null) {
            Helpers.successSnackBar(
              context: context,
              title: response?.message ?? Res.string.success,
            );

            var result = await Navigator.pushNamed(
              context,
              Routes.tracking,
              arguments: booking.toMap(),
            );

            await getBookings();
            if (result is Map && result['completed'] == true) {
              DialogUtil.showDialogWithOKButton(
                context,
                message: result['message'],
              );
            }
          } else {
            emit(
              state.copyWith(
                apiResponseStatus: ApiResponseStatus.failure,
                message: response?.message ?? Res.string.apiErrorMessage,
              ),
            );
          }
        } else {
          emit(
            state.copyWith(
              apiResponseStatus: ApiResponseStatus.failure,
              message: Res.string.userAuthFailedLoginAgain,
            ),
          );
        }
      } on NetworkException catch (e) {
        emit(
          state.copyWith(
            apiResponseStatus: ApiResponseStatus.failure,
            message: e.toString(),
          ),
        );
      } on ResponseException catch (e) {
        emit(
          state.copyWith(
            apiResponseStatus: ApiResponseStatus.failure,
            message: e.toString(),
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            apiResponseStatus: ApiResponseStatus.failure,
            message: Res.string.apiErrorMessage,
          ),
        );
      } finally {
        emit(
          state.copyWith(
            currentLoading: false,
            apiResponseStatus: ApiResponseStatus.none,
          ),
        );
      }
    } else {
      Helpers.errorSnackBar(
        context: context,
        title: Res.string.pleaseEnableLocationAllTimes,
      );
    }
  }

  Future<bool> backgroundLocationEnabled() async {
    bool enabled = false;
    try {
      var serviceEnabled = await _location.serviceEnabled();
      if (serviceEnabled) {
        var permissionStatus = await _location.hasPermission();
        if (permissionStatus == PermissionStatus.granted) {
          var bgMode = await _location.enableBackgroundMode();
          if (bgMode) {
            enabled = true;
          } else {
            backgroundLocationEnabled();
          }
        } else {
          await _location.requestPermission();
          backgroundLocationEnabled();
        }
      } else {
        await _location.requestService();
        backgroundLocationEnabled();
      }
    } catch (_) {}
    return enabled;
  }

  Future<void> openRunningBooking({
    required GetBookingsData booking,
  }) async {
    try {
      debugPrint('booking ${booking.toMap()}');
      debugPrint('booking lat ${booking.userLat}');
      debugPrint('booking lon ${booking.userLong}');

      if (booking.bookingStatus == '2') {
        var bgModeEnabled = await backgroundLocationEnabled();
        if (bgModeEnabled) {
          var userId = _userStorage.getUserId();
          if (userId != null) {
            _backgroundLocationservice.startLocationService(
              userId: userId,
            );
          }
        } else {
          Helpers.errorSnackBar(
            context: context,
            title: Res.string.pleaseEnableLocationAllTimes,
          );
        }
      } else {}
      var result = await Navigator.pushNamed(
        context,
        Routes.tracking,
        arguments: booking.toMap(),
      );

      await getBookings();
      if (result is Map && result['completed'] == true) {
        DialogUtil.showDialogWithOKButton(
          context,
          message: result['message'],
        );
      }
    } catch (e) {
      Helpers.errorSnackBar(
        context: context,
        title: Res.string.apiErrorMessage,
      );
    }
  }
}
