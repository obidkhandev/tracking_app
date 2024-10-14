part of 'tracking_cubit.dart';

class TrackingState extends Equatable {
  final double totalDistance;
  final Duration waitingDuration; // Added waiting duration property
  final String? errorMessage;

  const TrackingState({
    required this.totalDistance,
    this.waitingDuration = Duration.zero, // Default to zero duration
    this.errorMessage,
  });

  TrackingState copyWith({
    double? totalDistance,
    Duration? waitingDuration, // Added waiting duration to copyWith
    String? errorMessage,
  }) {
    return TrackingState(
      totalDistance: totalDistance ?? this.totalDistance,
      waitingDuration: waitingDuration ?? this.waitingDuration, // Handle waiting duration
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [totalDistance, waitingDuration, errorMessage]; // Include waiting duration in props
}
