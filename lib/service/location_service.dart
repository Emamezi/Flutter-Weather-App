import 'package:location/location.dart';

class LocationService {
  UserLocation _userLocation;

  Future<UserLocation> getUserCurrentLocation() async {
    final userLoc = await Location().getLocation();
    _userLocation =
        UserLocation(longitude: userLoc.longitude, latitude: userLoc.latitude);
    return _userLocation;
  }
}

class UserLocation {
  final double longitude;
  final double latitude;

  UserLocation({
    this.longitude,
    this.latitude,
  });
}
