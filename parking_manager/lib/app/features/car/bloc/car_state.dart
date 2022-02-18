part of 'car_bloc.dart';

@immutable
abstract class CarState {}

class CarInitial extends CarState {}

class CarClearHistoryError extends CarState {}

class CarClearHistorySucess extends CarState {}

class CarAddCarToParkingListAdded extends CarState {}

class CarAddCarToParkingListError extends CarState {}

class CarRemoveCarFromParkingRemoved extends CarState {}

class CarRemoveCarFromParkingError extends CarState {}

class CarRemoveCarFromParkingRemoving extends CarState {}
