import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/app_bloc.dart';
import '../bloc/car_bloc.dart';
import 'history_page.dart';

class CarHistoryProvider extends StatelessWidget {
  final AppBloc appBloc;
  final CarBloc carBloc;
  const CarHistoryProvider(
      {Key? key, required this.appBloc, required this.carBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>.value(value: appBloc),
        BlocProvider<CarBloc>.value(value: carBloc),
      ],
      child: const CarHistoryPage(),
    );
  }
}
