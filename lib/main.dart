import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  LocationData currentLocation;
  Location location;
  CameraPosition initialCameraPosition;
  Set<Marker> _markers = {};

  @override
  void initState() {
    location = new Location();
    location.onLocationChanged.listen((LocationData loc) {
      currentLocation = loc;
    });
    _setInitialLocation();
    super.initState();
  }

  void _setInitialLocation() async {
    currentLocation = await location.getLocation();
    // target: LatLng(43.682823, -79.359917)
    setState(() {
      initialCameraPosition = CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 15,
      );
    });

    _markers.add(Marker(
      markerId: MarkerId('myhome'),
      position: LatLng(43.682823, -79.359917), // updated position
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: currentLocation != null
          ? GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: initialCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: _markers,
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
