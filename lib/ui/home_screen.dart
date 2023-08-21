import 'package:flutter/material.dart';
import 'package:offline_maps/controller/location_controller.dart';
import 'package:offline_maps/ui/maps_home.dart';
import 'package:offline_maps/videochat/presentation/app/app.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
     LocationController   controller = Provider.of<LocationController>(context, listen: false);
     controller.getUserCurrentLocation(context);

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: SafeArea(child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>const MapsHome()));
            }, child: const Text("Maps Screen")),
            const SizedBox( height: 30,),

                        ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>const VideoStreamingApp()));
            }, child: const Text("Video Chat")),

          ],
        ),
      )),
    );
  }
}