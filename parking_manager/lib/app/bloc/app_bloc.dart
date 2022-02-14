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

  List<Parking> _parkingLots = [];
  List<Parking> _historyList = [];
  List<Parking> get parkingLots => _parkingLots;
  List<Parking> get historyList => _historyList;

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is AddPakingToList) {
      try {
        if (!(_parkingLots
            .any((element) => element.name == event.parking.name))) {
          _parkingLots.add(event.parking);
          //_historyList.add(List.from(_parkingLots).last);
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
        var parking =
            _parkingLots.firstWhere((element) => element.name == event.value);
        parking.cars.add(event.car);

        _historyList.add(List.from(_parkingLots).last);
        yield AddCarToParkingListAdded();
      } catch (e) {
        yield AddCarToParkingListError();
      }
    } else if (event is MakeAddInital) {
      yield MakeAppInitalClicked();
    } else if (event is RemoveCarFromParking) {
      yield RemoveCarFromParkingRemoving();
      try {
        var _parking = _parkingLots
            .firstWhere((element) => element.name == event.parking.name);
        _parking.cars.removeAt(event.index);

        yield RemoveCarFromParkingRemoved();
      } catch (e) {
        yield RemoveCarFromParkingError();
      }
    }
  }
}
