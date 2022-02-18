import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_manager/app/config/shared_preferences_config_parking.dart';
import 'package:parking_manager/app/features/parking/bloc/parking_bloc.dart';
import 'bloc/app_bloc.dart';
import 'config/shared_preferences_config_car.dart';
import 'features/car/bloc/car_bloc.dart';
import 'features/home/home_provider.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sharedPreferencesConfigCar =
        BlocProvider.of<SharedPreferencesConfigCar>(context);
    sharedPreferencesConfigCar.appSettings();
    final sharedPreferencesConfigParking =
        BlocProvider.of<SharedPreferencesConfigParking>(context);

    final parkingBloc =
        ParkingBloc(sharedPreferencesConfig: sharedPreferencesConfigParking);
    final carBloc = CarBloc(
        sharedPreferencesConfig: sharedPreferencesConfigCar,
        sharedPreferencesConfigParking: parkingBloc.sharedPreferencesConfig!);

    final appBloc = AppBloc(carBloc: carBloc, parkingBloc: parkingBloc);

    sharedPreferencesConfigParking.appSettings(parkingBloc, carBloc);

    return BlocProvider<AppBloc>(
      create: (context) => appBloc,
      child: HomeProvider(
        carBloc: carBloc,
        parkingBloc: parkingBloc,
        appBloc: appBloc,
      ),
    );
  }
}
