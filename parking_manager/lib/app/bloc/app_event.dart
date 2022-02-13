part of 'app_bloc.dart';

@immutable
abstract class AppEvent {}

class AddPakingToList extends AppEvent {
  final Parking parking;

  AddPakingToList({required this.parking});
}

class AddCarToParkingList extends AppEvent {
  final Car car;
  final String value;

  AddCarToParkingList({required this.car, required this.value});
}

class MakeAddInital extends AppEvent {}
