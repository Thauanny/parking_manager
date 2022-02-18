part of 'parking_bloc.dart';

@immutable
abstract class ParkingEvent {}

class ParkingAddPakingToList extends ParkingEvent {
  final Parking parking;

  ParkingAddPakingToList({required this.parking});
}

class ParkingRemoveParking extends ParkingEvent {
  final Parking? parking;

  ParkingRemoveParking({required this.parking});
}

class ParkingLoaded extends ParkingEvent {}

class ParkingLoading extends ParkingEvent {}

class MakeParkingInital extends ParkingEvent {}
