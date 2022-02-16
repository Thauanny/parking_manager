import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../config/shared_preferences_config.dart';
import '../features/add_car/model/cars.dart';
import '../features/add_parking/model/parking.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final SharedPreferencesConfig? sharedPreferencesConfig;

  AppBloc({this.sharedPreferencesConfig}) : super(AppInitial());

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is AddPakingToList) {
      sharedPreferencesConfig!.setHistoryAndParkings('parking');
      sharedPreferencesConfig!.setHistoryAndParkings('history');
      try {
        if (!(sharedPreferencesConfig!.parkings
            .any((element) => element!.name == event.parking.name))) {
          sharedPreferencesConfig!.parkings.add(event.parking);
          sharedPreferencesConfig!.setHistoryAndParkings('parking');

          yield AddPakingToListAdded();
        } else {
          yield AddPakingToListErrorAlreadyExist();
        }
      } catch (e) {
        yield AddPakingToListError();
      }

      // sharedPreferencesConfig.noteListWithDeadline.add(
      //  Note(message: event.message, date: event.date, type: event.type));
      //  sharedPreferencesConfig.setNotes(event.type);

    } else if (event is AddCarToParkingList) {
      try {
        var parking = sharedPreferencesConfig!.parkings
            .firstWhere((element) => element!.name == event.value);
        parking!.cars!.add(event.car);
        sharedPreferencesConfig!.setHistoryAndParkings('parking');

        sharedPreferencesConfig!.history.add(event.car);
        sharedPreferencesConfig!.setHistoryAndParkings('history');

        yield AddCarToParkingListAdded();
      } catch (e) {
        yield AddCarToParkingListError();
      }
    } else if (event is MakeAddInital) {
      yield MakeAppInitalClicked();
    } else if (event is RemoveCarFromParking) {
      yield RemoveCarFromParkingRemoving();
      try {
        var _parking = event.parking;

        var car = _parking.cars!.elementAt(event.index);

        sharedPreferencesConfig!.history
            .firstWhere((element) =>
                element.parkedIn == car.parkedIn &&
                element.parkingName == car.parkingName)
            .checkOut = DateTime.now();

        sharedPreferencesConfig!.setHistoryAndParkings('history');
        sharedPreferencesConfig!.parkings
            .firstWhere((element) => element!.name == event.parking.name)!
            .cars!
            .removeAt(event.index);
        sharedPreferencesConfig!.setHistoryAndParkings('parking');

        yield RemoveCarFromParkingRemoved();
      } catch (e) {
        print(e);
        yield RemoveCarFromParkingError();
      }
    } else if (event is RemoveParking) {
      try {
        sharedPreferencesConfig!.parkings.remove(event.parking);

        sharedPreferencesConfig!.setHistoryAndParkings('parking');

        yield RemoveParkingRemoved();
      } catch (e) {
        yield RemoveParkingError();
      }
    } else if (event is ClearHistory) {
      try {
        sharedPreferencesConfig!.history
            .removeWhere((element) => element.checkOut != null);
        sharedPreferencesConfig!.setHistoryAndParkings('history');
        yield ClearHistorySucess();
      } catch (e) {
        yield ClearHistoryError();
      }
    }
  }
}
