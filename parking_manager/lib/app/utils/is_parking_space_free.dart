import '../features/parking/add_parking/model/parking.dart';

bool isParkingSpaceFree(Parking parking, String text, String value) =>
    (parking.cars!.any((element) =>
        (text.isNotEmpty) &&
        (element.parkedIn.toString() == text) &&
        element.parkingName == value));
