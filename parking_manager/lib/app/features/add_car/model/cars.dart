class Car {
  int parkedIn;
  String parkingName;
  final String modelAndColor;
  final String licensePlate;
  final DateTime checkIn;
  DateTime? checkOut;

  Car(
      {required this.checkIn,
      required this.modelAndColor,
      required this.licensePlate,
      required this.parkedIn,
      required this.parkingName});
}
