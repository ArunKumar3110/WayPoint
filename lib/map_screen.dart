import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String name;
  final List<Map<String, dynamic>> visitedLocations;

  MapScreen({
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.visitedLocations,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late Map<String, dynamic> _startLocation;
  late Map<String, dynamic> _endLocation;

  @override
  void initState() {
    super.initState();
    _startLocation = widget.visitedLocations.first;
    _endLocation = widget.visitedLocations.last;
  }

  // Function to generate polylines for the route
  List<LatLng> _generateRoute() {
    List<LatLng> route = [];
    route.add(LatLng(_startLocation['latitude'], _startLocation['longitude']));
    route.add(LatLng(_endLocation['latitude'], _endLocation['longitude']));
    return route;
  }

  @override
  Widget build(BuildContext context) {
    final route = _generateRoute();

    // Calculate total distance in kilometers
    double totalDistance = Distance().as(
      LengthUnit.Kilometer,
      LatLng(_startLocation['latitude'], _startLocation['longitude']),
      LatLng(_endLocation['latitude'], _endLocation['longitude']),
    );

    // Placeholder duration calculation (Assume average speed of 40 km/h)
    double totalDuration = totalDistance / 40 * 60; // in minutes

    return Scaffold(
      appBar: AppBar(
        title: Text('SEE ROUTE'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color.fromARGB(255, 72, 29, 201),
      ),
      body: Column(
        children: [
          // User Profile Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  child: Text(widget.name[0]),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Change User'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Addresses Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Start and Stop Locations:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                ),
                SizedBox(height: 8),

                // Start Location Dropdown in its own Row
                Row(
                  children: [
                    Flexible(
                      child: DropdownButtonFormField<Map<String, dynamic>>(
                        value: _startLocation,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Start Location',
                        ),
                        items: widget.visitedLocations.map((location) {
                          // Get location name before the first comma
                          String locationName = location['name'].split(',')[0];

                          return DropdownMenuItem<Map<String, dynamic>>(
                            value: location,
                            child: Text(locationName, overflow: TextOverflow.ellipsis),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _startLocation = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),  // Add spacing between the rows

// Stop Location Dropdown in its own Row
                Row(
                  children: [
                    Flexible(
                      // width: 300,  // Set a custom width for the stop location dropdown
                      child: DropdownButtonFormField<Map<String, dynamic>>(
                        value: _endLocation,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Stop Location',
                        ),
                        items: widget.visitedLocations.map((location) {
                          // Get location name before the first comma
                          String locationName = location['name'].split(',')[0];

                          return DropdownMenuItem<Map<String, dynamic>>(
                            value: location,
                            child: Text(locationName, overflow: TextOverflow.ellipsis),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _endLocation = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),


          // Route Details Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Route Details:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                ListTile(
                  title: Text('Total Kms: ${totalDistance.toStringAsFixed(2)} kms'),
                ),
                ListTile(
                  title: Text('Total Duration: ${totalDuration.toStringAsFixed(2)} minutes'),
                ),
              ],
            ),
          ),

          // Map Section
          Container(
            height: 250, // Adjust height as needed
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(widget.latitude, widget.longitude),
                initialZoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                ),
                MarkerLayer(
                  markers: route.map((point) {
                    return Marker(
                      point: point,
                      width: 40.0,
                      height: 40.0,
                      child: Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      ),
                    );
                  }).toList(),
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: route,
                      strokeWidth: 4.0,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Visited Locations Section
          Expanded(
            flex: 4, // 40% of the screen height for the visited locations list
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Visited Locations:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.visitedLocations.length,
                      itemBuilder: (context, index) {
                        final location = widget.visitedLocations[index];
                        return ListTile(
                          title: Text('${location['name']}', overflow: TextOverflow.ellipsis),
                          subtitle: Text('(${location['latitude']}, ${location['longitude']})', overflow: TextOverflow.ellipsis),
                          trailing: Icon(Icons.location_on, color: Colors.red),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
