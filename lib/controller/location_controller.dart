import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:offline_maps/service/location_services.dart';

class LocationController extends ChangeNotifier
    implements IUserCurrentLocation {
  double? lattitude;
  double? longitude;
  double? stopLattitude;
  double? stopLongitude;

  final LocationServices _locationServices = LocationServices();



void showTotalDistanceTravelled(BuildContext context, double totalDistance)async{

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('The Total Distance Travelled in meters was ${totalDistance.toString()}')));

}



  Future getUserCurrentLocation(BuildContext context) async {

    print('coming in controller get user currentLocation');

    //await _locationServices. shouldShowRequestRationale();

    //var permiison=await _locationServices.requestPermission();
    var positionData = await _locationServices.getUserCurrentLocation(context);
    lattitude = positionData.latitude;
    longitude = positionData.longitude;
        //NotificationController.requestNotificationPermission();

    print('the lattitude was--$lattitude      $longitude');
    notifyListeners();
  }

  @override
  Future startTracking(BuildContext context) async {
    await getUserCurrentLocation(context);
    _locationServices.startTracking(context);
  }

  @override
  Future stopTracking() async {
    // TODO: implement stopTracking
    _locationServices.stopTracking();
  }
}
