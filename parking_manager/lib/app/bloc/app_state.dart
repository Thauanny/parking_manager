part of 'app_bloc.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class AddPakingToListAdded extends AppState {}

class AddPakingToListError extends AppState {}

class AddPakingToListErrorAlreadyExist extends AppState {}

class AddCarToParkingListAdded extends AppState {}

class AddCarToParkingListError extends AppState {}

class MakeAppInitalClicked extends AppState {}

class RemoveCarFromParkingRemoved extends AppState {}

class RemoveCarFromParkingError extends AppState {}

class RemoveCarFromParkingRemoving extends AppState {}

class RemoveParkingRemoved extends AppState {}

class RemoveParkingError extends AppState {}
