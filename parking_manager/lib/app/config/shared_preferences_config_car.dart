import 'package:parking_manager/app/config/shared_preferences_config_parking.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/car/bloc/car_bloc.dart';
import '../features/car/model/car.dart';

class SharedPreferencesConfigCar extends CarBloc {
  SharedPreferences? _prefs;

  List<Car> history = [];

  SharedPreferencesConfigCar(
      {required SharedPreferencesConfigParking? sharedPreferencesConfigParking})
      : super(sharedPreferencesConfigParking: sharedPreferencesConfigParking);

  appSettings() {
    _startSettings();
  }

  _startSettings() async {
    await _startSharedPreferences();

    await _readHistoryAndParking();
  }

  Future<void> _startSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  _readHistoryAndParking() {
    try {
      final String? encodedGetHistory = _prefs!.getString('history');
      history = Car.decode(encodedGetHistory ?? '[]') ?? [];
    } catch (e) {
      history = [];
    }
  }

  void setHistoryAndParkings(String type) async {
    await _prefs!.setString('history', Car.encode(history)!);

    await _readHistoryAndParking();
  }
}
