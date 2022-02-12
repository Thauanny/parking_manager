import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_manager/app/bloc/app_bloc.dart';
import 'package:parking_manager/app/features/parking_space/parking_space_page.dart';

class ParkingSpaceProvider extends StatelessWidget {
  final AppBloc appBloc;
  const ParkingSpaceProvider({Key? key, required this.appBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
        create: (context) => appBloc, child: const ParkingSpacePage());
  }
}
