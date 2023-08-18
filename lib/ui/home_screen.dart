import 'package:flutter/material.dart';
import 'package:offline_maps/ui/maps_home.dart';
import 'package:offline_maps/videochat/presentation/app/app.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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