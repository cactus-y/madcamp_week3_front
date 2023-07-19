
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';



void main() {runApp(MyApp());}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(36.371144, 127.361941);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle('[{"featureType": "poi","elementType": "labels.icon","stylers": [{"visibility": "off"}]}]'
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 15.0,
        ),
      ),
    );
  }
}



