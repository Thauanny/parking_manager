import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../config/shared_preferences_config_parking.dart';
import '../model/parking.dart';

part 'parking_event.dart';
part 'parking_state.dart';

class ParkingBloc extends Bloc<ParkingEvent, ParkingState> {
  final SharedPreferencesConfigParking? sharedPreferencesConfig;

  ParkingBloc({this.sharedPreferencesConfig}) : super(ParkingInitial());

  @override
  Stream<ParkingState> mapEventToState(
    ParkingEvent event,
  ) async* {
    if (event is ParkingLoading) {
      yield ParkingLoadingProgress();
    } else if (event is ParkingLoaded) {
      yield ParkingLoadedEnded();
    }

    if (event is ParkingAddPakingToList) {
      sharedPreferencesConfig!.setHistoryAndParkings('parking');

      try {
        if (!(sharedPreferencesConfig!.parkings
            .any((element) => element!.name == event.parking.name))) {
          sharedPreferencesConfig!.parkings.add(event.parking);
          event.parking.cars = [];
          sharedPreferencesConfig!.setHistoryAndParkings('parking');

          yield ParkingAddPakingToListAdded();
        } else {
          yield ParkingAddPakingToListErrorAlreadyExist();
        }
      } catch (e) {
        yield ParkingAddPakingToListError();
      }
    } else if (event is ParkingRemoveParking) {
      try {
        print(sharedPreferencesConfig!.parkings);

        sharedPreferencesConfig!.parkings
            .removeWhere((element) => element!.id == event.parking!.id);
        print(sharedPreferencesConfig!.parkings);
        sharedPreferencesConfig!.setHistoryAndParkings('parking');
        print(sharedPreferencesConfig!.parkings);

        yield ParkingRemoveParkingRemoved();
      } catch (e) {
        yield ParkingRemoveParkingError();
      }
    } else if (event is MakeParkingInital) {
      yield ParkingInitial();
    }
  }
}
