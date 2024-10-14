import 'package:geolocator/geolocator.dart';

class LocationService {
  Position? _lastPosition;
  double _totalDistance = 0;

  Future<void> startTracking() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('GPS xizmatlari o‘chirilgan.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Geolokatsiya ruxsatlari rad etilgan.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Geolokatsiya ruxsatlari doimiy ravishda rad etilgan.');
    }

    Geolocator.getPositionStream().listen((Position position) {
      if (_lastPosition != null) {
        _totalDistance += Geolocator.distanceBetween(
          _lastPosition!.latitude,
          _lastPosition!.longitude,
          position.latitude,
          position.longitude,
        );
      }

      _lastPosition = position;

      print('Umumiy o‘tgan masofa: $_totalDistance metr');
      print('Joriy Latitude: ${_lastPosition!.latitude}');
      print('Joriy Longitude: ${_lastPosition!.longitude}');
    });
  }

  double getTotalDistance() {
    return _totalDistance;
  }
}
