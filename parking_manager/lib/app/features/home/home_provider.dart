import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/app_bloc.dart';
import '../car/bloc/car_bloc.dart';
import '../parking/bloc/parking_bloc.dart';
import 'home_page.dart';

class HomeProvider extends StatelessWidget {
  final AppBloc appBloc;
  final CarBloc carBloc;
  final ParkingBloc parkingBloc;
  const HomeProvider(
      {Key? key,
      required this.appBloc,
      required this.carBloc,
      required this.parkingBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<AppBloc>.value(value: appBloc),
      BlocProvider<CarBloc>.value(value: carBloc),
      BlocProvider<ParkingBloc>.value(value: parkingBloc),
    ], child: const HomePage());
  }
}
