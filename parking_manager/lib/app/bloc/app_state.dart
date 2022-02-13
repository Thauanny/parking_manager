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
