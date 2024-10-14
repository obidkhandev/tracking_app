import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'tracking_state.dart';

class TrackingCubit extends Cubit<TrackingState> {
  TrackingCubit() : super(const TrackingState(totalDistance: 0, waitingDuration: Duration()));

  Position? _lastPosition;
  double _totalDistance = 0;
  Timer? _waitingTimer;
  Duration _waitingDuration = Duration();
  bool _isWaiting = false;

  Future<void> startTracking() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if GPS service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(state.copyWith(errorMessage: 'GPS xizmatlari o‘chirilgan.'));
      return;
    }

    // Check location permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(state.copyWith(errorMessage: 'Geolokatsiya ruxsatlari rad etilgan.'));
        return;
      }
    }

    // If permission is permanently denied, show an error
    if (permission == LocationPermission.deniedForever) {
      emit(state.copyWith(errorMessage: 'Geolokatsiya ruxsatlari doimiy ravishda rad etilgan.'));
      return;
    }

    // If permission is granted, start tracking
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

      // Check speed and handle waiting timer
      _checkSpeedAndHandleWaiting(position.speed);

      // Emit the updated state with the new total distance and waiting duration
      emit(state.copyWith(totalDistance: _totalDistance, waitingDuration: _waitingDuration));

      // Optionally print debug info
      print('Umumiy o‘tgan masofa: $_totalDistance metr');
      print('Joriy Latitude: ${_lastPosition!.latitude}');
      print('Joriy Longitude: ${_lastPosition!.longitude}');
    });
  }

  void startWaiting() {
    _isWaiting = true;
    _waitingDuration = Duration();
    _waitingTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _waitingDuration += Duration(seconds: 1);
      emit(state.copyWith(waitingDuration: _waitingDuration));
    });
  }

  void stopWaiting() {
    _waitingTimer?.cancel();
    _isWaiting = false;
  }

  void _checkSpeedAndHandleWaiting(double speed) {
    // Speed in m/s
    if (_isWaiting && speed > 30 / 3.6) { // 30 km/h to m/s
      stopWaiting();
    } else if (!_isWaiting && speed < 5 / 3.6) { // 5 km/h to m/s as a threshold to start waiting
      startWaiting();
    }
  }

  @override
  Future<void> close() {
    _waitingTimer?.cancel();
    return super.close();
  }
}
