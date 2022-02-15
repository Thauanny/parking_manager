import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/app_bloc.dart';
import '../features/add_car/model/cars.dart';
import '../features/add_parking/model/parking.dart';

class SharedPreferencesConfig extends AppBloc {
  SharedPreferences? _prefs;

  List<Car> history = [];
  List<Parking> parkings = [];

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
    final String? encodedGetHistory = _prefs!.getString('history');
    history = Car.decode(encodedGetHistory!) ?? [];
    final String? encodedParking = _prefs!.getString('parkikngs');
    parkings = Parking.decode(encodedParking!) ?? [];
  }

  setHistoryAndParkings(String type) async {
    try {
      switch (type) {
        case 'history':
          await _prefs!.setString('history', Car.encode(history)!);
          break;
        case 'parking':
          await _prefs!.setString('parkikngs', Parking.encode(parkings)!);
          break;
      }

      await _readHistoryAndParking();
    } catch (e) {
      print(e);
    }
  }
}
