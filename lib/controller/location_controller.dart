import 'package:flutter/material.dart';
import 'package:offline_maps/service/location_services.dart';

class LocationController extends ChangeNotifier
    implements IUserCurrentLocation {
  double? lattitude;
  double? longitude;

  LocationServices _locationServices = LocationServices();

  @override
  Future getUserCurrentLocation() async {
    var positionData = await _locationServices.getUserCurrentLocation();
    lattitude = positionData.latitude;
    longitude = positionData.longitude;
    print('the lattitude was--$lattitude      $longitude');
    notifyListeners();
    // TODO: implement getUserCurrentLocation
  }
}
