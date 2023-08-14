import 'dart:async';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

import 'package:geolocator/geolocator.dart';

abstract class IUserCurrentLocation {
  Future<dynamic> startTracking();
  Future<dynamic> stopTracking();
}

class LocationServices implements IUserCurrentLocation {
  late LocationSettings locationSettings;
  StreamSubscription<Position>? _positionStreamSubscription;

  final List<List<dynamic>> csvData = [];
  //Location location = Location();
  Timer? timer;

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
    // await initBackgroundLocator();
    // await _startLocator();
    // final _isRunning = await BackgroundLocator.isServiceRunning();

    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) async {
      var postion = await Geolocator.getCurrentPosition();
      csvData.add([postion.latitude, postion.longitude]);
      writeToCsv();
    });
    //setState(() {
    // latitude = location.latitude.toString();
    // longitude = location.longitude.toString();
    // accuracy = location.accuracy.toString();
    // altitude = location.altitude.toString();
    // bearing = location.bearing.toString();
    // speed = location.speed.toString();
    // time = DateTime.fromMillisecondsSinceEpoch(
    //         location.time!.toInt())
    //     .toString();
    //});
  }

  Future<void> writeToCsv() async {
    final List<List<dynamic>> rows = [];
    for (final row in csvData) {
      rows.add(row);
    }
    final String csv = const ListToCsvConverter().convert(rows);
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/location_data.csv';
    final File file = File(path);
    await file.writeAsString(csv);
    print('CSV saved to $path');
  }

  @override
  Future startTracking() async {
    // await getUserCurrentLocation();
    getUserLocationOnTimeInterVal();
    // TODO: implement startTracking
  }

  @override
  Future stopTracking() async {
    timer?.cancel();
    // TODO: implement stopTracking
  }
}
