part of 'car_bloc.dart';

@immutable
abstract class CarEvent {}

class CarClearHistory extends CarEvent {}

class CarClearCheckoutHistory extends CarEvent {}

class CarAddCarToParkingList extends CarEvent {
  final Car car;
  final String value;

  CarAddCarToParkingList({required this.car, required this.value});
}

class CarRemoveCarFromParking extends CarEvent {
  final Car car;
  final Parking parking;

  CarRemoveCarFromParking({
    required this.car,
    required this.parking,
  });
}

class MakeCarInital extends CarEvent {}
