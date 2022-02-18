import '../features/parking/model/parking.dart';

bool isParkingSpaceFree(Parking parking, String text, String value) {
  if (parking.cars != null) {
    return (parking.cars!.any((element) =>
        (text.isNotEmpty) &&
        (element.parkedIn.toString() == text) &&
        element.parkingName == value));
  }
  return false;
}
