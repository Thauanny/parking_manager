part of 'parking_bloc.dart';

@immutable
abstract class ParkingState {}

class ParkingInitial extends ParkingState {}

class ParkingRemoveParkingRemoved extends ParkingState {}

class ParkingRemoveParkingError extends ParkingState {}

class ParkingAddPakingToListAdded extends ParkingState {}

class ParkingAddPakingToListError extends ParkingState {}

class ParkingAddPakingToListErrorAlreadyExist extends ParkingState {}

class ParkingLoadedEnded extends ParkingState {}

class ParkingLoadingProgress extends ParkingState {}
