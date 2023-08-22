import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:offline_maps/controller/location_controller.dart';
import 'package:offline_maps/notifications/controller/notification_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class MapsHome extends StatefulWidget {
  const MapsHome({super.key});

  @override
  State<MapsHome> createState() => _MapsHomeState();
}

class _MapsHomeState extends State<MapsHome> {
  LocationController? controller;


    List<LatLng> _points = [

// LatLng(17.437462, 78.448288),
//       LatLng(17.4185, 78.4222),

// LatLng(17.437486, 78.448285),
// LatLng(17.437465, 78.448289),
// LatLng(17.437466, 78.448290),
// LatLng(17.437462, 78.448288),

    ];

  Color _lineColor = Colors.blue;

  final Location _location = Location();
  double _totalDistance = 0.0;
  bool isLocationTrackingEnable=true;
  DateTime? _startTime;
  Timer? _timer;
    LocationPermission? permission;

  void _updateLocation(LocationData locationData) {
    if(isLocationTrackingEnable){

        print('on location cahnged calledd');

    final newPoint = LatLng(locationData.latitude!, locationData.longitude!);
    final Distance distance = new Distance();

    double speedKmps = locationData.speed! * 3.6; // Convert speed to km/h
    if (_points.isNotEmpty) {
      double distance1 = 
      distance(newPoint,_points.last);
      _totalDistance += distance1;
    }

    if (speedKmps > 3) {
      _lineColor = Colors.red;
    } else if (speedKmps > 1 && speedKmps < 3) {
      _lineColor = Colors.orange;
    } else {
      _lineColor = Colors.blue;
    }
if(mounted){


    setState(() {
      _points.add(newPoint);
    });
}
    }else{

    }
  }

    


  @override
  void initState() {
    controller = Provider.of<LocationController>(context, listen: false);

    controller?.getUserCurrentLocation(context);

    _location.enableBackgroundMode(enable: true);
        _location.onLocationChanged.listen(_updateLocation);


    _startTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

void stopTracking(){
      _location.onLocationChanged.drain();
    _timer?.cancel();

  setState(() {
      isLocationTrackingEnable = false;
      _timer = null;
    

  });
  
}
  @override
  void dispose() {
    _timer?.cancel();

    controller?.stopTracking();
    // TODO: implement dispose
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Offline Map'),
        ),
        body: Consumer<LocationController>(
            builder: (context, LocationController controler, child) {
          return controler.lattitude == null && controler.longitude == null
              ? const Center(child: CircularProgressIndicator())
              : Stack(
              children: [
                FlutterMap(
                    options: MapOptions(
                      //By Default Coordinates Setted To Delhi
                      center: LatLng(controler.lattitude ?? 28.6139,
                          controler.longitude ?? 77.2090),
                      zoom: 13,
                      maxZoom: 16,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                        tileProvider:
                            FMTC.instance('mapStore').getTileProvider(),
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(controler.lattitude ?? 14.2002691,
                                controler.longitude ?? 75.8869918),
                            width: 250,
                            height: 250,
                            builder: (context) => const Icon(
                              Icons.location_on_sharp,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
PolylineLayer(
  polylines: [
    Polyline(
      strokeWidth: 3,
      borderColor: _lineColor,
                points: _points,
                color: _lineColor,
                borderStrokeWidth: 0.0,
     // isFilled: false,
    ),
  ],
),
      
      
       ]),
       
                 Positioned(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          controller?.startTracking(context);
                        },
                        child: const Text('Start')),
                    ElevatedButton(
                        onPressed: () {
                          controller?.showTotalDistanceTravelled(context,_totalDistance);
                          stopTracking();
                          controller?.stopTracking();
                        },
                        child: const Text('Stop')),



                  ],
                )),


                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    

                  ),
                  child: Column(
                    children: [
_timeDistanceUpdate('Time :', '${_formatDuration(DateTime.now().difference(_startTime??DateTime.now()))}'),
_timeDistanceUpdate('Distance Covered :','${_totalDistance.toString()} Mts'),

                    ],
                  ),
                ),
                

                
                ),


                   
               ] );
        }));
  }



  Widget _timeDistanceUpdate(String titleText,String value){
    return Padding(
      padding: const EdgeInsets.all(10),

child: Row(
  children: [
    Padding(

      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(titleText,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w600
      ),
    
    
      
      ),
    ),
Padding(

      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(value,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w400
      ),
    
    
      
      ),
    ),



  ],
),
    );
  }
}
