import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_study/models/autocompleteResult.dart';
import 'package:map_study/models/place.dart';
import 'package:map_study/models/placeDetail.dart';
import 'package:map_study/widgets/credentials.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomeScreen(),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key key}) : super(key: key);

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  Location _currentLocation;
  CameraPosition initialCameraPosition;
  GoogleMapController _controller;

  Map<String, Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print('🔥🔥🔥');
    print(position);
    setState(() {
      _currentLocation = Location(
        lat: position.latitude,
        lng: position.longitude,
      );
      initialCameraPosition = CameraPosition(
        target: LatLng(_currentLocation.lat, _currentLocation.lng),
        zoom: 17,
      );
    });
  }

  void _setPosition(Location location) {
    setState(
      () {
        _currentLocation = location;
        _markers.clear();
        final marker = Marker(
          markerId: MarkerId("curr_loc"),
          position: location.latlng,
          infoWindow: InfoWindow(title: 'Your Location'),
        );
        _markers["Current Location"] = marker;
      },
    );
    _moveCameraToPosition(location);
  }

  void _moveCameraToPosition(Location location) {
    Future.delayed(new Duration(milliseconds: 100), () {
      _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: location.latlng,
          zoom: initialCameraPosition.zoom,
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentLocation != null
          ? Stack(
              children: <Widget>[
                _buildGoogleMap(),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: SearchPlace(
                      onPressed: () async {
                        PlaceDetail result = await Get.to(
                          SearchPlaceScreen(
                            currentLocation: _currentLocation,
                          ),
                          transition: Transition.upToDown,
                        );
                        _setPosition(result.geometry.location);
                      },
                    ),
                  ),
                ),
              ],
            )
          : Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }

  Widget _buildGoogleMap() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: initialCameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
      },
      tiltGesturesEnabled: false,
      markers: _markers.values.toSet(),
    );
  }
}

class SearchPlace extends StatelessWidget {
  SearchPlace({
    Key key,
    this.onPressed,
  }) : super(key: key);

  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: InkWell(
          onTap: onPressed,
          child: Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 5,
                )
              ],
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "어디로 가볼까요?",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black45,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SearchPlaceScreen extends StatefulWidget {
  SearchPlaceScreen({Key key, this.currentLocation}) : super(key: key);
  final Location currentLocation;

  @override
  _SearchPlaceScreenState createState() => _SearchPlaceScreenState();
}

class _SearchPlaceScreenState extends State<SearchPlaceScreen> {
  TextEditingController _searchController = TextEditingController();
  Timer _debounce;
  String _sessionToken;

  Dio dio = Dio();
  AutoCompleteResult result;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = Uuid().v1();
      });
    }
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (_searchController.text.isNotEmpty) {
        _getLocationResult(_searchController.text.trim());
      }
    });
  }

  void _getLocationResult(String input) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';

    try {
      Map<String, dynamic> queryParameters = {
        "input": input,
        "key": PLACES_API_KEY,
        "offset": 3,
        "type": "address",
        "sessionToken": _sessionToken,
        "radius": 30000,
        "location": widget.currentLocation != null
            ? '${widget.currentLocation.lat},${widget.currentLocation.lng}'
            : null
      };

      Response response = await dio.get(
        url,
        queryParameters: queryParameters,
      );

      print(response.data);
      setState(
        () {
          result = AutoCompleteResult.fromJson(response.data);
        },
      );
    } on DioError catch (e) {
      print(e.error);
      print(e.response?.data);
    }
  }

  void _getDetail(String placeId) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json';
    try {
      print(placeId);
      final queryParameters = {
        "place_id": placeId,
        "key": PLACES_API_KEY,
      };
      Response response = await dio.get(
        url,
        queryParameters: queryParameters,
      );

      if (response.data != null) {
        Get.back(result: PlaceDetail.fromJson(response.data['result']));
      }
    } on DioError catch (e) {
      print(e.error);
      print(e.response?.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2),
                      blurRadius: 5,
                    )
                  ],
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: <Widget>[
                    BackButton(),
                    Expanded(
                      child: TextField(
                        autocorrect: false,
                        controller: _searchController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "어디로 가볼까요?",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (result != null)
            if (result.predictions.isNotEmpty)
              ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Place place = result.predictions[index];
                  return ListTile(
                    title: Text(result.predictions[index].description),
                    onTap: () {
                      _getDetail(place.placeId);
                    },
                  );
                },
                itemCount: result.predictions.length,
              )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }
}
