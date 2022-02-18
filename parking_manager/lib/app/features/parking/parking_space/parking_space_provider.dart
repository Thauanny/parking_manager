import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_manager/app/bloc/app_bloc.dart';
import 'package:parking_manager/app/features/parking/bloc/parking_bloc.dart';
import 'package:parking_manager/app/features/parking/parking_space/parking_space_page.dart';

import '../../car/bloc/car_bloc.dart';
import '../model/parking.dart';

class ParkingSpaceProvider extends StatelessWidget {
  final Parking? parking;
  final AppBloc appBloc;
  final CarBloc carBloc;
  final ParkingBloc parkingBloc;
  const ParkingSpaceProvider(
      {Key? key,
      required this.appBloc,
      required this.parking,
      required this.carBloc,
      required this.parkingBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>.value(value: appBloc),
        BlocProvider<CarBloc>.value(value: carBloc),
        BlocProvider<ParkingBloc>.value(value: parkingBloc),
      ],
      child: ParkingSpacePage(parking: parking!),
    );
  }
}
