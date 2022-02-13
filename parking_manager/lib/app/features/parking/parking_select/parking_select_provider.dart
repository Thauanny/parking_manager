import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_manager/app/bloc/app_bloc.dart';

import 'parking_select_page.dart';

class ParkingSelectProvider extends StatelessWidget {
  final AppBloc appBloc;
  const ParkingSelectProvider({Key? key, required this.appBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
        create: (context) => appBloc, child: const ParkingSelectPage());
  }
}
