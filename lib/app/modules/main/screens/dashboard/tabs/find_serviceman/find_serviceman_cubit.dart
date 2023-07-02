import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../../../../app.dart';

part 'find_serviceman_state.dart';

class FindServicemanCubit extends Cubit<FindServicemanState> {
  FindServicemanCubit(
    this.context,
  ) : super(const FindServicemanState()) {}

  final BuildContext context;
  Completer<GoogleMapController> googleMapcompleter = Completer();
  final Location _location = Location();
  LocationData? locationData;

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
    locationData = await getCurrentLocation();
    if (locationData != null) {
      if (locationData?.latitude != null && locationData?.longitude != null) {
        state.googleMapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                locationData!.latitude!,
                locationData!.longitude!,
              ),
              zoom: state.zoom,
            ),
          ),
        );
      } else {
        // Error
        debugPrint('goToCurrentLocation lat lon null');
      }
    } else {
      // Error
      debugPrint('goToCurrentLocation locationData null');
    }
  }
}
