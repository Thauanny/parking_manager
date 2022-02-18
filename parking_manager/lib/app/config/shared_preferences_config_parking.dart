import 'package:parking_manager/app/features/parking/bloc/parking_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/car/bloc/car_bloc.dart';
import '../features/parking/model/parking.dart';
import '../utils/set_cars_in_parkings.dart';

class SharedPreferencesConfigParking extends ParkingBloc {
  SharedPreferences? _prefs;

  List<Parking?> parkings = [];
  late ParkingBloc parkingBloc;
  late CarBloc carBloc;

  appSettings(ParkingBloc _parkingBloc, CarBloc _carBloc) async {
    parkingBloc = _parkingBloc;
    carBloc = _carBloc;
    parkingBloc.add(ParkingLoading());
    await _startSettings();
    parkingBloc.add(ParkingLoaded());
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
      final String? encodedParking = _prefs!.getString('parking');
      parkings = Parking.decode(encodedParking ?? '[]') ?? [];
      setCarsInParkings(
          parkings: parkingBloc.sharedPreferencesConfig!.parkings,
          history: carBloc.sharedPreferencesConfig!.history);
    } catch (e) {
      parkings = [];
    }
  }

  void setHistoryAndParkings(String type) async {
    await _prefs!.setString('parking', Parking.encode(parkings)!);

    await _readHistoryAndParking();
  }
}
