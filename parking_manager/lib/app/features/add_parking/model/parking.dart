import '../../add_car/model/cars.dart';

class Parking {
  final String name;
  final int coutParkingSpaces;
  final List<Car> cars;

  Parking(
      {required this.coutParkingSpaces,
      required this.name,
      required this.cars});
}
