import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_manager/app/bloc/app_bloc.dart';

import '../../car/bloc/car_bloc.dart';
import '../bloc/parking_bloc.dart';
import 'parking_select_page.dart';

class ParkingSelectProvider extends StatelessWidget {
  final AppBloc appBloc;
  final CarBloc carBloc;
  final ParkingBloc parkingBloc;
  const ParkingSelectProvider(
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
        BlocProvider<CarBloc>.value(value: carBloc),
        BlocProvider<ParkingBloc>.value(value: parkingBloc),
      ],
      child: const ParkingSelectPage(),
    );
  }
}
