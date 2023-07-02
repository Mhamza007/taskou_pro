import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:location/location.dart';

import '../../../../resources/resources.dart';

class BackgroundLocationservice {
  final Location _location = Location();

  StreamSubscription<LocationData>? _locationSubscription;
  // StreamSubscription<DatabaseEvent>? _databaseSubscription;

  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  late DatabaseReference _databaseReference;

  Future<void> startLocationService({required String userId}) async {
    _databaseReference = _firebaseDatabase.ref(
      'tracking/$userId',
    );

    await _location.changeNotificationOptions(
      title: Res.string.appTitle,
      subtitle: Res.string.locationBackgroundNotificationMessage,
    );

    await _location.changeSettings(
      interval: 5000, // 5 seconds
      distanceFilter: 5.0, // 5.0 meters
    );

    _locationSubscription = _location.onLocationChanged.listen(
      (LocationData event) {
        _uploadLocationDateToFirebase(event);
        debugPrint(
          'Location: Latitude ${event.latitude} Longitude ${event.longitude}',
        );
      },
      onError: (error) => debugPrint(
        'Location: error fetching $error',
      ),
    );
  }

  Future<void> stopLocationService() async {
    await _location.enableBackgroundMode(enable: false);
    await _locationSubscription?.cancel();
  }

  Future<void> _uploadLocationDateToFirebase(LocationData locationData) async {
    try {
      await _databaseReference.set(
        {
          'latitude': locationData.latitude,
          'longitude': locationData.longitude,
          'accuracy': locationData.accuracy,
          'altitude': locationData.altitude,
          'speed': '${locationData.speed}',
          'time': locationData.time,
          'isMock': locationData.isMock,
          'verticalAccuracy': locationData.verticalAccuracy,
          'provider': locationData.provider,
        },
      );
    } catch (e) {
      debugPrint(
        'Location: uploadLocationDateToFirebase $e',
      );
    }
  }
}
