// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../db/db.dart';
import '../../../../../resources/resources.dart';
import '../../../../../sdk/sdk.dart';
import '../../../../app.dart';

part 'tracking_state.dart';

class TrackingCubit extends Cubit<TrackingState> {
  TrackingCubit(
    this.context, {
    this.bookingData,
  }) : super(const TrackingState()) {
    _bookingsApi = BookingsApi();
    _userStorage = UserStorage();
    _backgroundLocationservice = BackgroundLocationservice();
  }

  final BuildContext context;
  final Map? bookingData;
  late BookingsApi _bookingsApi;
  late UserStorage _userStorage;
  Completer<GoogleMapController> googleMapcompleter = Completer();
  final Location _location = Location();
  final Set<Marker> markers = {};
  final Set<Polyline> polylines = {};
  final _polylinePoints = PolylinePoints();
  late BackgroundLocationservice _backgroundLocationservice;

  Future<bool> back() async {
    Navigator.pop(context);
    _backgroundLocationservice.stopLocationService();
    return true;
  }

  GetBookingsData? _getBookingData() {
    try {
      return GetBookingsData.fromMap(bookingData as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    if (!googleMapcompleter.isCompleted) {
      googleMapcompleter.complete(controller);
    }
    emit(
      state.copyWith(
        googleMapController: controller,
      ),
    );
    await goToCurrentLocation();
  }

  Future<LocationData?> getCurrentLocation() async {
    LocationData? locationData;
    try {
      var serviceEnabled = await _location.serviceEnabled();
      if (serviceEnabled) {
        var permissionStatus = await _location.hasPermission();
        if (permissionStatus == PermissionStatus.granted) {
          locationData = await _location.getLocation();
        } else {
          await _location.requestPermission();
          await getCurrentLocation();
        }
      } else {
        await _location.requestService();
        await getCurrentLocation();
      }
    } catch (e) {
      locationData = null;
    }
    return locationData;
  }

  Future<void> goToCurrentLocation() async {
    // emit(state.copyWith(loading: true));

    var booking = _getBookingData();
    if (booking != null) {
      emit(
        state.copyWith(
          userName: '${booking.firstName} ${booking.lastName}',
          address: booking.address,
        ),
      );

      if (booking.bookingStatus == '3') {
        emit(
          state.copyWith(
            arrived: true,
          ),
        );
      } else if (booking.bookingStatus == '4') {
        emit(
          state.copyWith(
            arrived: true,
            tracking: true,
          ),
        );
      }
    }

    var locationData = await _location.getLocation();
    if (locationData != null) {
      if (locationData.latitude != null && locationData.longitude != null) {
        state.googleMapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                locationData.latitude!,
                locationData.longitude!,
              ),
              zoom: state.zoom,
            ),
          ),
        );

        if (booking != null &&
            booking.userLat != null &&
            booking.userLong != null) {
          var marker = Marker(
            markerId: const MarkerId('destination'),
            position: LatLng(
              double.parse(booking.userLat!),
              double.parse(booking.userLong!),
            ),
          );
          markers.add(marker);

          if (!state.arrived) {
            var polylineResult =
                await _polylinePoints.getRouteBetweenCoordinates(
              'AIzaSyDUDjFS9FGbT0p2kxV6cqbA5eA9VIp9M0Q',
              PointLatLng(
                locationData.latitude!,
                locationData.longitude!,
              ),
              PointLatLng(
                double.parse(booking.userLat!),
                double.parse(booking.userLong!),
              ),
              avoidTolls: true,
            );
            polylines.add(
              Polyline(
                polylineId: const PolylineId('polyline_route'),
                points: polylineResult.points
                    .map(
                      (e) => LatLng(e.latitude, e.longitude),
                    )
                    .toList(),
                color: Res.colors.materialColor,
                width: 6,
              ),
            );
          }

          emit(
            state.copyWith(
              markers: markers,
              polylines: polylines,
            ),
          );
        } else {
          // Can not navigate
        }
      } else {
        // Error
        debugPrint('goToCurrentLocation lat lon null');
      }
    } else {
      // Error
      debugPrint('goToCurrentLocation locationData null');
    }
  }

  Future<void> directionCallback() async {
    try {
      var booking = _getBookingData();
      if (booking?.userLat != null && booking?.userLong != null) {
        await launchUrl(
          Uri.parse(
            'google.navigation:q=${booking?.userLat},${booking?.userLong}&mode=d',
          ),
        );
      } else {
        throw Exception();
      }
    } catch (e) {
      Helpers.errorSnackBar(
        context: context,
        title: Res.string.apiErrorMessage,
      );
    }
  }

  Future<void> call() async {
    var booking = _getBookingData();
    if (booking != null &&
        booking.userMobile != null &&
        booking.userMobile!.isNotEmpty) {
      await launchUrl(
        Uri.parse(
          'tel:${booking.countryCode}${booking.userMobile}',
        ),
      );
    } else {
      Helpers.errorSnackBar(
        context: context,
        title:
            'Can not call ${booking?.firstName ?? 'User'} ${booking?.lastName ?? ''}',
      );
    }
  }

  Future<void> chat() async {
    try {
      var booking = _getBookingData();
      if (booking?.userId != null && booking?.userId != "") {
        String receiverId = booking!.userId!;

        Navigator.pushNamed(
          context,
          Routes.chat,
          arguments: {
            'receiver_id': receiverId,
            'receiver_name': '${booking.firstName} ${booking.lastName}',
          },
        );
      }
    } catch (e) {
      Helpers.errorSnackBar(
        context: context,
        title: 'Unable to open chat',
      );
    }
  }

  Future<void> arrived() async {
    DialogUtil.showDialogWithYesNoButton(
      context,
      message: Res.string.areYouArrived,
      noBtnText: Res.string.cancel,
      yesBtnCallback: () async {
        Navigator.pop(context);

        try {
          emit(
            state.copyWith(
              loading: true,
            ),
          );

          var isConnected = await NetworkService().getConnectivity();
          if (isConnected) {
            var userToken = _userStorage.getUserToken();
            if (userToken != null) {
              var booking = _getBookingData();
              var response = await _bookingsApi.arrived(
                userToken: userToken,
                bookingId: booking!.bookingId!,
              );
              if (response?.statusCode == 200 && response?.data != null) {
                Helpers.successSnackBar(
                  context: context,
                  title: response?.message ?? Res.string.success,
                );

                markers.clear();
                polylines.clear();

                _backgroundLocationservice.stopLocationService();

                emit(
                  state.copyWith(
                    arrived: true,
                    markers: {},
                    polylines: {},
                  ),
                );
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
          } else {
            emit(
              state.copyWith(
                apiResponseStatus: ApiResponseStatus.failure,
                message: Res.string.youAreInOfflineMode,
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
              loading: false,
              apiResponseStatus: ApiResponseStatus.none,
            ),
          );
        }
      },
    );
  }

  Future<void> startTracking() async {
    DialogUtil.showDialogWithYesNoButton(
      context,
      message: Res.string.areYouSureYouWantToStartTracking,
      noBtnText: Res.string.cancel,
      yesBtnCallback: () async {
        Navigator.pop(context);

        try {
          emit(
            state.copyWith(
              loading: true,
            ),
          );

          var isConnected = await NetworkService().getConnectivity();
          if (isConnected) {
            var userToken = _userStorage.getUserToken();
            if (userToken != null) {
              var booking = _getBookingData();
              var response = await _bookingsApi.startTask(
                userToken: userToken,
                bookingId: booking!.bookingId!,
              );

              if (response?.statusCode == 200 && response?.data != null) {
                Helpers.successSnackBar(
                  context: context,
                  title: response?.message ?? Res.string.success,
                );

                emit(
                  state.copyWith(
                    tracking: true,
                  ),
                );
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
          } else {
            emit(
              state.copyWith(
                apiResponseStatus: ApiResponseStatus.failure,
                message: Res.string.youAreInOfflineMode,
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
              loading: false,
              apiResponseStatus: ApiResponseStatus.none,
            ),
          );
        }
      },
    );
  }

  Future<void> completeTask() async {
    DialogUtil.showDialogWithYesNoButton(
      context,
      message: Res.string.isTaskCompleted,
      noBtnText: Res.string.cancel,
      yesBtnCallback: () async {
        Navigator.pop(context);

        try {
          emit(
            state.copyWith(
              loading: true,
            ),
          );

          var isConnected = await NetworkService().getConnectivity();
          if (isConnected) {
            var userToken = _userStorage.getUserToken();
            if (userToken != null) {
              var booking = _getBookingData();
              var response = await _bookingsApi.completeTask(
                userToken: userToken,
                bookingId: booking!.bookingId!,
              );

              if (response?.statusCode == 200 && response?.data != null) {
                Helpers.successSnackBar(
                  context: context,
                  title: response?.message ?? Res.string.success,
                );

                Navigator.pop(
                  context,
                  {
                    'completed': true,
                    'message': response?.message ?? Res.string.taskCompleted,
                  },
                );
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
          } else {
            emit(
              state.copyWith(
                apiResponseStatus: ApiResponseStatus.failure,
                message: Res.string.youAreInOfflineMode,
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
              loading: false,
              apiResponseStatus: ApiResponseStatus.none,
            ),
          );
        }
      },
    );
  }
}
