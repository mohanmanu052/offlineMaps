import 'package:flutter/material.dart';
import 'package:offline_maps/service/location_services.dart';

class LocationController extends ChangeNotifier
    implements IUserCurrentLocation {
  double? lattitude;
  double? longitude;

  LocationServices _locationServices = LocationServices();

  Future getUserCurrentLocation() async {
    print('coming in controller get user currentLocation');
    var positionData = await _locationServices.getUserCurrentLocation();
    lattitude = positionData.latitude;
    longitude = positionData.longitude;
    print('the lattitude was--$lattitude      $longitude');
    notifyListeners();
  }

  @override
  Future startTracking() async {
    getUserCurrentLocation();
    // TODO: implement startTracking
    _locationServices.startTracking();
  }

  @override
  Future stopTracking() async {
    // TODO: implement stopTracking
    _locationServices.stopTracking();
  }
}
