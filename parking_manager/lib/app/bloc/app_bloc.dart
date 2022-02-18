import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:parking_manager/app/features/car/bloc/car_bloc.dart';
import 'package:parking_manager/app/features/parking/bloc/parking_bloc.dart';
import '../config/shared_preferences_config_car.dart';

import '../features/car/model/car.dart';
import '../features/parking/model/parking.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final CarBloc carBloc;
  final ParkingBloc parkingBloc;
  AppBloc({required this.carBloc, required this.parkingBloc})
      : super(AppInitial());

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is MakeAddInital) {
      yield AppInitial();
    }
  }
}
