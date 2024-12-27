import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'member.dart';

class MapScreen2 extends StatefulWidget {
  final String name;
  final double latitude; // Member's latitude
  final double longitude; 
  final List<VisitedPlace> visitedPlaces;

  MapScreen2({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.visitedPlaces,
  });

  @override
  _MapScreen2State createState() => _MapScreen2State();
}

class _MapScreen2State extends State<MapScreen2> {
  late double currentLatitude;
  late double currentLongitude;
  late LatLng currentLocation;
  late List<Marker> markers;
  List<LatLng> polylinePoints = []; 

  @override
  void initState() {
    super.initState();

    currentLatitude = widget.latitude;
    currentLongitude = widget.longitude;
    currentLocation = LatLng(currentLatitude, currentLongitude);

    markers = [
      Marker(
        point: currentLocation,
        width: 40.0,
        height: 40.0,
        child: Icon(
          Icons.my_location,
          color: const Color.fromARGB(255, 7, 137, 243),
          size: 40,
        ),
      ),
      ...widget.visitedPlaces.map((place) {
        return Marker(
          point: LatLng(place.latitude, place.longitude),
          width: 40.0,
          height: 40.0,
          child: Icon(
            Icons.location_pin,
            color: Colors.red,
            size: 40,
          ),
        );
      }).toList(),
    ];
  }

  void _showPinnedLocation(LatLng selectedLocation) {
    setState(() {
      polylinePoints = [
        currentLocation, // Start point
        selectedLocation, // End point
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visited Places of ${widget.name}'),
        backgroundColor: const Color.fromARGB(255, 72, 29, 201),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: currentLocation,
              initialZoom: 13.0,
              minZoom: 10.0,
              maxZoom: 18.0,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),
              MarkerLayer(
                markers: markers,
              ),
              // Draw the polyline only if there are points
              if (polylinePoints.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: polylinePoints,
                      strokeWidth: 4.0,
                      color: Colors.blue,
                    ),
                  ],
                ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.visitedPlaces.map((place) {
                  return ListTile(
                    title: Text(place.name),
                    subtitle: Text(
                        'Lat: ${place.latitude}, Long: ${place.longitude}'),
                    onTap: () {
                      _showPinnedLocation(LatLng(place.latitude, place.longitude));
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
