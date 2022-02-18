import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_manager/app/features/parking/bloc/parking_bloc.dart';

import '../../../bloc/app_bloc.dart';

import '../../car/bloc/car_bloc.dart';
import 'add_parking_page.dart';

class AddParkingProvider extends StatelessWidget {
  final AppBloc appBloc;
  final ParkingBloc parkingBloc;
  final CarBloc carBloc;
  const AddParkingProvider(
      {Key? key,
      required this.appBloc,
      required this.parkingBloc,
      required this.carBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>.value(value: appBloc),
        BlocProvider<ParkingBloc>.value(value: parkingBloc),
        BlocProvider<CarBloc>.value(value: carBloc),
      ],
      child: const AddParkingPage(),
    );
  }
}
