import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class ContryMap extends StatelessWidget {

  final String name;
  final List latlng;
  ContryMap(this.name,this.latlng);

  Completer<GoogleMapController> _controller = Completer();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name),backgroundColor: Colors.black,),
      body: GoogleMap(initialCameraPosition: CameraPosition(
      target: LatLng(latlng[0], latlng[1]),
      zoom: 6,
    ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
