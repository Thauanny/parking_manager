import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/app_bloc.dart';
import '../features/add_car/model/cars.dart';
import '../features/add_parking/model/parking.dart';
import 'package:collection/collection.dart';

class SharedPreferencesConfig extends AppBloc {
  SharedPreferences? _prefs;

  List<Car> history = [];
  List<Parking?> parkings = [];

  appSettings() {
    _startSettings();
  }

  _startSettings() async {
    await _startSharedPreferences();

    await _readHistoryAndParking();

    add(HistoryAndParkingLoadedEvent());
  }

  Future<void> _startSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  _readHistoryAndParking() {
    try {
      final String? encodedGetHistory = _prefs!.getString('history');
      history = Car.decode(encodedGetHistory ?? '[]') ?? [];

      final String? encodedParking = _prefs!.getString('parking');
      parkings = Parking.decode(encodedParking ?? '[]') ?? [];

      setCarsInParkings();
    } catch (e) {
      history = [];
      parkings = [];
    }
  }

  void setHistoryAndParkings(String type) async {
    try {
      switch (type) {
        case 'history':
          await _prefs!.setString('history', Car.encode(history)!);
          break;
        case 'parking':
          await _prefs!.setString('parking', Parking.encode(parkings)!);
          break;
      }

      await _readHistoryAndParking();
    } catch (e) {
      print(e);
    }
  }

  void setCarsInParkings() {
    if (parkings.isNotEmpty) {
      for (var parking in parkings) {
        parking!.cars = [];
      }

      for (var car in history) {
        Parking? parking = parkings.firstWhereOrNull(
          (parking) => car.parkingName == parking!.name && car.checkOut == null,
        );
        if (parking != null) {
          parking.cars!.add(car);
        }
      }
    }
  }
}
