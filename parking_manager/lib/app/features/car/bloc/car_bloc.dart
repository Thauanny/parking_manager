import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:parking_manager/app/config/shared_preferences_config_parking.dart';

import '../../../config/shared_preferences_config_car.dart';
import '../../parking/model/parking.dart';
import '../model/car.dart';

part 'car_event.dart';
part 'car_state.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final SharedPreferencesConfigCar? sharedPreferencesConfig;
  final SharedPreferencesConfigParking? sharedPreferencesConfigParking;

  CarBloc(
      {this.sharedPreferencesConfig,
      required this.sharedPreferencesConfigParking})
      : super(CarInitial());

  @override
  Stream<CarState> mapEventToState(
    CarEvent event,
  ) async* {
    if (event is MakeCarInital) {
      yield CarInitial();
    } else if (event is CarClearCheckoutHistory) {
      try {
        sharedPreferencesConfig!.history
            .removeWhere((element) => element.checkOut != null);
        sharedPreferencesConfig!.setHistoryAndParkings('history');
        yield CarClearHistorySucess();
      } catch (e) {
        yield CarClearHistoryError();
      }
    } else if (event is CarClearHistory) {
      sharedPreferencesConfig!.history.clear();
      sharedPreferencesConfig!.setHistoryAndParkings('history');
      yield CarClearHistorySucess();
    } else if (event is CarAddCarToParkingList) {
      try {
        var parking = sharedPreferencesConfigParking!.parkings
            .firstWhere((element) => element!.name == event.value);
        if (parking!.cars == null) {
          parking.cars = [];
        }
        parking.cars!.add(event.car);
        sharedPreferencesConfig!.setHistoryAndParkings('parking');

        sharedPreferencesConfig!.history.add(event.car);
        sharedPreferencesConfig!.setHistoryAndParkings('history');

        yield CarAddCarToParkingListAdded();
      } catch (e) {
        yield CarAddCarToParkingListError();
      }
    } else if (event is CarRemoveCarFromParking) {
      yield CarRemoveCarFromParkingRemoving();
      try {
        var _parking = event.parking;

        var car = _parking.cars!.elementAt(event.index);

        sharedPreferencesConfig!.history
            .firstWhere((element) =>
                element.parkedIn == car.parkedIn &&
                element.parkingName == car.parkingName)
            .checkOut = DateTime.now();

        if (_parking.cars != null) {
          _parking.cars!
              .firstWhere((element) =>
                  element.parkedIn == car.parkedIn &&
                  element.parkingName == car.parkingName)
              .checkOut = DateTime.now();
        }

        sharedPreferencesConfig!.setHistoryAndParkings('history');
        sharedPreferencesConfigParking!.parkings
            .firstWhere((element) => element!.name == event.parking.name)!
            .cars!
            .removeAt(event.index);
        sharedPreferencesConfigParking!.setHistoryAndParkings('parking');

        yield CarRemoveCarFromParkingRemoved();
      } catch (e) {
        yield CarRemoveCarFromParkingError();
      }
    }
  }
}
