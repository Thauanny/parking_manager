import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_manager/app/bloc/app_bloc.dart';
import 'package:parking_manager/app/features/add_parking/model/parking.dart';
import 'package:parking_manager/app/features/parking/parking_space/parking_space_page.dart';

class ParkingSpaceProvider extends StatelessWidget {
  final Parking parking;
  final AppBloc appBloc;
  const ParkingSpaceProvider(
      {Key? key, required this.appBloc, required this.parking})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
        create: (context) => appBloc,
        child: ParkingSpacePage(parking: parking));
  }
}
