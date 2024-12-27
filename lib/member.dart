class Member {
  final String name;
  final String id;
  final String status;
  final String? checkInTime;
  final String? checkOutTime;
  final double latitude;
  final double longitude;
  final List<VisitedPlace> visitedPlaces;  
  final String imageAssetPath;  
  Member({
    required this.name,
    required this.id,
    required this.status,
    this.checkInTime,
    this.checkOutTime,
    required this.latitude,
    required this.longitude,
    required this.visitedPlaces,  
    required this.imageAssetPath,  

  });
}

class VisitedPlace {
  final String name;
  final double latitude;
  final double longitude;

  VisitedPlace({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}

List<Member> fakeMembers = [
  Member(
    name: 'Vishesh Tanwar',
    id: 'WSL0003',
    status: 'WORKING',
    checkInTime: '09:30 am',
    latitude: 28.6454444444, 
    longitude: 77.1243888889,
    visitedPlaces: [
      VisitedPlace(name: "Office", latitude: 28.6454444444, longitude: 77.1243888889),
      VisitedPlace(name: "Client Site", latitude: 28.6480000, longitude: 77.1290000),
    ],
    imageAssetPath: 'assets/images/vishesh.jpeg',  

  ),
  Member(
    name: 'Himanshu Rawat',
    id: 'WSL0034',
    status: 'PRESENT',
    checkInTime: '09:30 am',
    checkOutTime: '06:40 pm',
    latitude: 28.6271944444,
    longitude: 77.1306944444,
    visitedPlaces: [
      VisitedPlace(name: "Office", latitude: 28.6454444444, longitude: 77.1243888889),
      VisitedPlace(name: "Client Site", latitude: 28.6480000, longitude: 77.1290000),
    ],
    imageAssetPath: 'assets/images/himanshu.jpeg',  
  
  ),
  Member( 
    name: 'Vishesh Tanwar',
    id: 'WSL0003',
    status: 'WORKING', 
    checkInTime: '09:30 am',
    latitude: 28.6454444444, 
    longitude: 77.1243888889,
    visitedPlaces: [
      VisitedPlace(name: "Office", latitude: 28.6454444444, longitude: 77.1243888889),
      VisitedPlace(name: "Client Site", latitude: 28.6480000, longitude: 77.1290000),
    ], 
    imageAssetPath: 'assets/images/vishesh.jpeg',  

  ),
  Member(
    name: 'Arun Williamson',
    id: 'WSL0054',
    status: 'NOT LOGGED-IN YET',
    latitude: 28.6423055556,
    longitude: 77.1259444444,
    visitedPlaces: [
      VisitedPlace(name: "Office", latitude: 28.6454444444, longitude: 77.1243888889),
      VisitedPlace(name: "Client Site", latitude: 28.6480000, longitude: 77.1290000),
    ],
    imageAssetPath: 'assets/images/arun.jpeg', 

  ),
  Member( 
    name: 'Ayush Gilberg',
    id: 'WSL0054',
    status: 'NOT LOGGED-IN YET',
    latitude: 28.6728611111,
    longitude: 77.1373611111,
    visitedPlaces: [
      VisitedPlace(name: "Office", latitude: 28.6454444444, longitude: 77.1243888889),
      VisitedPlace(name: "Client Site", latitude: 28.6480000, longitude: 77.1290000),
    ],
    imageAssetPath: 'assets/images/ayush.jpeg',  

  ),
]; 
