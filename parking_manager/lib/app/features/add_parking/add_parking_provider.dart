import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_manager/app/features/add_parking/add_parking_page.dart';

import '../../bloc/app_bloc.dart';

class AddParkingProvider extends StatelessWidget {
  final AppBloc appBloc;
  const AddParkingProvider({Key? key, required this.appBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>.value(
        value: appBloc, child: const AddParkingPage());
  }
}
