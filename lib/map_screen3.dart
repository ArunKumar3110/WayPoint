import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; 
import 'member.dart';

class MapScreen3 extends StatelessWidget {
  final List<Member> members;

  MapScreen3({required this.members});

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = members.map((member) {
      return 
    Marker(
        point: LatLng(member.latitude, member.longitude),
        width: 40.0,
        height: 40.0,
        child: Image.asset(
          member.imageAssetPath, 
          width: 40,
          height: 40,
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Members Location'),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(members[0].latitude, members[0].longitude),
          initialZoom: 10.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          ),
          MarkerLayer(markers: markers), 
        ],
      ),
    );
  }
}
