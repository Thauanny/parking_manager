import 'package:parking_manager/app/features/parking/model/parking.dart';
import 'package:collection/collection.dart';
import '../features/car/model/car.dart';

void setCarsInParkings(
    {required List<Parking?> parkings, required List<Car?> history}) {
  if (parkings.isNotEmpty) {
    for (var parking in parkings) {
      if (parking!.cars == null) {
        parking.cars = [];
      }
    }

    for (var car in history) {
      Parking? parking = parkings.firstWhereOrNull(
        (parking) => car!.parkingName == parking!.name && car.checkOut == null,
      );
      if (parking != null) {
        parking.cars!.add(car!);
      }
    }
  }
}
