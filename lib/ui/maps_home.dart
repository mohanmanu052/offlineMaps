import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:latlong2/latlong.dart';
import 'package:offline_maps/controller/location_controller.dart';
import 'package:provider/provider.dart';

class MapsHome extends StatefulWidget {
  const MapsHome({super.key});

  @override
  State<MapsHome> createState() => _MapsHomeState();
}

class _MapsHomeState extends State<MapsHome> {
  LocationController? controller;
  @override
  void initState() {
    controller = Provider.of<LocationController>(context, listen: false);
    controller?.getUserCurrentLocation();
    // TODO: implement initState
    super.initState();
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
              : FlutterMap(
                  options: MapOptions(
                    //By Default Coordinates Setted To Delhi
                    center: LatLng(controler.lattitude ?? 28.6139,
                        controler.longitude ?? 77.2090),
                    zoom: 13,
                    maxZoom: 13,
                    minZoom: 3,
                  ),
                  nonRotatedChildren: const [
                      RichAttributionWidget(
                        attributions: [
                          TextSourceAttribution(
                            'OpenStreetMap contributors',
                            // onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                          ),
                        ],
                      ),
                    ],
                  children: [
                      TileLayer(
                        // maxZoom: 18,
                        minZoom: 0,
                        // minNativeZoom: 7,
                        //zoomOffset: 6.0,
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
                    ]);
        }));
  }
}
