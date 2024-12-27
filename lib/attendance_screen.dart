import 'package:flutter/material.dart';
import 'dart:math';
import 'map_screen.dart';
import 'map_screen2.dart';
import 'map_screen3.dart';
import 'member.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const Color ombrePurpleStart = Color(0xFF6A1B9A); // Deep Purple
const Color ombrePurpleMid = Color(0xFF8E24AA); // Medium Purple
const Color ombrePurpleEnd = Color(0xFFD81B60); // Pinkish Purple
const Color ombreAccent = Color(0xFFF06292); // Light Purple-Pink Accent
const Color backgroundLight =
Color(0xFFF3E5F5); // Very Light Purple for backgrounds
const Color textLight = Colors.white; // Light text
const Color textDark = Colors.black87;




class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, List<Map<String, dynamic>>> userVisitedLocations = {};

  // Function to get location name using latitude and longitude
  Future<String> _getLocationName(double latitude, double longitude) async {
    final apiUrl =
        'https://nominatim.openstreetmap.org/reverse?lat=$latitude&lon=$longitude&format=json'; // Nominatim API for reverse geocoding
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.containsKey('display_name')) {
          return data['display_name'] ?? 'Unknown Location';
        }
      }
    } catch (e) {
      print('Error occurred: $e');
    }
    return 'Unknown Location';  // Default in case of error
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Attendance',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 72, 29, 201),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: ombrePurpleStart,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Row(
                  children: [
                    Icon(
                      Icons.av_timer, // Replace with the desired icon
                      color: textLight,
                      size: 24, // Adjust size as needed
                    ),
                    SizedBox(width: 2),
                    Text(
                      'WayPoint',
                      style: TextStyle(
                        color: textLight,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(
                            'assets/images/profile.jpeg'), // Replace with your image path
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Vinove',
                            style: TextStyle(color: textLight, fontSize: 16),
                          ),
                          Text(
                            'vinove@gmail.com',
                            style: TextStyle(color: textLight),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],

              ),
            ),
            ListTile(
              leading: Icon(Icons.timer),
              title: Text('Timer'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Attendance'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text('Activity'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.timer_outlined),
              title: Text('Timesheet'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.assessment),
              title: Text('Report'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Jobsite'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('Team'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text('Time off'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text('Schedules'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.how_to_reg),
              title: Text('Request to Join Organisation'),
              onTap: () {
                // Handle logout
              },
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Change Password'),
              onTap: () {
                // Handle logout
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Handle logout
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('FAQ & Help'),
              onTap: () {
                // Handle logout
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text('Privacy Policy'),
              onTap: () {
                // Handle logout
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Version: 2,10(2)'),
              onTap: () {
                // Handle logout
              },
            ),
          ],
        ),
      ),


      body: ListView.builder(
        itemCount: fakeMembers.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              color: Colors.grey[200],
              child: ListTile(
                leading: Icon(Icons.groups),
                title: Text("All Members", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AllMembersScreen()),
                  );
                },
              ),
            );
          }
          final member = fakeMembers[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(member.imageAssetPath),
              radius: 20,
            ),
            title: Text('${member.name} (${member.id})'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Check-in: ${member.checkInTime ?? 'N/A'}'),
                Text('Check-out: ${member.checkOutTime ?? 'N/A'}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.calendar_today, color: const Color.fromARGB(255, 96, 39, 176)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapScreen2(
                          name: member.name,
                          latitude: member.latitude,
                          longitude: member.longitude,
                          visitedPlaces: member.visitedPlaces,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.my_location, color: Colors.orange),
                  onPressed: () async {
                    double randomDistance = 2000 + Random().nextDouble() * 1000; // 2 to 3 km
                    double randomDistanceInDegrees = randomDistance / 111000; // 1 degree ≈ 111 km
                    double randomAngle = Random().nextDouble() * 2 * pi;
                    double newLatitude = member.latitude + randomDistanceInDegrees * cos(randomAngle);
                    double newLongitude = member.longitude + randomDistanceInDegrees * sin(randomAngle);

                    newLatitude = newLatitude.clamp(-90.0, 90.0);
                    newLongitude = newLongitude.clamp(-180.0, 180.0);

                    String locationName = await _getLocationName(newLatitude, newLongitude);

                    if (!userVisitedLocations.containsKey(member.name)) {
                      userVisitedLocations[member.name] = [];
                    }

                    setState(() {
                      userVisitedLocations[member.name]!.add({
                        'latitude': newLatitude,
                        'longitude': newLongitude,
                        'name': locationName,
                      });
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapScreen(
                          latitude: newLatitude,
                          longitude: newLongitude,
                          name: member.name,
                          visitedLocations: userVisitedLocations[member.name]!,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MapScreen3(
                  members: fakeMembers,
                ),
              ),
            );
          },
          child: Text('Show All Members on Map'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 251, 232, 254),
          ),
        ),
      ),
    );
  }
}

class AllMembersScreen extends StatefulWidget {
  @override
  _AllMembersScreenState createState() => _AllMembersScreenState();
}

class _AllMembersScreenState extends State<AllMembersScreen> {
  List<Member> filteredMembers = fakeMembers;
  TextEditingController _searchController = TextEditingController();

  void _filterMembers(String query) {
    setState(() {
      filteredMembers = fakeMembers.where((member) {
        return member.name.toLowerCase().contains(query.toLowerCase()) ||
            member.id.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _filterMembers(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Members"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Members',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredMembers.length,
        itemBuilder: (context, index) {
          final member = filteredMembers[index];
          return ListTile(
            leading: CircleAvatar(
              radius: 18,
            ),
            title: Row(
              children: [
                Text("${member.name}"),
              ],
            ),
          );
        },
      ),
    );
  }
}
