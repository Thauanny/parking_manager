import 'dart:convert';

import '../../add_car/model/cars.dart';

class Parking {
  final String name;
  final int coutParkingSpaces;
  final List cars;

  Parking(
      {required this.coutParkingSpaces,
      required this.name,
      required this.cars});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'coutParkingSpaces': coutParkingSpaces,
      'cars': cars.map((element) {
        Car.makeMap(element);
      })
    };
  }

  factory Parking.fromJson(Map<String, dynamic> jsonData) {
    return Parking(
      name: jsonData['name'],
      coutParkingSpaces: jsonData['coutParkingSpaces'],
      cars: (jsonData['cars'] as List<dynamic>)
          .map((car) => Car.fromJson(car))
          .toList(),
    );
  }

  static String? encode(List<Parking> parking) {
    try {
      return json.encode(
        parking
            .map<Map<String, dynamic>>((parking) => parking.toMap())
            .toList(),
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  static List<Parking>? decode(String parking) {
    try {
      return (json.decode(parking) as List<dynamic>)
          .map<Parking>((item) => Parking.fromJson(item))
          .toList();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
