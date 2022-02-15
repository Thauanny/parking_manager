import 'dart:convert';

import '../../../utils/date_time_format.dart';

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
      required this.parkingName,
      this.checkOut});

  Map<String, dynamic> toMap() {
    return {
      'parkedIn': parkedIn,
      'parkingName': parkingName,
      'modelAndColor': modelAndColor,
      'licensePlate': licensePlate,
      'checkIn': dateTimeFormatToString(checkIn),
      'checkOut': checkOut == null ? null : dateTimeFormatToString(checkOut!),
    };
  }

  factory Car.fromJson(Map<dynamic, dynamic> jsonData) {
    return Car(
        parkedIn: jsonData['parkedIn'],
        parkingName: jsonData['parkingName'],
        licensePlate: jsonData['licensePlate'],
        modelAndColor: jsonData['modelAndColor'],
        checkIn: dateTimeFormatToDateTime(jsonData['checkIn']),
        checkOut: jsonData['checkOut'] == "null"
            ? null
            : dateTimeFormatToDateTime(jsonData['checkOut']));
  }

  static String? encode(List<Car> car) {
    try {
      return json.encode(
        car.map<Map<dynamic, dynamic>>((car) => car.toMap()).toList(),
      );
    } catch (e) {
      print(e);
      return '';
    }
  }

  static Map<String, dynamic> makeMap(Car car) => {
        'parkedIn': car.parkedIn,
        'parkingName': car.parkingName,
        'modelAndColor': car.modelAndColor,
        'licensePlate': car.licensePlate,
        'checkIn': dateTimeFormatToString(car.checkIn),
        'checkOut':
            car.checkOut == null ? null : dateTimeFormatToString(car.checkOut!)
      };
  static List<Car>? decode(String car) {
    try {
      return (json.decode(car) as List<dynamic>)
          .map<Car>((item) => Car.fromJson(item))
          .toList();
    } catch (e) {
      print(e);
      return [];
    }
  }
}
