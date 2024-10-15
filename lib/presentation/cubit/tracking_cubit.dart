import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

part 'tracking_state.dart';

class TrackingCubit extends Cubit<TrackingState> {
  static const double minimumDistanceThreshold = 0.8; // Minimum meter
  static const double minimumSpeedThreshold = 0.5; // Minimum speed (0.5 m/s)

  TrackingCubit() : super(const TrackingState(totalDistance: 0, waitingDuration: Duration()));

  Position? _lastPosition;
  double _totalDistance = 0;
  Timer? _waitingTimer;
  Duration _waitingDuration = const Duration();
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

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(state.copyWith(errorMessage: 'Geolokatsiya ruxsatlari rad etilgan.'));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      emit(state.copyWith(errorMessage: 'Geolokatsiya ruxsatlari doimiy ravishda rad etilgan.'));
      return;
    }

    Geolocator.getPositionStream().listen((Position position) {
      _handlePosition(position);

      emit(state.copyWith(totalDistance: _totalDistance, waitingDuration: _waitingDuration));


      debugPrint('Umumiy o‘tgan masofa: $_totalDistance metr');
      debugPrint('Joriy Latitude: ${_lastPosition!.latitude}');
      debugPrint('Joriy Longitude: ${_lastPosition!.longitude}');
    });
  }

  void _handlePosition(Position position) {
    if (_lastPosition != null) {
      // Calculate distance
      double distance = Geolocator.distanceBetween(
        _lastPosition!.latitude,
        _lastPosition!.longitude,
        position.latitude,
        position.longitude,
      );

      debugPrint("Speed: ${position.speed}");

      if (distance > minimumDistanceThreshold && position.speed > minimumSpeedThreshold) {
        _totalDistance += distance;
        _lastPosition = position;
        stopWaiting();
      } else {

        _checkSpeedAndHandleWaiting(position.speed);
      }
    } else {

      _lastPosition = position;
    }
  }

  void _checkSpeedAndHandleWaiting(double speed) {
    // Speed in m/s
    if (_isWaiting && speed > 30 / 3.6) { // 30 km/h to m/s
      stopWaiting();
    } else if (!_isWaiting && speed < 5 / 3.6) { // 5 km/h to m/s
      startWaiting();
    }
  }

  void startWaiting() {
    if (!_isWaiting) {
      _isWaiting = true;
      _waitingDuration = state.waitingDuration;
      _waitingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _waitingDuration += const Duration(seconds: 1);
        emit(state.copyWith(waitingDuration: _waitingDuration));
      });
    }
  }

  void stopWaiting() {
    if (_isWaiting) {
      _waitingTimer?.cancel();
      _isWaiting = false;
    }
  }

  @override
  Future<void> close() {
    _waitingTimer?.cancel();
    return super.close();
  }
}
