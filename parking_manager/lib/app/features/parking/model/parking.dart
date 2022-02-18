import 'dart:convert';

import '../../car/model/car.dart';

class Parking {
  int id = DateTime.now().microsecond;
  final String name;
  final int coutParkingSpaces;
  List<Car>? cars;

  Parking({required this.coutParkingSpaces, required this.name, this.cars});

  Map<String?, dynamic> toMap(Parking parking) {
    return {
      'name': name,
      'coutParkingSpaces': coutParkingSpaces,
    };
  }

  factory Parking.fromJson(Map<String, dynamic> jsonData) {
    return Parking(
      name: jsonData['name'],
      coutParkingSpaces: jsonData['coutParkingSpaces'],
    );
  }

  static String? encode(List<Parking?> parking) {
    try {
      return json.encode(parking
          .map<Map<String?, dynamic>>((parking) => parking!.toMap(parking))
          .toList());
    } catch (e) {
      return '';
    }
  }

  static List<Parking>? decode(String parking) {
    var decode = (json.decode(parking));
    try {
      return decode.map<Parking>((item) => Parking.fromJson(item)).toList();
    } catch (e) {
      return null;
    }
  }
}
