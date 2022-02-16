import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/app_bloc.dart';
import 'history_page.dart';

class CarHistoryProvider extends StatelessWidget {
  final AppBloc appBloc;
  const CarHistoryProvider({Key? key, required this.appBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>.value(
        value: appBloc, child: const HistoryPage());
  }
}
