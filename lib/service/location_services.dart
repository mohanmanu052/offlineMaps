import 'dart:async';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

abstract class IUserCurrentLocation {
  Future<dynamic> startTracking();
  Future<dynamic> stopTracking();
}

class LocationServices implements IUserCurrentLocation {
  StreamSubscription<Position>? _positionStreamSubscription;
  late LocationSettings locationSettings;
  final List<List<dynamic>> csvData = [];

  Future<Position> getUserCurrentLocation() async {
    // TODO: implement getUserCurrentLocation
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    var postion = await Geolocator.getCurrentPosition();

    return postion;
  }

  Future<dynamic>? getUserLocationOnTimeInterVal() async {
    print('coming to location set on time intervals');
    await initLocationSettings();
    _positionStreamSubscription =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      print(
          'the postion lat long data was   ${position?.latitude}       ${position?.latitude}');
      final data = [
        DateTime.now().toString(),
        position?.latitude,
        position?.longitude,
      ];
      csvData.add(data);
      // writeToCsv();
    });
  }

  Future<void> writeToCsv() async {
    print('coming to add csv file');
    // TODO: implement writeToCsv
    final csvFile = File('/path/to/your/file.csv');
    String csv = const ListToCsvConverter().convert(csvData);
    await csvFile.writeAsString(csv);
  }

  Future initLocationSettings() async {
    // TODO: implement initLocationSettings
    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
        forceLocationManager: true,
        intervalDuration: const Duration(seconds: 1),
        //(Optional) Set foreground notification config to keep the app alive
        //when going to the background
        // foregroundNotificationConfig: const ForegroundNotificationConfig(
        //   notificationText:
        //       "Example app will continue to receive your location even when you aren't using it",
        //   notificationTitle: "Running in Background",
        //   enableWakeLock: true,
        // )
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 100,
        pauseLocationUpdatesAutomatically: false,
        //timeLimit: Duration(seconds: 1),
        // Only set to true if our app will be started up in the background.
        showBackgroundLocationIndicator: true,
      );
    } else {
      locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
    }
  }

  @override
  Future startTracking() async {
    // await getUserCurrentLocation();
    getUserLocationOnTimeInterVal();
    // TODO: implement startTracking
  }

  @override
  Future stopTracking() async {
    // TODO: implement stopTracking
    _positionStreamSubscription?.cancel();
  }
}
