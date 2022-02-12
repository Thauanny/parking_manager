class Cars {
  int? parkedIn;
  String? parkingName;
  final String modelAndColor;
  final String licensePlate;
  final DateTime checkIn;
  DateTime? checkOut;

  Cars(
      {required this.checkIn,
      required this.modelAndColor,
      required this.licensePlate});
}
