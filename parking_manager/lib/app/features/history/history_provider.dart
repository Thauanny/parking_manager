import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/app_bloc.dart';
import 'history_page.dart';

class HistoryProvider extends StatelessWidget {
  final parking;
  final AppBloc appBloc;
  const HistoryProvider(
      {Key? key, required this.appBloc, required this.parking})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>.value(
        value: appBloc,
        child: HistoryPage(
          parking: parking,
        ));
  }
}
